package fr.cg95.cvq.service.request.impl;

import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationListener;

import fr.capwebct.capdemat.DocumentType;
import fr.capwebct.capdemat.GetDocumentListResponseDocument;
import fr.capwebct.capdemat.GetDocumentResponseDocument;
import fr.capwebct.capdemat.GetDocumentListResponseDocument.GetDocumentListResponse;
import fr.capwebct.capdemat.GetDocumentResponseDocument.GetDocumentResponse;
import fr.cg95.cvq.business.document.Document;
import fr.cg95.cvq.business.document.DocumentAction;
import fr.cg95.cvq.business.request.external.RequestExternalAction;
import fr.cg95.cvq.business.request.external.RequestExternalActionState;
import fr.cg95.cvq.business.document.DocumentState;
import fr.cg95.cvq.business.request.Request;
import fr.cg95.cvq.business.request.RequestDocument;
import fr.cg95.cvq.business.request.RequestEvent;
import fr.cg95.cvq.dao.request.IRequestDAO;
import fr.cg95.cvq.exception.CvqException;
import fr.cg95.cvq.exception.CvqObjectNotFoundException;
import fr.cg95.cvq.security.PermissionException;
import fr.cg95.cvq.security.SecurityContext;
import fr.cg95.cvq.security.annotation.Context;
import fr.cg95.cvq.security.annotation.ContextPrivilege;
import fr.cg95.cvq.security.annotation.ContextType;
import fr.cg95.cvq.service.document.IDocumentService;
import fr.cg95.cvq.service.document.IDocumentTypeService;
import fr.cg95.cvq.service.request.IRequestDocumentService;
import fr.cg95.cvq.service.request.external.IRequestExternalService;
import fr.cg95.cvq.service.request.external.IRequestExternalActionService;
import fr.cg95.cvq.service.request.IRequestSearchService;
import fr.cg95.cvq.util.translation.ITranslationService;

public class RequestDocumentService implements IRequestDocumentService, ApplicationListener<RequestEvent> {

    private static Logger logger = Logger.getLogger(RequestDocumentService.class);
    
    private IRequestDAO requestDAO;

    private IRequestExternalService requestExternalService;
    private IRequestSearchService requestSearchService;
    private IRequestExternalActionService requestExternalActionService;
    private IDocumentService documentService;
    private ITranslationService translationService;
    private IDocumentTypeService documentTypeService;

    @Deprecated
    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT}, privilege = ContextPrivilege.WRITE)
    public void addDocuments(final Long requestId, final Set<Long> documentsId)
        throws CvqException, CvqObjectNotFoundException {

        Request request = getById(requestId);
        for (Long documentId : documentsId)
            request.getDocuments().add(new RequestDocument(documentId));

        updateLastModificationInformation(request);
    }

    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT, ContextType.UNAUTH_ECITIZEN}, privilege = ContextPrivilege.WRITE)
    public void addDocument(final Long requestId, final Long documentId)
        throws CvqException, CvqObjectNotFoundException {
        addDocument(getById(requestId), documentId);
    }

    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT, ContextType.UNAUTH_ECITIZEN}, privilege = ContextPrivilege.WRITE)
    public void addDocument(Request request, final Long documentId)
        throws CvqException, CvqObjectNotFoundException {
        request.getDocuments().add(new RequestDocument(documentId));
        updateLastModificationInformation(request);
    }
    
    @Deprecated
    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT}, privilege = ContextPrivilege.WRITE)
    public void addDocuments(Request request, List<Document> documents)
        throws CvqException {

        if (documents == null)
            return;

        for (Document document : documents) {
            document.setHomeFolderId(request.getHomeFolderId());
            document.setDepositId(request.getRequesterId());
            for (DocumentAction documentAction : document.getActions()) {
                documentAction.setAgentId(request.getRequesterId());
            }
            addDocument(request, document.getId());
        }
    }

    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT}, privilege = ContextPrivilege.WRITE)
    public void removeDocument(Request request, final Long documentId)
        throws CvqException, CvqObjectNotFoundException {
        Iterator<RequestDocument> it = request.getDocuments().iterator();
        while (it.hasNext()) {
            RequestDocument rd = it.next();
            if (rd.getDocumentId().equals(documentId)){
                it.remove();
            }
        }
        updateLastModificationInformation(request);
    }

    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT}, privilege = ContextPrivilege.READ)
    public Set<RequestDocument> getAssociatedDocuments(final Long requestId)
        throws CvqException {
        Request request = getById(requestId);
        return request.getDocuments();
    }

    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT, ContextType.UNAUTH_ECITIZEN}, privilege = ContextPrivilege.READ)
    public Set<Document> getAssociatedDocumentsByType(final Long requestId, final Long documentTypeId)
        throws CvqException {
        Request request = getById(requestId);
        if (request.getDocuments() == null)
            return Collections.emptySet();
        Set<Document> result = new HashSet<Document>();
        for (RequestDocument requestDocument : request.getDocuments()) {
            Document document = documentService.getById(requestDocument.getDocumentId());
            if (document.getDocumentType().getId().equals(documentTypeId))
                result.add(document);
        }
        return result;
    }

    @Override
    @Context(types = {ContextType.EXTERNAL_SERVICE}, privilege = ContextPrivilege.READ)
    public GetDocumentListResponseDocument getAssociatedFullDocuments(final Long requestId) 
        throws CvqException, CvqObjectNotFoundException, PermissionException {
        Request request = getById(requestId);

        GetDocumentListResponseDocument getDocumentListResponseDocument =
            GetDocumentListResponseDocument.Factory.newInstance();
        GetDocumentListResponse getDocumentListResponse = 
            getDocumentListResponseDocument.addNewGetDocumentListResponse();

        Collection<String> authorizedRequestTypesLabels =
            requestExternalService.getRequestTypesForExternalService(SecurityContext.getCurrentExternalService());
        
        // Check external service permissions wrt configured request types labels
        String requestTypeLabel = request.getRequestType().getLabel();
        if (requestTypeLabel == null || authorizedRequestTypesLabels == null || 
                !authorizedRequestTypesLabels.contains(requestTypeLabel)) {
            throw new PermissionException(this.getClass(), "getAssociatedFullDocuments", 
                    new ContextType[] {ContextType.EXTERNAL_SERVICE}, ContextPrivilege.READ, 
                    "");
        }

        if (request.getDocuments().isEmpty()) {
            return getDocumentListResponseDocument;
        }
        
        // Switch to admin context to be able to call services without permission exceptions
        String currentExternalService = SecurityContext.getCurrentExternalService();
        SecurityContext.setCurrentContext(SecurityContext.ADMIN_CONTEXT);

        for (RequestDocument rd : request.getDocuments()) {
            Document doc = documentService.getById(rd.getDocumentId());
            DocumentType documentType = getDocumentListResponse.addNewDocument();
            documentType.setDocumentId(doc.getId());
            documentType.setType(doc.getDocumentType().getName());
            documentType.setState(doc.getState().toString());
            Calendar calendar = new GregorianCalendar();
            if (doc.getValidationDate() != null) {
                calendar.setTime(doc.getValidationDate());
                documentType.setValidationDate(calendar);
            }
            if (doc.getEndValidityDate() != null) {
                calendar.setTime(doc.getEndValidityDate());
                documentType.setEndValidityDate(calendar);
            }
        }

        // Reset to original context
        SecurityContext.setCurrentContext(SecurityContext.BACK_OFFICE_CONTEXT);
        SecurityContext.setCurrentExternalService(currentExternalService);
        
        return getDocumentListResponseDocument;
    }

    @Override
    public GetDocumentResponseDocument getAssociatedDocument(Long requestId, Long documentId,
            boolean mergeDocument) throws CvqException, CvqObjectNotFoundException, PermissionException {

        Request request = getById(requestId);

        Collection<String> authorizedRequestTypesLabels =
            requestExternalService.getRequestTypesForExternalService(SecurityContext.getCurrentExternalService());
        
        // Check external service permissions wrt configured request types labels
        String requestTypeLabel = request.getRequestType().getLabel();
        if (requestTypeLabel == null || authorizedRequestTypesLabels == null || 
                !authorizedRequestTypesLabels.contains(requestTypeLabel)) {
            throw new PermissionException(this.getClass(), "getAssociatedFullDocuments", 
                    new ContextType[] {ContextType.EXTERNAL_SERVICE}, ContextPrivilege.READ, "");
        }

        GetDocumentResponseDocument getDocumentResponseDocument =
            GetDocumentResponseDocument.Factory.newInstance();
        
        GetDocumentResponse getDocumentResponse = 
            getDocumentResponseDocument.addNewGetDocumentResponse();

        RequestExternalAction est = new RequestExternalAction(new Date(), String.valueOf(requestId), null, "capdemat", 
                null, SecurityContext.getCurrentExternalService(), RequestExternalActionState.SENT);

        // Switch to admin context to be able to call services without permission exceptions
        String currentExternalService = SecurityContext.getCurrentExternalService();
        SecurityContext.setCurrentContext(SecurityContext.ADMIN_CONTEXT);

        if (documentId != null) {
            // check the document is really associated to the request
            // someone could try to cheat with us
            boolean isDocumentReallyAssociated = false;
            for (RequestDocument requestDocument : request.getDocuments()) {
                if (requestDocument.getDocumentId().equals(documentId)) {
                    isDocumentReallyAssociated = true;
                    break;
                }
            }
            if (!isDocumentReallyAssociated)
                throw new PermissionException(this.getClass(), "getAssociatedDocument", 
                        new ContextType[] {ContextType.EXTERNAL_SERVICE}, ContextPrivilege.READ, "");

            Document document = documentService.getById(documentId);

            String message = 
                translationService.translate("externalservice.trace.sent.document", 
                        new Object[] { document.getId()}
                );
            est.setMessage(message);
            est.setSubkey("document");

            // Check if the document contains pages
            if (document.getDatas().isEmpty()) {
                requestExternalActionService.addTrace(est);
                return getDocumentResponseDocument;
            }

            if (mergeDocument) {
                documentService.mergeDocumentBinary(document);
                getDocumentResponse.addDocumentBinary(document.getDatas().get(0).getData());
            } else {
                for (int i = 0; i < document.getDatas().size(); i++) {
                    getDocumentResponse.addDocumentBinary(document.getDatas().get(i).getData());
                }
            }

        } else {
            byte[] pdf = requestSearchService.getCertificate(request.getId());
            getDocumentResponse.addDocumentBinary(pdf);

            String message = translationService.translate("externalservice.trace.sent.summary");
            est.setMessage(message);
            est.setSubkey("summary");
        }

        requestExternalActionService.addTrace(est);

        // Reset to original context
        SecurityContext.setCurrentContext(SecurityContext.BACK_OFFICE_CONTEXT);
        SecurityContext.setCurrentExternalService(currentExternalService);

        return getDocumentResponseDocument;
    }

    @Override
    @Context(types = {ContextType.ECITIZEN, ContextType.AGENT}, privilege = ContextPrivilege.READ)
    public List<Document> getProvidedNotAssociatedDocumentsByType(final Long requestId, final Long documentTypeId)
            throws CvqException {
        Request request = getById(requestId);
        List<Document> result = documentService.getProvidedDocuments(
                documentTypeService.getDocumentTypeById(documentTypeId),
                SecurityContext.getCurrentEcitizen().getHomeFolder().getId(), null);
        Iterator<Document> it = result.iterator();
        while (it.hasNext()) {
            Document doc = it.next();
            for (RequestDocument requestDocument : request.getDocuments())
                if (doc.getId().equals(requestDocument.getDocumentId())) {
                    it.remove();
                    break;
                }
        }
        return result;
    }

    private void updateLastModificationInformation(Request request) {
        request.setLastModificationDate(new Date());
        request.setLastInterveningUserId(SecurityContext.getCurrentUserId());
        requestDAO.update(request);
    }

    @Override
    public void onApplicationEvent(RequestEvent requestEvent) {
        logger.debug("onApplicationEvent() - " + requestEvent.getEvent() + " listen ");
        try {
            if (requestEvent.getEvent().equals(RequestEvent.EVENT_TYPE.REQUEST_CREATED))
                onRequestCreated(requestEvent.getRequest());
            else if (requestEvent.getEvent().equals(RequestEvent.EVENT_TYPE.REQUEST_DELETED))
                onRequestDeleted(requestEvent.getRequest());
        } catch (CvqException e) {
            logger.error("onApplicationEvent() : " + requestEvent.getEvent() + " : " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void onRequestCreated(Request request) throws CvqException {
        Iterator<RequestDocument> it = request.getDocuments().iterator();
        while (it.hasNext()) {
            RequestDocument rd = it.next();
            try {
                Document d = documentService.getById(rd.getDocumentId());
                if (DocumentState.DRAFT.equals(d.getState())) {
                    documentService.pending(d.getId());
                }
            } catch (CvqObjectNotFoundException e) {
                it.remove();
            }
        }
    }

    private void onRequestDeleted(Request request) throws CvqException {
        Iterator<RequestDocument> it = request.getDocuments().iterator();
        while (it.hasNext()) {
            RequestDocument rd = it.next();
            Document d = documentService.getById(rd.getDocumentId());
            if (DocumentState.DRAFT.equals(d.getState())) {
                it.remove();
                documentService.delete(d.getId());
            }
        }
    }

    private Request getById(final Long requestId) throws CvqObjectNotFoundException {
        return (Request) requestDAO.findById(Request.class, requestId);
    }

    public void setRequestDAO(IRequestDAO requestDAO) {
        this.requestDAO = requestDAO;
    }

    public void setDocumentService(IDocumentService documentService) {
        this.documentService = documentService;
    }

    public void setRequestExternalService(IRequestExternalService requestExternalService) {
        this.requestExternalService = requestExternalService;
    }

    public void setRequestSearchService(IRequestSearchService requestSearchService) {
        this.requestSearchService = requestSearchService;
    }

    public void setTranslationService(ITranslationService translationService) {
        this.translationService = translationService;
    }

    public void setRequestExternalActionService(
            IRequestExternalActionService requestExternalActionService) {
        this.requestExternalActionService = requestExternalActionService;
    }

    public void setDocumentTypeService(IDocumentTypeService documentTypeService) {
        this.documentTypeService = documentTypeService;
    }
}
