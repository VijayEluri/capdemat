<html>
  <head>
    <meta name="layout" content="fo_main" />
    <link rel="stylesheet" type="text/css" href="\${createLinkTo(dir:'css/frontoffice', file:'request.css')}" />
    <script type="text/javascript" src="\${createLinkTo(dir:'js/frontoffice',file:'requestCreation.js')}"></script>
    <script type="text/javascript" src="\${createLinkTo(dir:'js/frontoffice',file:'condition.js')}"></script>
  </head>  
  <body>
    <g:set var="requestTypeInfo">
      {"label": "\${requestTypeLabel}"
        ,"steps": [ <% requestFo.steps.eachWithIndex { step, i -> %> "${step.name}${step.required ? '-required' : ''}"${i < requestFo.steps.size() -1 ? ',': ''} <% } %> ]
      }
    </g:set>
    <g:set var="requestTypeInfo" value="\${requestTypeInfo.encodeAsHTML()}" scope="request" />
    <g:render template="/frontofficeRequestType/draftPanel" />
    <g:render template="/frontofficeRequestType/cancelPanel" />
    <g:set var="requestTypeInfo" value="\${requestTypeInfo.encodeAsHTML()}" />
    
    <h2 class="request-creation"> <g:message code="${requestFo.acronym}.label" /></h2>
    <p><g:message code="${requestFo.acronym}.description" /></p> 
    <p><g:message code="request.duration.label" /><strong> : <g:message code="${requestFo.acronym}.duration.value" /></strong></p>
    <p>
      <g:message code="request.requiredDocuments.header" /> :
      <g:if test="\${!documentTypes.isEmpty()}">
        <g:each in="\${documentTypes}" var="documentType" status="index">
          <strong>\${documentType.value.name}<g:if test="\${index < documentTypes.size() - 1}">,</g:if></strong>
        </g:each>
      </g:if>
      <g:else>
        <g:message code="message.none" />
      </g:else>
    </p>
    <g:if test="\${flash.confirmationMessage}">
      <div class="request-information">\${flash.confirmationMessage}</div>
    </g:if>

    <div id="requestTabView" class="yui-navset">
      <ul class="yui-nav">
<% requestFo.steps.eachWithIndex { step, i -> %>
  <% if (step.name == 'document') { %>
        <g:if test="\${!documentTypes.isEmpty()}">
  <% } %>
  <% if (i == 0) { %>
        <li class="\${['${step.name}', 'firstStep'].contains(currentStep) ? 'selected' : ''}">
  <% } else {%>  
        <li class="\${currentStep == '${step.name}' ? 'selected' : ''}">
  <% } %>
          <a href="#${step.name}"><em>
          <span class="tag-no_right">${step.index + 1}</span>
          <span class="tag-state \${stepStates!= null ? stepStates.${step.name}.cssClass : 'tag-pending'}"><g:message code="\${stepStates != null ? stepStates.${step.name}.i18nKey : 'request.step.state.uncomplete'}" /></span>
    <% if (step.name == 'validation' || step.required) { %>
          <strong>
            <g:message code="${['validation'].contains(step.name) ? 'request' : requestFo.acronym}.step.${step.name}.label" /> *
          </strong>
    <% } else {%>
          <g:message code="${['document'].contains(step.name) ? 'request' : requestFo.acronym}.step.${step.name}.label" />
    <% } %>        
          </em></a>
        </li>    
  <% if (step.name == 'document') { %>
        </g:if>
  <% } %>
<% } %>
		 </ul>
		 
     <div class="yui-content">
<% requestFo.steps.each { step -> %>
  <% if (step.name == 'document') { %>
        <g:if test="\${!documentTypes.isEmpty()}">
  <% } %>
       <div id="${step.name}">
         <form method="POST" ${step.name == 'document' ? 'enctype=\"multipart/form-data\"' : ''} id="stepForm-${step.camelCaseName}" action="<g:createLink action="step" />">
           <h3>
             <span class="tag-state \${stepStates!= null ? stepStates.${step.name}.cssClass : 'tag-pending'}"><g:message code="\${stepStates != null ? stepStates.${step.name}.i18nKey : 'request.step.state.uncomplete'}" /></span>
  <% if (step.name == 'validation' || step.required) { %>
             <span class="tag-state tag-required"><g:message code="request.step.required" /></span>
  <% } %>
             <g:message code="${['validation','document'].contains(step.name) ? 'request' : requestFo.acronym}.step.${step.name}.label" />
             <span><g:message code="${['validation','document'].contains(step.name) ? 'request' : requestFo.acronym}.step.${step.name}.desc" /></span>
             <span class="error"><g:message code="\${stepStates?.${step.name}?.errorMsg}" /></span>
           </h3>
           <div>
  <% if (step.name == 'validation') { %>
             <label for="meansOfContact" class="required">
               <g:message code="request.meansOfContact.chooseMessage"/> *
             </label>
             <select name="meansOfContact" class="required">
               <g:each in="\${meansOfContact}" var="moc">
                 <option value="\${moc.key}">\${moc.label}</option>
               </g:each>
             </select>
    <% requestFo.stepBundles.eachWithIndex { stepBundle, index -> %>
            <g:render template="/frontofficeRequestType/${requestFo.camelCaseName + '/'}${step.name}${index}" />
    <% } %>
  <% } else { %>
            <g:render template="/frontofficeRequestType/${step.name != 'document' ? requestFo.camelCaseName + '/' : ''}${step.name}" />         
  <% } %>
           </div>
           <div class="error" id="stepForm-${step.camelCaseName}-error"> </div>
           <!-- Input submit-->
           <input type="hidden" id="requestTypeInfo" name="requestTypeInfo" value="\${requestTypeInfo}" />
           <input type="hidden" name="uuidString" value="\${uuidString}" />
  <% if (step.name == 'validation') { %>
           <div id="useAcceptance">
             <input type="checkbox" name="useAcceptance" class="required validate-one-required"
                    title="\${message(code:'request.error.useAcceptanceRequired')}" />
             <a href="\${createLink(controller:'localAuthorityResource',action:'pdf',id:'use')}" target="blank">
               <g:message code="request.step.validation.useAcceptance"/>
             </a>
           </div>
           <input type="submit" id="submit-step-${step.camelCaseName}" name="submit-step-${step.camelCaseName}" class="submit-step" value="\${message(code:'action.send')}" \${!isRequestCreatable ? 'disabled=\"disabled\"': ''}/>
           <g:if test="\${!isRequestCreatable}">
             <div><g:message code="request.step.validation.requiredSteps"/></div>
           </g:if>
  <% } else if (step.name != 'document') { %>
           <input type="submit" id="submit-step-${step.camelCaseName}" name="submit-step-${step.camelCaseName}" class="submit-step" value="\${message(code:'action.save')}" />
  <% } %>
         </form>
         <div class="navTab">
  <% if (step.index != 0) { %>
           <a id="prev-tab" href="#${requestFo.steps.get(step.index -1).name}"><g:message code="request.step.navigation.previous"/></a>
  <% } %>
  <% if (step.index != requestFo.steps.size() - 1) { %>
           <a id="next-tab" href="#${requestFo.steps.get(step.index + 1).name}"><g:message code="request.step.navigation.next"/></a>
  <% } %>
         </div>
         <g:if test="\${helps.${step.name} != null}">       
         <div class="requestHelp">
           <h3><g:message code="header.help"/></h3>
           \${helps.${step.name}}
         </div>
         </g:if>
       </div>  
  <% if (step.name == 'document') { %>
        </g:if>
  <% } %>
<% } %>        
 	    </div><!-- end yui-content -->
    </div><!-- end requestTabView -->
  
  </body>
</html>
