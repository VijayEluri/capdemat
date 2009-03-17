package fr.cg95.cvq.service.request.school;

import fr.cg95.cvq.business.users.*;
import fr.cg95.cvq.business.request.*;
import fr.cg95.cvq.business.authority.*;
import fr.cg95.cvq.business.document.*;
import fr.cg95.cvq.business.request.school.*;
import fr.cg95.cvq.exception.*;
import fr.cg95.cvq.security.SecurityContext;
import fr.cg95.cvq.service.document.IDocumentTypeService;
import fr.cg95.cvq.service.request.IRequestService;
import fr.cg95.cvq.service.request.school.IStudyGrantRequestService;
import fr.cg95.cvq.util.Critere;

import fr.cg95.cvq.testtool.ServiceTestCase;
import fr.cg95.cvq.testtool.BusinessObjectsFactory;

import org.apache.commons.lang.StringUtils;

import java.util.*;
import java.io.File;
import java.io.FileOutputStream;
import java.math.BigInteger;

/**
 * Generated by Velocity if not present, can be edited safely !
 */
public class StudyGrantRequestServiceTest extends ServiceTestCase {

    protected IStudyGrantRequestService iStudyGrantRequestService;

    protected void onSetUp() throws Exception {
    	super.onSetUp();
        iStudyGrantRequestService = 
            (IStudyGrantRequestService) getBean(StringUtils.uncapitalize("StudyGrantRequest") + "Service");
    }

    protected StudyGrantRequest fillMeARequest() throws CvqException {

        StudyGrantRequest request = new StudyGrantRequest();
            request.setCurrentStudies(CurrentStudiesType.LICENCE1);
                request.setAbroadInternshipEndDate(new Date());
                    	    request.setTaxHouseholdAddress(address);
                          if ("FutureSchoolPhone".length() > 10)
        request.setFutureSchoolPhone("FutureSchoolPhone".substring(0, 10));
      else
        request.setFutureSchoolPhone("FutureSchoolPhone");
                request.setAbroadInternshipStartDate(new Date());
                request.setBankName("BankName");
                  if ("TaxHouseholdFirstName".length() > 38)
        request.setTaxHouseholdFirstName("TaxHouseholdFirstName".substring(0, 38));
      else
        request.setTaxHouseholdFirstName("TaxHouseholdFirstName");
                    request.setFutureSchoolName("FutureSchoolName");
                    request.setSandwichCoursesLabel("SandwichCoursesLabel");
                    request.setLastYearType("LastYearType");
                    request.setBankCode("BankCode");
                request.setSubjectBirthDate(new Date());
            request.setFutureSchoolIsAbroad(Boolean.valueOf(true));
                request.setCounterCode("CounterCode");
                request.setHasCROUSHelp(Boolean.valueOf(true));
                request.setSubjectEmail("SubjectEmail");
                request.setHasParentsAddress(Boolean.valueOf(true));
                    	    request.setFutureSchoolAddress(address);
                          request.setAbroadInternshipSchoolCountry(CountryType.UNKNOWN);
                    request.setAbroadInternshipSchoolAddress("AbroadInternshipSchoolAddress");
                  if ("TaxHouseholdPhone".length() > 10)
        request.setTaxHouseholdPhone("TaxHouseholdPhone".substring(0, 10));
      else
        request.setTaxHouseholdPhone("TaxHouseholdPhone");
                    request.setBankAgency("BankAgency");
                  if ("TaxHouseholdLastName".length() > 38)
        request.setTaxHouseholdLastName("TaxHouseholdLastName".substring(0, 38));
      else
        request.setTaxHouseholdLastName("TaxHouseholdLastName");
                    request.setAccountNumber("AccountNumber");
                  request.setDistance(DistanceType.LESS_THAN30KM);
                  if ("SubjectMobilePhone".length() > 10)
        request.setSubjectMobilePhone("SubjectMobilePhone".substring(0, 10));
      else
        request.setSubjectMobilePhone("SubjectMobilePhone");
                request.setIsInLastYear(Boolean.valueOf(true));
                request.setAbroadInternshipSchoolName("AbroadInternshipSchoolName");
                    request.setOtherHelpInformations("OtherHelpInformations");
                    request.setAccountKey("AccountKey");
                    request.setOtherStudiesLabel("OtherStudiesLabel");
                    request.setSubjectBirthPlace("SubjectBirthPlace");
                    request.setFutureDiplomaLevel("FutureDiplomaLevel");
                    request.setLastYearDate("LastYearDate");
                  request.setHasOtherHelp(Boolean.valueOf(true));
                request.setFutureDiplomaName("FutureDiplomaName");
                                Address SubjectAddress = BusinessObjectsFactory.gimmeAdress("1", "Unit test address", "Paris", "75012");
            request.setSubjectAddress(SubjectAddress);
    	                  if ("SubjectPhone".length() > 10)
        request.setSubjectPhone("SubjectPhone".substring(0, 10));
      else
        request.setSubjectPhone("SubjectPhone");
      
        // Means Of Contact
        MeansOfContact meansOfContact = iMeansOfContactService.getMeansOfContactByType(
                    MeansOfContactEnum.EMAIL);
        request.setMeansOfContact(meansOfContact);
        
        StudyGrantRequestFeeder.feed(request);
        
        return request;
    }
        	
    protected void completeValidateAndDelete(StudyGrantRequest request) 
    	throws CvqException, java.io.IOException {
    	
        // add a document to the request
        ///////////////////////////////

        Document doc = new Document();
        doc.setEcitizenNote("Ma carte d'identitÃ© !");
        doc.setDepositOrigin(DepositOrigin.ECITIZEN);
        doc.setDepositType(DepositType.PC);
        doc.setHomeFolderId(request.getHomeFolderId());
        doc.setIndividualId(request.getRequesterId());
        doc.setDocumentType(iDocumentTypeService.getDocumentTypeByType(IDocumentTypeService.IDENTITY_RECEIPT_TYPE));
        Long documentId = iDocumentService.create(doc);
        iStudyGrantRequestService.addDocument(request.getId(), documentId);
        Set<RequestDocument> documentsSet =
            iStudyGrantRequestService.getAssociatedDocuments(request.getId());
        assertEquals(documentsSet.size(), 1);

        // FIXME : test list of pending / in-progress registrations
        Critere testCrit = new Critere();
        testCrit.setAttribut(Request.SEARCH_BY_HOME_FOLDER_ID);
        testCrit.setComparatif(Critere.EQUALS);
        testCrit.setValue(request.getHomeFolderId());
        Set<Critere> testCritSet = new HashSet<Critere>();
        testCritSet.add(testCrit);
        List<Request> allRequests = iRequestService.get(testCritSet, null, null, -1, 0);
        assertNotNull(allRequests);

        // close current session and re-open a new one
        continueWithNewTransaction();
        
        SecurityContext.setCurrentSite(localAuthorityName,
                                        SecurityContext.BACK_OFFICE_CONTEXT);
        SecurityContext.setCurrentAgent(agentNameWithCategoriesRoles);
        iStudyGrantRequestService.complete(request.getId());
        iStudyGrantRequestService.validate(request.getId());

        // close current session and re-open a new one
        continueWithNewTransaction();
        
        byte[] generatedCertificate = iRequestService.getCertificate(request.getId(),
                                                                     RequestState.PENDING);

        if (generatedCertificate == null)
            fail("No certificate found");
            
        //     Write tele-service xml data file
        File xmlFile = File.createTempFile("tmp" + request.getId(), ".xml");
        FileOutputStream xmlFos = new FileOutputStream(xmlFile);
        xmlFos.write(iRequestService.getById(request.getId()).modelToXmlString().getBytes());

        File file = File.createTempFile("tmp" + request.getId(), ".pdf");
        FileOutputStream fos = new FileOutputStream(file);
        fos.write(generatedCertificate);

        // close current session and re-open a new one
        continueWithNewTransaction();
        
        // delete request
        iStudyGrantRequestService.delete(request.getId());
    }

    public void testWithHomeFolderPojo()
    		throws CvqException, CvqObjectNotFoundException,
                java.io.FileNotFoundException, java.io.IOException {

         SecurityContext.setCurrentSite(localAuthorityName, SecurityContext.FRONT_OFFICE_CONTEXT);

         // create a vo card request (to create home folder and associates)
         CreationBean cb = gimmeAnHomeFolder();

         SecurityContext.setCurrentEcitizen(cb.getLogin());

         // get the home folder id
         HomeFolder homeFolder = iHomeFolderService.getById(cb.getHomeFolderId());
         assertNotNull(homeFolder);
         Long homeFolderId = homeFolder.getId();
         assertNotNull(homeFolderId);

         // fill and create the request
         //////////////////////////////

         StudyGrantRequest request = fillMeARequest();
         request.setRequesterId(SecurityContext.getCurrentUserId());
         request.setHomeFolderId(homeFolderId);
         StudyGrantRequestFeeder.setSubject(request, 
             iStudyGrantRequestService.getSubjectPolicy(), null, homeFolder);
         
         Long requestId =
              iStudyGrantRequestService.create(request);

         StudyGrantRequest requestFromDb =
        	 	(StudyGrantRequest) iStudyGrantRequestService.getById(requestId);
         assertEquals(requestId, requestFromDb.getId());
         assertNotNull(requestFromDb.getRequesterId());
         assertNotNull(requestFromDb.getRequesterLastName());
         if (requestFromDb.getSubjectId() != null)
             assertNotNull(requestFromDb.getSubjectLastName());
         
         completeValidateAndDelete(requestFromDb);

         HomeFolder homeFolderAfterDelete = iHomeFolderService.getById(homeFolderId);
         assertNotNull(homeFolderAfterDelete);
         assertNotNull(iHomeFolderService.getHomeFolderResponsible(homeFolderAfterDelete.getId()));
         
         SecurityContext.resetCurrentSite();
    }


    public void testWithoutHomeFolder()
        throws CvqException, CvqObjectNotFoundException,
               java.io.FileNotFoundException, java.io.IOException {

	      if (!iStudyGrantRequestService.supportUnregisteredCreation())
	         return;

	      startTransaction();
	
        SecurityContext.setCurrentSite(localAuthorityName, SecurityContext.FRONT_OFFICE_CONTEXT);
        
        StudyGrantRequest request = fillMeARequest();

        Address address = BusinessObjectsFactory.gimmeAdress("12", "Rue d'Aligre", "Paris", "75012");
        Adult requester =
            BusinessObjectsFactory.gimmeAdult(TitleType.MISTER, "LASTNAME", "requester", address,
                                              FamilyStatusType.MARRIED);
        requester.setPassword("requester");
        requester.setAdress(address);
        iHomeFolderService.addHomeFolderRole(requester, RoleType.HOME_FOLDER_RESPONSIBLE);
        StudyGrantRequestFeeder.setSubject(request, 
            iStudyGrantRequestService.getSubjectPolicy(), requester, null);

        Long requestId =
             iStudyGrantRequestService.create(request, requester, requester);
        
        // close current session and re-open a new one
        continueWithNewTransaction();
        
        // start testing request creation
        /////////////////////////////////

        StudyGrantRequest requestFromDb =
            (StudyGrantRequest) iStudyGrantRequestService.getById(requestId);
        assertEquals(requestId, requestFromDb.getId());
        assertNotNull(requestFromDb.getRequesterId());
        assertNotNull(requestFromDb.getRequesterLastName());
        if (requestFromDb.getSubjectId() != null)
            assertNotNull(requestFromDb.getSubjectLastName());
        
        Long homeFolderId = requestFromDb.getHomeFolderId();
        Long requesterId = requestFromDb.getRequesterId();

        // close current session and re-open a new one
        continueWithNewTransaction();
        
        completeValidateAndDelete(requestFromDb);
        
        // close current session and re-open a new one
        continueWithNewTransaction();
        
        try {
            iHomeFolderService.getById(homeFolderId);
            fail("should not have found home folder");
        } catch (CvqObjectNotFoundException confe) {
            // great, that was expected
        }
        try {
            iIndividualService.getById(requesterId);
            fail("should not have found requester");
        } catch (CvqObjectNotFoundException confe) {
            // great, that was expected
        }

        SecurityContext.resetCurrentSite();
        
        commitTransaction();
    }
}
