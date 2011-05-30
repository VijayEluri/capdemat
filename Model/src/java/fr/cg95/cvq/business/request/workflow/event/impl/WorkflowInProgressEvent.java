package fr.cg95.cvq.business.request.workflow.event.impl;

import fr.cg95.cvq.business.request.Request;
import fr.cg95.cvq.business.request.workflow.event.impl.WorkflowGenericEvent;
import fr.cg95.cvq.business.request.workflow.event.IWorkflowEventVisitor;
import fr.cg95.cvq.exception.CvqException;

public class WorkflowInProgressEvent extends WorkflowGenericEvent {

    public WorkflowInProgressEvent(Request request) {
        super(request);
    }

    @Override
    public void accept(IWorkflowEventVisitor workflowEventVisitor) throws CvqException {
        workflowEventVisitor.visit(this);
    }
}
