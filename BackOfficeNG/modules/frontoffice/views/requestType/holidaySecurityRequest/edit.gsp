<html>
  <head>
    <meta name="layout" content="fo_main" />
    <link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css/frontoffice', file:'request.css')}" />
    <script type="text/javascript" src="${createLinkTo(dir:'js/frontoffice',file:'requestCreation.js')}"></script>
    <script type="text/javascript" src="${createLinkTo(dir:'js/frontoffice',file:'condition.js')}"></script>
    <script type="text/javascript" src="${createLinkTo(dir:'js/frontoffice',file:'autofill.js')}"></script>
  </head>  
  <body>
    <g:set var="requestTypeInfo">
      {"label": "${requestTypeLabel}"
        ,"steps": [  "registration-required",  "rules-required",  "contactphone-required",  "contact",  "additional",  "document",  "validation"  ]
      }
    </g:set>
    <g:set var="requestTypeInfo" value="${requestTypeInfo.encodeAsHTML()}" scope="request" />
    <form action="${module.createLink(controller:'RequestCreationController',action:'condition')}" 
      method="post" id="conditionsForm">
      <input type="hidden" id="conditionsContainer" name="conditionsContainer" value="" />
      <input type="hidden" name="requestTypeLabel" value="${requestTypeLabel}" />
    </form>
    <form action="${module.createLink(controller:'RequestCreationController',action:'autofill')}"
      method="post" id="autofillForm">
      <input type="hidden" id="autofillContainer" name="autofillContainer" value="" />
      <input type="hidden" id="triggerName" name="triggerName" value="" />
      <input type="hidden" id="triggerValue" name="triggerValue" value="" />
    </form>
    <g:if test="${flash.isOutOfAccountRequest}">
      <g:render template="/frontofficeRequestType/loginPanel" />
    </g:if>
    <g:if test="${flash.confirmationMessage}">
      <div class="information-box"><p>${flash.confirmationMessage}</p></div>
    </g:if>
    
    <g:render template="/frontofficeRequestType/cancelPanel" />
    <g:if test="${session.currentEcitizen && !isEdition}">
      <g:render template="/frontofficeRequestType/draftPanel" />
    </g:if>
    
    <g:set var="requestTypeInfo" value="${requestTypeInfo.encodeAsHTML()}" />
    
    <h2 class="request-creation"> <g:message code="hsr.label" /></h2>
    <p><g:message code="hsr.description" /></p> 
    <p><g:message code="request.duration.label" /><strong> : <g:message code="hsr.duration.value" /></strong></p>
    <p>
      <g:message code="request.requiredDocuments.header" /> :
      <g:if test="${!documentTypes.isEmpty()}">
        <g:each in="${documentTypes}" var="documentType" status="index">
          <strong>${documentType.value.name}<g:if test="${index < documentTypes.size() - 1}">,</g:if></strong>
        </g:each>
      </g:if>
      <g:else>
        <g:message code="message.none" />
      </g:else>
    </p>

    <div id="requestTabView" class="yui-navset">
      <ul class="yui-nav">

  
  
        <li class="${['registration', 'firstStep'].contains(currentStep) ? 'selected' : ''}">
  
          <a href="#registration"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.registration.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.registration.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <strong>
            <g:message code="hsr.step.registration.label" /> *
          </strong>
            
          </em></a>
        </li>    
  

  
    
        <li class="${currentStep == 'rules' ? 'selected' : ''}">
  
          <a href="#rules"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.rules.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.rules.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <strong>
            <g:message code="hsr.step.rules.label" /> *
          </strong>
            
          </em></a>
        </li>    
  

  
    
        <li class="${currentStep == 'contactphone' ? 'selected' : ''}">
  
          <a href="#contactphone"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.contactphone.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.contactphone.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <strong>
            <g:message code="hsr.step.contactphone.label" /> *
          </strong>
            
          </em></a>
        </li>    
  

  
    
        <li class="${currentStep == 'contact' ? 'selected' : ''}">
  
          <a href="#contact"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.contact.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.contact.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <g:message code="hsr.step.contact.label" />
            
          </em></a>
        </li>    
  

  
    
        <li class="${currentStep == 'additional' ? 'selected' : ''}">
  
          <a href="#additional"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.additional.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.additional.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <g:message code="hsr.step.additional.label" />
            
          </em></a>
        </li>    
  

  
        <g:if test="${!documentTypes.isEmpty()}">
  
    
        <li class="${currentStep == 'document' ? 'selected' : ''}">
  
          <a href="#document"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.document.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.document.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <g:message code="request.step.document.label" />
            
          </em></a>
        </li>    
  
        </g:if>
  

  
    
        <li class="${currentStep == 'validation' ? 'selected' : ''}">
  
          <a href="#validation"><em>
          <span class="tag-state ${stepStates!= null ? stepStates.validation.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.validation.i18nKey : 'request.step.state.uncomplete'}" /></span>
    
          <strong>
            <g:message code="request.step.validation.label" /> *
          </strong>
            
          </em></a>
        </li>    
  

		 </ul>
		 
     <div class="yui-content">

  
       <div id="registration">
         <form method="POST"  id="stepForm-registration" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.registration.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.registration.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <span class="tag-state tag-required"><g:message code="request.step.required" /></span>
  
             <g:message code="hsr.step.registration.label" />
             <span><g:message code="hsr.step.registration.desc" /></span>
             <span class="error">${stepStates?.registration?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
            <g:render template="/frontofficeRequestType/holidaySecurityRequest/registration" />         
  
           </div>
           <div class="error" id="stepForm-registration-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
           <input type="submit" id="submit-step-registration" name="submit-step-registration" class="submit-step" value="${message(code:'action.save')}" />
  
         </form>
         <div class="navTab">
  
  
           <a id="next-tab" href="#rules"><g:message code="request.step.navigation.next"/></a>
  
         </div>
         <g:if test="${helps.registration != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.registration}
         </div>
         </g:if>
       </div>  
  

  
       <div id="rules">
         <form method="POST"  id="stepForm-rules" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.rules.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.rules.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <span class="tag-state tag-required"><g:message code="request.step.required" /></span>
  
             <g:message code="hsr.step.rules.label" />
             <span><g:message code="hsr.step.rules.desc" /></span>
             <span class="error">${stepStates?.rules?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
            <g:render template="/frontofficeRequestType/holidaySecurityRequest/rules" />         
  
           </div>
           <div class="error" id="stepForm-rules-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
           <input type="submit" id="submit-step-rules" name="submit-step-rules" class="submit-step" value="${message(code:'action.save')}" />
  
         </form>
         <div class="navTab">
  
           <a id="prev-tab" href="#registration"><g:message code="request.step.navigation.previous"/></a>
  
  
           <a id="next-tab" href="#contactphone"><g:message code="request.step.navigation.next"/></a>
  
         </div>
         <g:if test="${helps.rules != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.rules}
         </div>
         </g:if>
       </div>  
  

  
       <div id="contactphone">
         <form method="POST"  id="stepForm-contactphone" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.contactphone.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.contactphone.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <span class="tag-state tag-required"><g:message code="request.step.required" /></span>
  
             <g:message code="hsr.step.contactphone.label" />
             <span><g:message code="hsr.step.contactphone.desc" /></span>
             <span class="error">${stepStates?.contactphone?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
            <g:render template="/frontofficeRequestType/holidaySecurityRequest/contactphone" />         
  
           </div>
           <div class="error" id="stepForm-contactphone-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
           <input type="submit" id="submit-step-contactphone" name="submit-step-contactphone" class="submit-step" value="${message(code:'action.save')}" />
  
         </form>
         <div class="navTab">
  
           <a id="prev-tab" href="#rules"><g:message code="request.step.navigation.previous"/></a>
  
  
           <a id="next-tab" href="#contact"><g:message code="request.step.navigation.next"/></a>
  
         </div>
         <g:if test="${helps.contactphone != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.contactphone}
         </div>
         </g:if>
       </div>  
  

  
       <div id="contact">
         <form method="POST"  id="stepForm-contact" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.contact.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.contact.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <g:message code="hsr.step.contact.label" />
             <span><g:message code="hsr.step.contact.desc" /></span>
             <span class="error">${stepStates?.contact?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
            <g:render template="/frontofficeRequestType/holidaySecurityRequest/contact" />         
  
           </div>
           <div class="error" id="stepForm-contact-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
           <input type="submit" id="submit-step-contact" name="submit-step-contact" class="submit-step" value="${message(code:'action.save')}" />
  
         </form>
         <div class="navTab">
  
           <a id="prev-tab" href="#contactphone"><g:message code="request.step.navigation.previous"/></a>
  
  
           <a id="next-tab" href="#additional"><g:message code="request.step.navigation.next"/></a>
  
         </div>
         <g:if test="${helps.contact != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.contact}
         </div>
         </g:if>
       </div>  
  

  
       <div id="additional">
         <form method="POST"  id="stepForm-additional" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.additional.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.additional.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <g:message code="hsr.step.additional.label" />
             <span><g:message code="hsr.step.additional.desc" /></span>
             <span class="error">${stepStates?.additional?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
            <g:render template="/frontofficeRequestType/holidaySecurityRequest/additional" />         
  
           </div>
           <div class="error" id="stepForm-additional-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
           <input type="submit" id="submit-step-additional" name="submit-step-additional" class="submit-step" value="${message(code:'action.save')}" />
  
         </form>
         <div class="navTab">
  
           <a id="prev-tab" href="#contact"><g:message code="request.step.navigation.previous"/></a>
  
  
           <a id="next-tab" href="#document"><g:message code="request.step.navigation.next"/></a>
  
         </div>
         <g:if test="${helps.additional != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.additional}
         </div>
         </g:if>
       </div>  
  

  
        <g:if test="${!documentTypes.isEmpty()}">
  
       <div id="document">
         <form method="POST" enctype="multipart/form-data" id="stepForm-document" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.document.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.document.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <g:message code="request.step.document.label" />
             <span><g:message code="request.step.document.desc" /></span>
             <span class="error">${stepStates?.document?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
            <g:render template="/frontofficeRequestType/document" />         
  
           </div>
           <div class="error" id="stepForm-document-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
         </form>
         <div class="navTab">
  
           <a id="prev-tab" href="#additional"><g:message code="request.step.navigation.previous"/></a>
  
  
           <a id="next-tab" href="#validation"><g:message code="request.step.navigation.next"/></a>
  
         </div>
         <g:if test="${helps.document != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.document}
         </div>
         </g:if>
       </div>  
  
        </g:if>
  

  
       <div id="validation">
         <form method="POST"  id="stepForm-validation" action="<g:createLink action="step" />">
           <input type="hidden" name="returnUrl" value="${returnUrl}" />
           <h3>
             <span class="tag-state ${stepStates!= null ? stepStates.validation.cssClass : 'tag-pending'}"><g:message code="${stepStates != null ? stepStates.validation.i18nKey : 'request.step.state.uncomplete'}" /></span>
  
             <span class="tag-state tag-required"><g:message code="request.step.required" /></span>
  
             <g:message code="request.step.validation.label" />
             <span><g:message code="request.step.validation.desc" /></span>
             <span class="error">${stepStates?.validation?.errorMsg}</span>
           </h3>
           <p class="required-fields-notice"><g:message code="request.message.requiredFieldsNotice"/></p>
           <div>
  
             <label for="meansOfContact" class="required">
               <g:message code="request.meansOfContact.chooseMessage"/> *
             </label>
             <select name="meansOfContact" class="required">
               <g:each in="${meansOfContact}" var="moc">
                 <option value="${moc.key}" <g:if test="${rqt.meansOfContact?.type == moc.key}">selected="selected"</g:if>>${moc.label}</option>
               </g:each>
             </select>
    
            <g:render template="/frontofficeRequestType/holidaySecurityRequest/validation0" />
    
            <h3><g:message code="request.step.note.label" /></h3>
            <g:message code="request.step.note.desc" />
            <textarea name="requestNote" rows="" cols=""></textarea>
            <h3><g:message code="request.step.validation.label" /></h3>
            <g:if test="${!hasHomeFolder}">
              <g:render template="/frontofficeRequestType/outOfAccountValidation" />
            </g:if>
            <div id="useAcceptance">
             <input type="checkbox" name="useAcceptance" class="required validate-one-required"
                    title="${message(code:'request.error.useAcceptanceRequired')}" />
             <a href="${createLink(controller:'localAuthorityResource',action:'pdf',id:'use')}" target="blank">
               <g:message code="request.step.validation.useAcceptance"/>
             </a>
           </div>
  
           </div>
           <div class="error" id="stepForm-validation-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="${uuidString}" />
  
           <input type="submit" id="submit-step-validation" name="submit-step-validation" class="submit-step" value="${message(code:'action.send')}" ${!isRequestCreatable ? 'disabled="disabled"': ''}/>
           <g:if test="${!isRequestCreatable}">
             <div><strong><g:message code="request.step.validation.requiredSteps"/></strong></div>
           </g:if>
  
         </form>
         <div class="navTab">
  
           <a id="prev-tab" href="#document"><g:message code="request.step.navigation.previous"/></a>
  
  
         </div>
         <g:if test="${helps.validation != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           ${helps.validation}
         </div>
         </g:if>
       </div>  
  
        
 	    </div><!-- end yui-content -->
    </div><!-- end requestTabView -->
  
  </body>
</html>
