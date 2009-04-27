

<div id="requestData" class="yellow-yui-tabview">
  <ul class="yui-nav">
  
    <li class="selected">
      <a href="#page0"><em><g:message code="sgr.step.subject.label" /></em></a>
    </li>
  
    <li>
      <a href="#page1"><em><g:message code="sgr.step.taxHousehold.label" /></em></a>
    </li>
  
    <li>
      <a href="#page2"><em><g:message code="sgr.step.otherHelps.label" /></em></a>
    </li>
  
    <li>
      <a href="#page3"><em><g:message code="sgr.step.currentStudies.label" /></em></a>
    </li>
  
    <li>
      <a href="#page4"><em><g:message code="sgr.step.calculationElements.label" /></em></a>
    </li>
  
    <li>
      <a href="#page5"><em><g:message code="sgr.step.bankReference.label" /></em></a>
    </li>
  
  </ul>
   
  <div class="yui-content">
    
      
      <!-- step start -->
      <div id="page0">
        <h2><g:message code="property.form" />
          <span><g:message code="sgr.step.subject.label" /></span>
        </h2>
        <div class="yui-g">
          
          <!-- column start -->
          <div class="yui-u first">
            
              
              <h3><g:message code="sgr.property.subjectInformations.label" /></h3>
              <dl class="required">
                
                  <dt class="required"><g:message code="request.property.subject.label" /> : </dt>
              <dd><span>${request?.subjectFirstName} ${request?.subjectLastName}</span></dd>
          
                
                  <dt class="required"><g:message code="sgr.property.subjectAddress.label" /> * : </dt><dd id="subjectAddress" class="action-editField validate-address required-true i18n-sgr.property.subjectAddress" ><div><p class="additionalDeliveryInformation">${request?.subjectAddress?.additionalDeliveryInformation}</p><p class="additionalGeographicalInformation">${request?.subjectAddress?.additionalGeographicalInformation}</p><span class="streetNumber">${request?.subjectAddress?.streetNumber}</span> <span class="streetName">${request?.subjectAddress?.streetName}</span><p class="placeNameOrService">${request?.subjectAddress?.placeNameOrService}</p><span class="postalCode">${request?.subjectAddress?.postalCode}</span> <span class="city">${request?.subjectAddress?.city}</span><p class="countryName">${request?.subjectAddress?.countryName}</p></div></dd>
                
                  <dt class=""><g:message code="sgr.property.subjectPhone.label" />  : </dt><dd id="subjectPhone" class="action-editField validate-phone i18n-sgr.property.subjectPhone maxLength-10" ><span>${request?.subjectPhone}</span></dd>
                
                  <dt class=""><g:message code="sgr.property.subjectMobilePhone.label" />  : </dt><dd id="subjectMobilePhone" class="action-editField validate-phone i18n-sgr.property.subjectMobilePhone maxLength-10" ><span>${request?.subjectMobilePhone}</span></dd>
                
                  <dt class=""><g:message code="sgr.property.subjectEmail.label" />  : </dt><dd id="subjectEmail" class="action-editField validate-email i18n-sgr.property.subjectEmail" ><span>${request?.subjectEmail}</span></dd>
                
                  <dt class="required"><g:message code="sgr.property.subjectBirthDate.label" /> * : </dt><dd id="subjectBirthDate" class="action-editField validate-date required-true i18n-sgr.property.subjectBirthDate" ><span><g:formatDate formatName="format.date" date="${request?.subjectBirthDate}"/></span></dd>
                
              </dl>
              
            
          </div>
          <!-- column end -->
          
          <!-- column start -->
          <div class="yui-u">
            
          </div>
          <!-- column end -->
          
        </div>
        <!-- data step  end -->
      </div>
      <!-- step end -->
      
      <!-- step start -->
      <div id="page1">
        <h2><g:message code="property.form" />
          <span><g:message code="sgr.step.taxHousehold.label" /></span>
        </h2>
        <div class="yui-g">
          
          <!-- column start -->
          <div class="yui-u first">
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.taxHouseholdLastName.label" /> * : </dt><dd id="taxHouseholdLastName" class="action-editField validate-lastName required-true i18n-sgr.property.taxHouseholdLastName maxLength-38" ><span>${request?.taxHouseholdLastName}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.taxHouseholdFirstName.label" /> * : </dt><dd id="taxHouseholdFirstName" class="action-editField validate-firstName required-true i18n-sgr.property.taxHouseholdFirstName maxLength-38" ><span>${request?.taxHouseholdFirstName}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.taxHouseholdPostalCode.label" /> * : </dt><dd id="taxHouseholdPostalCode" class="action-editField validate-postalCode required-true i18n-sgr.property.taxHouseholdPostalCode maxLength-5" ><span>${request?.taxHouseholdPostalCode}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.taxHouseholdCity.label" /> * : </dt><dd id="taxHouseholdCity" class="action-editField validate-city required-true i18n-sgr.property.taxHouseholdCity maxLength-32" ><span>${request?.taxHouseholdCity}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.taxHouseholdIncome.label" /> * : </dt><dd id="taxHouseholdIncome" class="action-editField validate-regex required-true i18n-sgr.property.taxHouseholdIncome" regex="^\d+(?:\.\d{1,2})?$"><span>${request?.taxHouseholdIncome}</span></dd>
              </dl>
              
            
          </div>
          <!-- column end -->
          
          <!-- column start -->
          <div class="yui-u">
            
          </div>
          <!-- column end -->
          
        </div>
        <!-- data step  end -->
      </div>
      <!-- step end -->
      
      <!-- step start -->
      <div id="page2">
        <h2><g:message code="property.form" />
          <span><g:message code="sgr.step.otherHelps.label" /></span>
        </h2>
        <div class="yui-g">
          
          <!-- column start -->
          <div class="yui-u first">
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.hasCROUSHelp.label" /> * : </dt><dd id="hasCROUSHelp" class="action-editField validate-boolean required-true i18n-sgr.property.hasCROUSHelp" ><span class="value-${request?.hasCROUSHelp}"><g:message code="message.${request?.hasCROUSHelp ? 'yes' : 'no'}" /></span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.hasRegionalCouncilHelp.label" /> * : </dt><dd id="hasRegionalCouncilHelp" class="action-editField validate-boolean required-true i18n-sgr.property.hasRegionalCouncilHelp" ><span class="value-${request?.hasRegionalCouncilHelp}"><g:message code="message.${request?.hasRegionalCouncilHelp ? 'yes' : 'no'}" /></span></dd>
              </dl>
              
            
          </div>
          <!-- column end -->
          
          <!-- column start -->
          <div class="yui-u">
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.hasEuropeHelp.label" /> * : </dt><dd id="hasEuropeHelp" class="action-editField validate-boolean required-true i18n-sgr.property.hasEuropeHelp" ><span class="value-${request?.hasEuropeHelp}"><g:message code="message.${request?.hasEuropeHelp ? 'yes' : 'no'}" /></span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.hasOtherHelp.label" /> * : </dt><dd id="hasOtherHelp" class="action-editField validate-boolean required-true i18n-sgr.property.hasOtherHelp" ><span class="value-${request?.hasOtherHelp}"><g:message code="message.${request?.hasOtherHelp ? 'yes' : 'no'}" /></span></dd>
              </dl>
              
            
          </div>
          <!-- column end -->
          
        </div>
        <!-- data step  end -->
      </div>
      <!-- step end -->
      
      <!-- step start -->
      <div id="page3">
        <h2><g:message code="property.form" />
          <span><g:message code="sgr.step.currentStudies.label" /></span>
        </h2>
        <div class="yui-g">
          
          <!-- column start -->
          <div class="yui-u first">
            
              
              <h3><g:message code="sgr.property.aLevelsInformations.label" /></h3>
              <dl class="required">
                
                  <dt class="required"><g:message code="sgr.property.alevelsDate.label" /> * : </dt><dd id="alevelsDate" class="action-editField validate-regex required-true i18n-sgr.property.alevelsDate maxLength-4" regex="^\d{2,4}$"><span>${request?.alevelsDate}</span></dd>
                
                  <dt class="required"><g:message code="sgr.property.alevels.label" /> * : </dt><dd id="alevels" class="action-editField validate-capdematEnum required-true i18n-sgr.property.alevels javatype-fr.cg95.cvq.business.request.school.ALevelsType" ><g:capdematEnumToField var="${request?.alevels}" i18nKeyPrefix="sgr.property.alevels" /></dd>
                
              </dl>
              
            
              
              <h3><g:message code="sgr.property.currentSchool.label" /></h3>
              <dl class="required">
                
                  <dt class="required"><g:message code="sgr.property.currentSchoolName.label" /> * : </dt><dd id="currentSchoolName" class="action-editField validate-string required-true i18n-sgr.property.currentSchoolName" ><span>${request?.currentSchoolName}</span></dd>
                
                  <dt class="required"><g:message code="sgr.property.currentSchoolPostalCode.label" /> * : </dt><dd id="currentSchoolPostalCode" class="action-editField validate-postalCode required-true i18n-sgr.property.currentSchoolPostalCode maxLength-5" ><span>${request?.currentSchoolPostalCode}</span></dd>
                
                  <dt class="required"><g:message code="sgr.property.currentSchoolCity.label" /> * : </dt><dd id="currentSchoolCity" class="action-editField validate-city required-true i18n-sgr.property.currentSchoolCity maxLength-32" ><span>${request?.currentSchoolCity}</span></dd>
                
                  <dt class="required"><g:message code="sgr.property.currentSchoolCountry.label" /> * : </dt><dd id="currentSchoolCountry" class="action-editField validate-capdematEnum required-true i18n-sgr.property.currentSchoolCountry javatype-fr.cg95.cvq.business.users.CountryType" ><g:capdematEnumToField var="${request?.currentSchoolCountry}" i18nKeyPrefix="sgr.property.currentSchoolCountry" /></dd>
                
              </dl>
              
            
          </div>
          <!-- column end -->
          
          <!-- column start -->
          <div class="yui-u">
            
              
              <h3><g:message code="sgr.property.currentStudiesInformations.label" /></h3>
              <dl class="">
                
                  <dt class="required condition-isInOtherStudies-trigger"><g:message code="sgr.property.currentStudies.label" /> * : </dt><dd id="currentStudies" class="action-editField validate-capdematEnum required-true i18n-sgr.property.currentStudies javatype-fr.cg95.cvq.business.request.school.CurrentStudiesType" ><g:capdematEnumToField var="${request?.currentStudies}" i18nKeyPrefix="sgr.property.currentStudies" /></dd>
                
                  <dt class="required condition-isInOtherStudies-filled"><g:message code="sgr.property.otherStudiesLabel.label" /> * : </dt><dd id="otherStudiesLabel" class="action-editField validate-string required-true i18n-sgr.property.otherStudiesLabel" ><span>${request?.otherStudiesLabel}</span></dd>
                
                  <dt class="required"><g:message code="sgr.property.currentStudiesLevel.label" /> * : </dt><dd id="currentStudiesLevel" class="action-editField validate-capdematEnum required-true i18n-sgr.property.currentStudiesLevel javatype-fr.cg95.cvq.business.request.school.CurrentStudiesLevelType" ><g:capdematEnumToField var="${request?.currentStudiesLevel}" i18nKeyPrefix="sgr.property.currentStudiesLevel" /></dd>
                
                  <dt class="required"><g:message code="sgr.property.sandwichCourses.label" /> * : </dt><dd id="sandwichCourses" class="action-editField validate-boolean required-true i18n-sgr.property.sandwichCourses" ><span class="value-${request?.sandwichCourses}"><g:message code="message.${request?.sandwichCourses ? 'yes' : 'no'}" /></span></dd>
                
                  <dt class="required condition-makesAbroadInternship-trigger"><g:message code="sgr.property.abroadInternship.label" /> * : </dt><dd id="abroadInternship" class="action-editField validate-boolean required-true i18n-sgr.property.abroadInternship" ><span class="value-${request?.abroadInternship}"><g:message code="message.${request?.abroadInternship ? 'yes' : 'no'}" /></span></dd>
                
                  <dt class="required condition-makesAbroadInternship-filled"><g:message code="sgr.property.abroadInternshipStartDate.label" /> * : </dt><dd id="abroadInternshipStartDate" class="action-editField validate-date required-true i18n-sgr.property.abroadInternshipStartDate" ><span><g:formatDate formatName="format.date" date="${request?.abroadInternshipStartDate}"/></span></dd>
                
                  <dt class="required condition-makesAbroadInternship-filled"><g:message code="sgr.property.abroadInternshipEndDate.label" /> * : </dt><dd id="abroadInternshipEndDate" class="action-editField validate-date required-true i18n-sgr.property.abroadInternshipEndDate" ><span><g:formatDate formatName="format.date" date="${request?.abroadInternshipEndDate}"/></span></dd>
                
                  <dt class="required condition-makesAbroadInternship-filled"><g:message code="sgr.property.abroadInternshipSchoolName.label" /> * : </dt><dd id="abroadInternshipSchoolName" class="action-editField validate-string required-true i18n-sgr.property.abroadInternshipSchoolName" ><span>${request?.abroadInternshipSchoolName}</span></dd>
                
                  <dt class="required condition-makesAbroadInternship-filled"><g:message code="sgr.property.abroadInternshipSchoolCountry.label" /> * : </dt><dd id="abroadInternshipSchoolCountry" class="action-editField validate-capdematEnum required-true i18n-sgr.property.abroadInternshipSchoolCountry javatype-fr.cg95.cvq.business.users.CountryType" ><g:capdematEnumToField var="${request?.abroadInternshipSchoolCountry}" i18nKeyPrefix="sgr.property.abroadInternshipSchoolCountry" /></dd>
                
              </dl>
              
            
          </div>
          <!-- column end -->
          
        </div>
        <!-- data step  end -->
      </div>
      <!-- step end -->
      
      <!-- step start -->
      <div id="page4">
        <h2><g:message code="property.form" />
          <span><g:message code="sgr.step.calculationElements.label" /></span>
        </h2>
        <div class="yui-g">
          
          <!-- column start -->
          <div class="yui-u first">
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.distance.label" /> * : </dt><dd id="distance" class="action-editField validate-capdematEnum required-true i18n-sgr.property.distance javatype-fr.cg95.cvq.business.request.school.DistanceType" ><g:capdematEnumToField var="${request?.distance}" i18nKeyPrefix="sgr.property.distance" /></dd>
              </dl>
              
            
          </div>
          <!-- column end -->
          
          <!-- column start -->
          <div class="yui-u">
            
          </div>
          <!-- column end -->
          
        </div>
        <!-- data step  end -->
      </div>
      <!-- step end -->
      
      <!-- step start -->
      <div id="page5">
        <h2><g:message code="property.form" />
          <span><g:message code="sgr.step.bankReference.label" /></span>
        </h2>
        <div class="yui-g">
          
          <!-- column start -->
          <div class="yui-u first">
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.bankCode.label" /> * : </dt><dd id="bankCode" class="action-editField validate-regex required-true i18n-sgr.property.bankCode maxLength-5" regex="^\d{1,5}$"><span>${request?.bankCode}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.counterCode.label" /> * : </dt><dd id="counterCode" class="action-editField validate-regex required-true i18n-sgr.property.counterCode maxLength-5" regex="^\d{1,5}$"><span>${request?.counterCode}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.accountNumber.label" /> * : </dt><dd id="accountNumber" class="action-editField validate-regex required-true i18n-sgr.property.accountNumber maxLength-11" regex="^[a-zA-Z0-9]{1,11}$"><span>${request?.accountNumber}</span></dd>
              </dl>
              
            
              
              <dl>
                <dt class="required"><g:message code="sgr.property.accountKey.label" /> * : </dt><dd id="accountKey" class="action-editField validate-regex required-true i18n-sgr.property.accountKey maxLength-2" regex="^(?:O[1-9])|(?:[1-8]\d)|(?:9[0-7])$"><span>${request?.accountKey}</span></dd>
              </dl>
              
            
          </div>
          <!-- column end -->
          
          <!-- column start -->
          <div class="yui-u">
            
          </div>
          <!-- column end -->
          
        </div>
        <!-- data step  end -->
      </div>
      <!-- step end -->
      
    
    
  </div>
  
</div>