


  
    
            <label for="subjectId" class="required"><g:message code="request.property.subject.label" /> *  <span><g:message code="request.property.subject.help" /></span></label>
            <select id="subjectId" name="subjectId" <g:if test="${isEdition}">disabled="disabled"</g:if> class="required validate-not-first autofill-subjectFilling-trigger ${rqt.stepStates['subscription'].invalidFields.contains('subjectId') ? 'validation-failed' : ''}" title="<g:message code="request.property.subject.validationError" /> ">
              <option value=""><g:message code="message.select.defaultOption" /></option>
              <g:each in="${subjects}">
                <option value="${it.key}" ${it.key == rqt.subjectId ? 'selected="selected"': ''}>${it.value}</option>
              </g:each>
            </select>
            <g:if test="${[fr.cg95.cvq.service.request.IRequestWorkflowService.SUBJECT_POLICY_INDIVIDUAL, fr.cg95.cvq.service.request.IRequestWorkflowService.SUBJECT_POLICY_ADULT].contains(subjectPolicy)}">
              <a href="${createLink(controller : 'frontofficeHomeFolder', action : 'adult', params : ['mode' : 'edit', 'requestId' : rqt.id])}">
                <g:message code="homeFolder.action.addAdult" />
              </a>
            </g:if>
            <g:if test="${[fr.cg95.cvq.service.request.IRequestWorkflowService.SUBJECT_POLICY_INDIVIDUAL, fr.cg95.cvq.service.request.IRequestWorkflowService.SUBJECT_POLICY_CHILD].contains(subjectPolicy)}">
              <a href="${createLink(controller : 'frontofficeHomeFolder', action : 'child', params : ['mode' : 'edit', 'requestId' : rqt.id])}">
                <g:message code="homeFolder.action.addChild" />
              </a>
            </g:if>
            

  

  
    <label for="mobilePhone" class=""><g:message code="snr.property.mobilePhone.label" />   <span><g:message code="snr.property.mobilePhone.help" /></span></label>
            <input type="text" id="mobilePhone" name="mobilePhone" value="${rqt.mobilePhone?.toString()}" 
                    class=" autofill-subjectFilling-listener-MobilePhone validate-mobilePhone ${rqt.stepStates['subscription'].invalidFields.contains('mobilePhone') ? 'validation-failed' : ''}" title="<g:message code="snr.property.mobilePhone.validationError" />"  maxlength="10" />
            

  

  
    <label class="required"><g:message code="snr.property.subscription.label" /> *  <span><g:message code="snr.property.subscription.help" /></span></label>
            <ul class="yes-no required ${rqt.stepStates['subscription'].invalidFields.contains('subscription') ? 'validation-failed' : ''}">
              <g:each in="${[true,false]}">
              <li>
                <input type="radio" id="subscription_${it ? 'yes' : 'no'}" class="required  validate-one-required boolean" title="" value="${it}" name="subscription" ${it == rqt.subscription ? 'checked="checked"': ''} />
                <label for="subscription_${it ? 'yes' : 'no'}"><g:message code="message.${it ? 'yes' : 'no'}" /></label>
              </li>
              </g:each>
            </ul>
            

  

  
    <label class="required"><g:message code="snr.property.interests.label" /> *  <span><g:message code="snr.property.interests.help" /></span></label>
            <g:set var="interestsIndex" value="${0}" scope="flash" />
            <g:render template="/frontofficeRequestType/widget/localReferentialData" 
                      model="['javaName':'interests', 'i18nPrefixCode':'snr.property.interests', 'htmlClass':'required  ', 
                              'lrEntries': lrTypes.interests.entries, 'depth':0]" />
            

  

