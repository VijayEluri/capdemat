package fr.cg95.cvq.bo.civil;

import fr.cg95.cvq.bo.record.IPersistence;
import fr.cg95.cvq.bo.record.RequestRecord;
import fr.cg95.cvq.business.request.Request;
import fr.cg95.cvq.exception.CvqException;
import fr.cg95.cvq.service.civil.IBirthDetailsRequestService;

public class BirthDetailsPersistence extends IPersistence{

	public String getServiceName(String definitionName) {
		return IBirthDetailsRequestService.SERVICE_NAME;
	}

	public void initRequest(RequestRecord requestRecord) {
	}
	
	public void loadRequest(Request request, RequestRecord requestRecord) {
	}

	public void saveRequest(Request request, RequestRecord requestRecord) throws CvqException {
	}

	public void saveRequestData(Request request, RequestRecord requestRecord) throws CvqException {
	}

}
