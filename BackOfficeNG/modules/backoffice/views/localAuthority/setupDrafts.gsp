<html>
  <head>
    <title><g:message code="localAuthority.header.configuration" /></title>
    <meta name="layout" content="main" />
    <g:if test="${entity.posted}">
      <script type="text/javascript">
        YAHOO.util.Event.onDOMReady(function(){
          zenexity.capdemat.tools.Notifier.processMessage(
            '${entity.posted.state}',
            '${entity.posted.message}'
          );
        });
      </script>
    </g:if>
  </head>
  <body>
    
    <div id="yui-main">
      <div class="yui-b">
        <div class="head">
          <h1><g:message code="localAuthority.header.configuration" /></h1>
        </div>
        
        <div class="mainbox mainbox-yellow">
          <h2><g:message code="localAuthority.header.setupDrafts" /></h2>
        
          <form method="post" id="setupDraftsForm" action="${createLink(action:'setupDrafts')}">
            <div class="error" id="setupDraftsFormErrors"></div>
            
            <label for="draftLiveDuration" class="required">
              <g:message code="localAuthority.property.draftLiveDuration" /> * :
              <!-- <span> (<g:message code="property.days" />) </span> -->
            </label>
            <input type="text" class="required" name="draftLiveDuration" value="${entity.draftLiveDuration}" 
              class="required validate-positiveinteger" />
          
            <br/>
            <label for="draftNotificationBeforeDelete" class="required">
              <g:message code="localAuthority.property.draftNotificationBeforeDelete" /> * :
              <!-- <span> (<g:message code="property.days" />) </span> -->
            </label>
            <input type="text" class="required" name="draftNotificationBeforeDelete" 
              value="${entity.draftNotificationBeforeDelete}" 
              class="required validate-positiveinteger" />
              
            <div class="form-button">
              <input type="submit" value="${message(code:'action.save')}" />
            </div>
          </form>
        </div>
        
      </div>
    </div>

    <div id="narrow" class="yui-b">
      <div class="nobox">
        <h3>Explications et aide ...</h3>
        <div class="body"></div>
      </div>
    </div>    

  </body>
</html>
