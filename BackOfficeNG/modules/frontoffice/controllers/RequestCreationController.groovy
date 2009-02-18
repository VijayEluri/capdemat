import fr.cg95.cvq.business.request.Request
import fr.cg95.cvq.security.SecurityContext
import fr.cg95.cvq.service.authority.ILocalAuthorityRegistry
import fr.cg95.cvq.service.request.IRequestServiceRegistry
import fr.cg95.cvq.service.request.IMeansOfContactService
import fr.cg95.cvq.service.users.IIndividualService
import fr.cg95.cvq.exception.CvqException

import grails.converters.JSON

class RequestCreationController {
    
    IRequestServiceRegistry requestServiceRegistry
    ILocalAuthorityRegistry localAuthorityRegistry
    IMeansOfContactService meansOfContactService
    IIndividualService individualService
    
    def defaultAction = 'edit'
    
    def draft = {
        def requestService = requestServiceRegistry.getRequestService(
            params.requestTypeLabel.toString()
        )
        
        if(request.post) {
            def cRequest = session[params.uuidString].cRequest
            requestService.prepareDraft(cRequest)
            requestService.processDraft(cRequest)
            flash.cRequest = cRequest
            flash.confirmationMessage = message(code:'message.savedAsDraft')
        } else if (request.get) {
            flash.cRequest = requestService.getById(Long.parseLong(params.id))
        }
        redirect(controller:controllerName, params:['label':params.requestTypeLabel])
        return false
    }
    
    def edit = {
        if (params.label == null)
            redirect(uri: '/frontoffice/requestType')

        def requestService = requestServiceRegistry.getRequestService(params.label)
        if (requestService == null) {
            redirect(uri: '/frontoffice/requestType')
            return false
        }
        
        def cRequest
        if (flash.cRequest) cRequest = flash.cRequest 
        else cRequest = requestService.getSkeletonRequest()

        def uuidString = UUID.randomUUID().toString()
        
        session[uuidString] = [:]
        session[uuidString].put('cRequest', cRequest)

        def viewPath = "frontofficeRequestType/${CapdematUtils.requestTypeLabelAsDir(params.label)}/edit"
        render( view: viewPath, 
                model:
                    ['rqt': cRequest,
                     'subjects': getAuthorizedSubjects(requestService, cRequest),
                     'documentTypes': getDocumentTypes(requestService),
                     'meansOfContact': getMeansOfContact(meansOfContactService),
                     'currentStep': 'subject',
                     'requestTypeLabel': params.label,
                     'stepStates': cRequest.stepStates.size() != 0 ? cRequest.stepStates : null,
                     'helps': localAuthorityRegistry.getBufferedCurrentLocalAuthorityRequestHelpMap(CapdematUtils.requestTypeLabelAsDir(params.label)),
                     'uuidString': uuidString,
                     'isRequestCreatable': isRequestCreatable(cRequest.stepStates)
                    ])
    }
    
    def step = {
        
        if (params.requestTypeInfo == null || params.uuidString == null)
            redirect(uri: '/frontoffice/requestType')
            
        def uuidString = params.uuidString
        def requestTypeInfo = JSON.parse(params.requestTypeInfo)
        
        def currentStep
        def submitAction
        def editList
        
        def requestService = requestServiceRegistry.getRequestService(requestTypeInfo.label)
        def cRequest = session[uuidString].cRequest

        params.each { 
              println it
              if (it.key.startsWith('submit-'))
                submitAction = it.key.tokenize('-')
        }
        currentStep = submitAction[2]
        
        try {
            // removal of a collection element
            if (submitAction[1] == 'delete') {
                def listFieldToken = submitAction[3].tokenize('[]')
                def getterMethod = cRequest.class.getMethod(
                        'get' + StringUtils.firstCase(listFieldToken[0], 'Upper'))
                        
                getterMethod.invoke(cRequest, null).remove(Integer.valueOf(listFieldToken[1]).intValue())
            }
            // edition of a collection element
            else if (submitAction[1] == 'edit') {
                def listFieldToken = submitAction[3].tokenize('[]')
                def getterMethod = cRequest.class.getMethod(
                        'get' + StringUtils.firstCase(listFieldToken[0], 'Upper'))
                        
                editList = ['name': listFieldToken[0], 
                            'index': listFieldToken[1],
                            (listFieldToken[0]): getterMethod.invoke(cRequest, null).get(Integer.valueOf(listFieldToken[1]).intValue())
                           ]
            }
            // standard save action
            else {
                DataBindingUtils.initBind(cRequest, params)
                bind(cRequest)
                // clean empty collections elements
                DataBindingUtils.cleanBind(cRequest, params)
                
                if (cRequest.stepStates.size() == 0) {
                    // TODO - refactor
                    session[uuidString].stepStates = [:]
                    requestTypeInfo.steps.each {
                        def nameToken = it.tokenize('-')
                        def value = ['state': 'uncomplete',
                                     'required': nameToken.size() == 2 ? true : false,
                                     'cssClass': 'tag-uncomplete',
                                     'i18nKey': 'request.step.state.uncomplete'
                                     ]
                        cRequest.stepStates.put(nameToken[0], value)
                    }
                }
                if (submitAction[1] == 'step') {
                    cRequest.stepStates.get(currentStep).state = 'complete'
                    cRequest.stepStates.get(currentStep).cssClass = 'tag-complete'
                    cRequest.stepStates.get(currentStep).i18nKey = 'request.step.state.complete'
                    cRequest.stepStates.get(currentStep).errorMsg = ''
                }
                
                if (currentStep == "validation") {
                    if (!cRequest.draft) requestService.create(cRequest)
                    else requestService.finalizeDraft(cRequest)
                }
            }        
            session[uuidString].cRequest = cRequest
        
        } catch (CvqException ce) {
            cRequest.stepStates.get(currentStep).state = 'invalid'
            cRequest.stepStates.get(currentStep).cssClass = 'tag-invalid'
            cRequest.stepStates.get(currentStep).i18nKey = 'request.step.state.error'
            cRequest.stepStates.get(currentStep).errorMsg = ce.message
        }

        def viewPath = "frontofficeRequestType/${CapdematUtils.requestTypeLabelAsDir(requestTypeInfo.label)}/edit"
        render( view: viewPath,
                model:
                    ['rqt': cRequest,
                     'subjects': getAuthorizedSubjects(requestService, cRequest),
                     'documentTypes': getDocumentTypes(requestService),
                     'meansOfContact': getMeansOfContact(meansOfContactService),
                     'currentStep': currentStep,
                     'requestTypeLabel': requestTypeInfo.label,
                     'stepStates': cRequest.stepStates,
                     'helps': localAuthorityRegistry.getBufferedCurrentLocalAuthorityRequestHelpMap(CapdematUtils.requestTypeLabelAsDir(requestTypeInfo.label)),
                     'uuidString': uuidString,
                     'editList': editList,
                     'isRequestCreatable': isRequestCreatable(cRequest.stepStates)
                    ])
    }

    def condition = {
        if (params.requestTypeLabel == null)
            render ([status: 'error', error_msg:message(code:'error.unexpected')] as JSON)
            
        def triggers = JSON.parse(params.triggers)
        try {
            def requestService = requestServiceRegistry.getRequestService(params.requestTypeLabel)
            render (
              [test: requestService.isConditionFilled(triggers),
              status:'ok',
              success_msg:message(code:'message.conditionTested')
              ] as JSON)
        } catch (CvqException ce) {
            render ([status: 'error', error_msg:message(code:'error.unexpected')] as JSON)
        }
    }
    
    def getAuthorizedSubjects(requestService, cRequest) {
        def subjects = [:]
        def authorizedSubjects = requestService.getAuthorizedSubjects(SecurityContext.currentEcitizen.homeFolder.id)
        authorizedSubjects.each { subjectId, seasonsSet ->
            def subject = individualService.getById(subjectId)
            subjects[subjectId] = subject.lastName + ' ' + subject.firstName
        }

        // if it's a draft, its subject has to be manually re-added'
        if(cRequest.draft && !subjects.containsKey(cRequest.subjectId))
            subjects[cRequest.subjectId] = "${cRequest.subjectLastName} ${cRequest.subjectFirstName}"
            
        return subjects
    }
    
    def getMeansOfContact(meansOfContactService) {
        def result = []
        def meansOfContact = meansOfContactService.getCurrentEcitizenEnabledMeansOfContact()
        meansOfContact.each {
            result.add([
                        key:it.type,
                        label: message(code:'request.meansOfContact.' + StringUtils.pascalToCamelCase(it.type.toString()))])
        }
        return result.sort {it.label}
    }
    
    def getDocumentTypes(requestService) {
        def requestType = requestService.getRequestTypeByLabel(requestService.getLabel())
        def documentTypes = requestService.getAllowedDocuments(requestType.getId())
        def result = [:]
        documentTypes.each {
            result[it.id] = CapdematUtils.adaptDocumentTypeName(it.name)
        }
        return result
    }
    
    // TODO - refactor. Maybe move to Request class ...
    def isRequestCreatable(stepStates) {
        if (stepStates == null || stepStates.size() == 0)
            return false;
        def steps = stepStates.findAll {
            it.value.required && it.value.state != 'complete'
        }
        println steps
        if (steps.size() == 0)
            return true;
        else
            return false;
    }
}
