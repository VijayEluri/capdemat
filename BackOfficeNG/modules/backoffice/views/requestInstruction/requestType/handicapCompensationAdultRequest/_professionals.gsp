

  <g:set var="listSize" value="${request.professionals.size()}" />
  <h3>
    <a class="addListItem" id="add_professionals[${listSize}]"></a>
    <span><g:message code="hcar.property.professionals.label" /></span>
  </h3>
  <g:each var="it" in="${request.professionals.reverse()}" status="index">
  <div class="collection-action">
    <a class="deleteListItem" id="delete_professionals[${listSize - 1 - index}]"></a>
  </div>
  <dl class="condition-isProfessionals-filled">
    
      <dt class="required"><g:message code="hcar.property.professionalLastName.label" /> * : </dt>
      <dd id="professionals[${listSize - 1 - index}].professionalLastName" class="action-editField validate-lastName required-true i18n-hcar.property.professionalLastName" >
        <span>${it?.professionalLastName}</span>
      </dd>
    
      <dt class="required"><g:message code="hcar.property.professionalFirstName.label" /> * : </dt>
      <dd id="professionals[${listSize - 1 - index}].professionalFirstName" class="action-editField validate-firstName required-true i18n-hcar.property.professionalFirstName" >
        <span>${it?.professionalFirstName}</span>
      </dd>
    
      <dt class="required"><g:message code="hcar.property.professionalAddress.label" /> * : </dt>
      <dd id="professionals[${listSize - 1 - index}].professionalAddress" class="action-editField validate-address required-true i18n-hcar.property.professionalAddress" >
        <div><p class="additionalDeliveryInformation">${it?.professionalAddress?.additionalDeliveryInformation}</p><p class="additionalGeographicalInformation">${it?.professionalAddress?.additionalGeographicalInformation}</p><span class="streetNumber">${it?.professionalAddress?.streetNumber}</span> <span class="streetName">${it?.professionalAddress?.streetName}</span><p class="placeNameOrService">${it?.professionalAddress?.placeNameOrService}</p><span class="postalCode">${it?.professionalAddress?.postalCode}</span> <span class="city">${it?.professionalAddress?.city}</span><p class="countryName">${it?.professionalAddress?.countryName}</p></div>
      </dd>
    
  </dl>
  </g:each>
