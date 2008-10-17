zenexity.capdemat.bong.requestIntruction = function() {
  var zcb = zenexity.capdemat.bong;
  var zcc = zenexity.capdemat.common;
  var zct = zenexity.capdemat.tools;
  var yud = YAHOO.util.Dom;
  var yuel = YAHOO.util.Element;
  var yue = YAHOO.util.Event;
  var yus = YAHOO.util.Selector;
  var ylj = YAHOO.lang.JSON;
  var ywtv = YAHOO.widget.TabView;
  var ywt = YAHOO.widget.Tab;
  var ywp = YAHOO.widget.Panel;
  var yl = YAHOO.lang;
  
  function init() {
    /* tabiews */
    var requestInformationTabview = new ywtv();
    requestInformationTabview.addTab( new ywt({
        label: 'Historique', dataSrc: zcb.baseUrl + '/requestActions/' + zcb.requestId,
        cacheData: true, active: true }));
    requestInformationTabview.addTab( new ywt({
        label: 'Commentaires', dataSrc: zcb.baseUrl + '/requestNotes/' + zcb.requestId,
        cacheData: false }));
    requestInformationTabview.addTab( new ywt({
        label: 'Compte', dataSrc: zcb.baseUrl + '/homeFolder',
        cacheData: true }));
    requestInformationTabview.addTab( new ywt({
        label: 'Demandes', dataSrc: zcb.baseUrl + '/homeFolderRequests/' + zcb.requestId,
        cacheData: true }));
    
    requestInformationTabview.appendTo('requestInformation');
    
    var requestDataTabView = new ywtv('requestData');
      
    /* panels */
    zcb.instructionStatePanel = new ywp(
      "instructionStatePanel", 
      { width: "135%", 
        visible: false, 
        constraintoviewport: true, draggable: false,
        underlay: "none", close: false
      });
    zcb.instructionStatePanel.render();
    
    zcb.requestDocumentPanel = new ywp(
      "requestDocumentPanel", 
      { width: "800px", y: 120,
        visible: false, 
        constraintoviewport: false, draggable: true,
        underlay: "shadow", close: true
      });
    zcb.requestDocumentPanel.render();
    
    zcb.ecitizenContactPanel = new ywp(
      "ecitizenContactPanel", 
      { width: "650px",
        visible: false, 
        constraintoviewport: false, draggable: true,
        underlay: "shadow", close: true
      });
    zcb.ecitizenContactPanel.render();
  }
  
  /*
   * Request Instruction Worflow managment
   */
   
  function submitChangeStateForm(targetEl , formId) {
    // bad strategy to refresh tag state ...
    var nodes = yus.query("input[name=stateType]", formId);
    var oldTagStateEl;
    if (nodes[0].getAttribute("value") != "documentState")
      oldTagStateEl = yud.get(nodes[0].getAttribute("value"));
    else {
      nodes = yus.query("input[name=id]", formId);
      oldTagStateEl = yud.get( "documentState_" + nodes[0].getAttribute("value"));
    }
    
    nodes = yus.query("input:checked", formId);
    var newTagStateEl = yud.getNextSibling(nodes[0]);
    
    zcc.doAjaxFormSubmitCall(
        formId,
        null, 
        function(o) {
          var response = ylj.parse(o.responseText);
          if (response.status === "ok") {
            oldTagStateEl.className = newTagStateEl.className;
            oldTagStateEl.innerHTML = newTagStateEl.innerHTML;
            
            zcb.instructionStatePanel.hide();
          } else {
            zcc.displayResponseResult('modelError', response.error_msg);
          }
        });
  }
  
  function getStateTransitions(stateCssClass, stateType) {   
    var id;
    if (stateType.indexOf("documentState_") != -1) {
      id = stateType.replace("documentState_", "");
      stateType = "documentState";
    } else {
      id = zcb.requestId
    }
    
    zcc.doAjaxCall(
        '/stateTransitions/' + '?id=' + id 
          + '&stateCssClass=' + stateCssClass + '&stateType=' + stateType,
        null,
        function(o) {
          zcb.instructionStatePanel.setBody(o.responseText);
          zcb.instructionStatePanel.show();
        });
  }
  
  function switchStatePanel(targetEl) {
    yud.setStyle(
        zcb.instructionStatePanel.id,
        "border-color", 
        yud.getStyle(targetEl, "background-color"));
    
    zcb.instructionStatePanel.cfg.setProperty("context", [targetEl,"tr","br"])
    
    if (! zcb.instructionStatePanel.cfg.getProperty("visible"))
      getStateTransitions(targetEl.className, targetEl.id);
    else
      zcb.instructionStatePanel.hide();
  }
  
  yue.addListener(
      "narrow", 
      "click", 
      function (e) {
        var targetEl = yue.getTarget(e);
           
        if (targetEl.className === "cancelStateChange") {
          zcb.instructionStatePanel.hide();
        } else if (targetEl.className === "submitStateChange") {
          if (FIC_checkForm(e, yud.get("changeStateFormErrors")))
            submitChangeStateForm(targetEl, "changeStateForm");
        } else if ( targetEl.className.indexOf("tag-") 
                    != -1 && targetEl.className != "tag-not_provided") {
          switchStatePanel(targetEl);
        }
      });
   
  /*
   * request document management 
   */
  
  function submitModifyDocumentForm(formId) {
    zcc.doAjaxFormSubmitCall(
        formId,
        null,
        function(o) {
          var response = ylj.parse(o.responseText);
          if (response.status === "ok") {
            yud.setStyle(formId, "background", "#aaffaa");
          } else {
            zcc.displayResponseResult('modelError', response.error_msg);
          }
        });
  }
  
  function getRequestDocument(targetEl) {
    // hacks for ie6
    var action = targetEl.pathname;
    if (action.indexOf("/") != 0)
      action = "/" + action;
      
    zcc.doAjaxCall(
        action,
        null,
        function(o) {
          zcb.requestDocumentPanel.setBody(o.responseText);
          zcb.requestDocumentPanel.show();
          // request document tabview
          var requestDocumentDataTabView = new ywtv('requestDocumentData');
          YAHOO.capdematBo.calendar.cal = new Array(1);
          yue.onDOMReady(YAHOO.capdematBo.calendar.init, {id: 0, label: "endValidityDate"} );
        });
  }
  
  yue.addListener(
      "requestDocument",
      "click", 
      function (e) {
        yue.preventDefault(e);
        
        var targetEl = yue.getTarget(e);
        if (targetEl.className === "documentLink")
          getRequestDocument(targetEl);
        else if (targetEl.id === "submitModifyDocumentForm")
          submitModifyDocumentForm("modifyDocumentForm"); 
      });
  
  /*
   * ecitizen contact management 
   */
  
  function submitContactForm(formId) {
    zcc.doAjaxFormSubmitCall (formId,null, 
      function(o) { 
        zcb.ecitizenContactPanel.hide();
      });
  }
  
  function getEcitizenContactPanel(targetEl) {
    // hacks for ie6
    var action = targetEl.pathname;
    if (action.indexOf("/") != 0)
      action = "/" + action;
      
    zcc.doAjaxCall(
        action,
        null,
        function(o) {
         zcb.ecitizenContactPanel.setBody(o.responseText);
         zcb.ecitizenContactPanel.show();
        });
  }
  
  yue.addListener(
      "ecitizenContact", 
      "click",
      function(e) { 
        var targetEl = yue.getTarget(e);
        if (targetEl.id === "ecitizenContactLink") {
          yue.preventDefault(e);
          getEcitizenContactPanel(targetEl); 
        } else if (targetEl.id === "submitContactForm") {
          if (FIC_checkForm(e, yud.get("contactFormErrors")))
            submitContactForm("contactForm");
        } else if (targetEl.id === "discardContactForm") {
          zcb.ecitizenContactPanel.hide();
        }
      });
  
  /* ecitizen means of contact default  */
  yue.addListener(
      "ecitizenContact", 
      "change",
      function(e) {
        var targetEl = yue.getTarget(e);
      
        if (targetEl.name === "meansOfContact") {
          var contactReciepientEl = yud.get("contactReciepient"); 
          
          if (targetEl.value === "Email")
            contactReciepientEl.value = yud.get("requesterEmail").value;
          else if (targetEl.value === "Sms")
            contactReciepientEl.value = yud.get("requesterMobilePhone").value;
        } 
      });
      
  
  /*
   * request data inline edition managment
   */
  
  function submitEditProperty(targetEl, formId) {
    zcc.doAjaxFormSubmitCall(
        formId,
        null, 
        function(o) {
          var response = ylj.parse(o.responseText);
          if (response.status === "ok") {
            modifyPropertyForm(targetEl, true);
            yud.setStyle(formId.replace("_Form", ""), "background", "#aaffaa");
          }
          else {
            yud.get(formId + "Error").innerHTML = response.error_msg;
//            zcc.displayResponseResult('modelError', response.error_msg);
          }
        });
  }
  
  function modifyPropertyForm(targetEl, isSubmit) {
    var formEl = yud.getAncestorByTagName(targetEl, "form");
    var propertyValue;
    
    var ddEl = yud.getAncestorByTagName(targetEl, "dd");
    var wrapperPropertyValueEl = yud.getFirstChild(ddEl);
    
    if (isSubmit && yud.hasClass(ddEl, "capdematEnum")) {
      zct.each(
          yud.get(formEl.id.replace("_Form", "") + "_Field").options,
          function() {
            if (this.selected === true)
             propertyValue = this.text;
          });
      wrapperPropertyValueEl.innerHTML = propertyValue;
    }
    else if (isSubmit && yud.hasClass(ddEl, "address")) {
      var addressFields = yud.getChildren(wrapperPropertyValueEl);
      var newAddressFields = yus.query("fieldset input", formEl);
      zct.each(
          newAddressFields, 
          function(i) {
            addressFields[i].innerHTML = this.value ;
          });
    }
    else if (isSubmit) {
      var elName = formEl.id.replace("_Form", "") + "_Field";
      propertyValue = yud.get(elName).value;
      wrapperPropertyValueEl.innerHTML = propertyValue;
    }
    yud.removeClass(wrapperPropertyValueEl, "invisible");
    
    new yuel(ddEl).removeChild(formEl);
    yud.removeClass(ddEl, "currentEditProperty");
  }
  
  function showEditProperty(targetEl) {
    var propertyValue;
    var wrapperPropertyValueEl = yud.getFirstChild(targetEl);
    
    if (yud.hasClass(targetEl, "address")) {
      var addressFields = yud.getChildren(wrapperPropertyValueEl);
      
      var jsonAddress = {
        "additionalDeliveryInformation": addressFields[0].innerHTML,
        "additionalGeographicalInformation": addressFields[1].innerHTML,
        "streetNumber": addressFields[2].innerHTML,
        "streetName": addressFields[3].innerHTML,
        "placeNameOrService": addressFields[4].innerHTML,
        "postalCode": addressFields[5].innerHTML,
        "city": addressFields[6].innerHTML,
        "countryName": addressFields[7].innerHTMLs
      }
      propertyValue = ylj.stringify(jsonAddress);
      
    }
    else if (yud.hasClass(targetEl, "capdematEnum")) {
      propertyValue = wrapperPropertyValueEl.className;
    }
    else {
      propertyValue = wrapperPropertyValueEl.innerHTML;
    }
    
    //console.log(new HTMLParagraphElement());
              
    zcc.doAjaxCall(
        "/widget/?"
          + "id=" + zenexity.capdemat.bong.requestId
          + "&propertyType=" + targetEl.className
          + "&propertyName=" + targetEl.id
          + "&propertyValue=" + propertyValue,
        null,
        function(o) {
          yud.addClass(targetEl, "currentEditProperty");
          yud.addClass(yud.getFirstChild(targetEl), "invisible");
          targetEl.innerHTML += o.responseText;
          
          if (yud.hasClass(targetEl, "date")) {
            YAHOO.capdematBo.calendar.cal = new Array(1);
            yue.onDOMReady(YAHOO.capdematBo.calendar.init, {id: 0, label: targetEl.id + "_Field"} );
          }
        });
  }
  
  yue.addListener(
      "requestData", 
      "click",
      function(e) {
          var targetEl = yue.getTarget(e);

          if (targetEl.tagName != "DD" && targetEl.tagName != "INPUT") {
            targetEl = yud.getAncestorByTagName(targetEl, "dd");
          }
          
          if (yud.hasClass(targetEl, "currentEditProperty"))   {
            return;
          }
          else if (yud.hasClass(targetEl, "string")
              || yud.hasClass(targetEl, "email")
              || yud.hasClass(targetEl, "address")
              || yud.hasClass(targetEl, "number")
              || yud.hasClass(targetEl, "date")
              || yud.hasClass(targetEl, "capdematEnum")
             ) {
            showEditProperty(targetEl);
          }
          else if (yud.hasClass(targetEl, "submit")) {
            var formEl = yud.getAncestorByTagName(targetEl, "form");
            if (FIC_checkForm(e, yud.get(formEl.id + "Errors")))
              submitEditProperty(targetEl, formEl.id);
          }
          else if (yud.hasClass(targetEl, "discard")) {
            modifyPropertyForm(targetEl, false);
          }
      });
   
  return {
    init: function() { init(); }
  };
  
}();

YAHOO.util.Event.onDOMReady(zenexity.capdemat.bong.requestIntruction.init);


