<g:if test="${session[uuidString]?.isTutorsEdit}">
  <g:render template="/frontofficeRequestType/vOCardRequest/tutors" /> 
</g:if>
<g:else>

  <fieldset class="account-fieldset-edit validation-scope">
    <h4><g:message code="homeFolder.property.responsibles" /></h4>
    <dl>
    <g:each var="owner" in="${individuals.getRoleOwnersOnHomeFolder(individuals?.adults)}">
      <dt>
        <g:capdematEnumToFlag var="${owner.value.role}" i18nKeyPrefix="homeFolder.role" /> 
        ${owner.value.owner.fullName}
      </dt>
      <dd><input type="submit" name="submit-removeRole-account-ownerType:adults_ownerIndex:${owner.key}_role:${owner.value.role}" value="${message(code:'action.remove')}" /></dd>
    </g:each>
    <g:each var="owner" in="${individuals.getRoleOwnersOnHomeFolder(individuals?.tutors)}">
      <dt>
        <span class="tag-foreigner tag-state"><g:message code="homeFolder.property.foreign" /></span>
        <g:capdematEnumToFlag var="${owner.value.role}" i18nKeyPrefix="homeFolder.role" /> 
        ${owner.value.owner.fullName}
      </dt>
      <dd><input type="submit" name="submit-removeRole-account-ownerType:tutors_ownerIndex:${owner.key}_role:${owner.value.role}" value="${message(code:'action.remove')}" /></dd>
    </g:each>
    </dl>
    
    <label class="required"><g:message code="homeFolder.property.responsible" /> * <span> (${message(code:'homeFolder.property.responsible.help')})</span></label>
    <input type="hidden" name="role-homeFolderResponsible_ownerType:adults" value="HomeFolderResponsible" />
    <select name="owner-homeFolderResponsible_ownerType:adults" class="required validate-not-first" title="<g:message code="homeFolder.property.responsible.validationError" />">
      <option value=""><g:message code="message.select.defaultOption" /></option>
      <g:each var="owner" in="${individuals?.adults}" status="index">
        <option value="${index}" ${individuals.isLegalsResponsible(owner) ? 'selected="selected"' : ''}>
          ${owner.fullName}
        </option>
      </g:each>
    </select>
    <input type="submit" name="submit-addRole-account-homeFolderResponsible_ownerType:adults" value="${message(code:'action.save')}" />
    
    <p>(${message(code:'homeFolder.property.tutors.help')})</p>
    <label><g:message code="homeFolder.property.tutors" /></label>
    <input type="hidden" name="role-homeFolderTutor_ownerType:adults" value="Tutor" />
    <select name="owner-homeFolderTutor_ownerType:adults" class="validate-not-first">
      <option value=""><g:message code="message.select.defaultOption" /></option>
      <g:each var="owner" in="${individuals?.adults}" status="ownerIndex">
        <option value="${ownerIndex}">${owner.fullName}</option>
      </g:each>
    </select>
    <input type="submit" name="submit-addRole-account-homeFolderTutor_ownerType:adults" value="${message(code:'action.add')}" />
    
    <label><g:message code="homeFolder.property.foreignTutors" /></label>
    <input type="hidden" name="role-homeFolderTutor_ownerType:tutors" value="Tutor" />
    <select name="owner-homeFolderTutor_ownerType:tutors" class="validate-not-first">
      <option value=""><g:message code="message.select.defaultOption" /></option>
      <g:each var="owner" in="${individuals?.tutors}" status="ownerIndex">
        <option value="${ownerIndex}">${owner.fullName}</option>
      </g:each>
    </select>
    <input type="submit" name="submit-addRole-account-homeFolderTutor_ownerType:tutors" value="${message(code:'action.add')}" />
    
    <label>${message(code:'homeFolder.property.foreignTutors.label')}</label>
    <input type="submit" name="submit-tutorsEdit-account" value="${message(code:'homeFolder.action.addNewTutor')}" />
  </fieldset>

  <h3>
    <g:message code="homeFolder.header.rolesOnChildren" />
    <span><g:message code="homeFolder.header.rolesOnChildren.desc" /></span>
  </h3>
  <g:each var="it" in="${individuals?.children}" status="index">
    <fieldset class="account-fieldset-edit validation-scope">
      <h4>${it.fullName}</h4>
      <dl>
      <g:each var="owner" in="${individuals.getRoleOwnersOnIndividual(it.fullName,individuals?.adults)}">
        <dt>
          <g:capdematEnumToFlag var="${owner.value.role}" i18nKeyPrefix="homeFolder.role" /> 
          ${owner.value.owner.fullName}
        </dt>
        <dd><input type="submit" name="submit-removeRole-account-ownerType:adults_ownerIndex:${owner.key}_role:${owner.value.role}_individualIndex:${index}_individualType:children" value="${message(code:'action.remove')}" /></dd>
      </g:each>
       <g:each var="owner" in="${individuals.getRoleOwnersOnIndividual(it.fullName,individuals?.tutors)}">
        <dt>
          <span class="tag-foreigner tag-state"><g:message code="homeFolder.property.foreign" /></span>
          <g:capdematEnumToFlag var="${owner.value.role}" i18nKeyPrefix="homeFolder.role" /> 
          ${owner.value.owner.fullName}
        </dt>
        <dd><input type="submit" name="submit-removeRole-account-ownerType:tutors_ownerIndex:${owner.key}_role:${owner.value.role}_individualIndex:${index}_individualType:children" value="${message(code:'action.remove')}" /></dd>
      </g:each>
      </dl>
      <p> (${message(code:'homeFolder.child.property.legalResponsibles.help')})</p>
      <label class="required"><g:message code="homeFolder.child.property.legalResponsibles" /> *</label>
      <select name="role-ownerType:adults_individualIndex:${index}_individualType:children" class="validate-not-first">
        <option value=""><g:message code="message.select.defaultOption" /></option>
        <g:each in="${individuals?.childRoleTypes}">
          <option value="${it}"><g:capdematEnumToField var="${it}" i18nKeyPrefix="homeFolder.role" /></option>
        </g:each>
      </select>
      <select name="owner-ownerType:adults_individualIndex:${index}_individualType:children" class="validate-not-first">
        <option value=""><g:message code="message.select.defaultOption" /></option>
        <g:each var="owner" in="${individuals?.adults}" status="ownerIndex">
          <option value="${ownerIndex}">${owner.fullName}</option>
        </g:each>
      </select>
      <input type="submit" name="submit-addRole-account-ownerType:adults_individualIndex:${index}_individualType:children" value="${message(code:'action.add')}" />
      
      <label class="required"><g:message code="homeFolder.child.property.foreignLegalResponsibles" /> *</label>
      <select name="role-ownerType:tutors_individualIndex:${index}_individualType:children" class="validate-not-first">
        <option value=""><g:message code="message.select.defaultOption" /></option>
        <g:each in="${individuals?.childRoleTypes}">
          <option value="${it}"><g:capdematEnumToField var="${it}" i18nKeyPrefix="homeFolder.role" /></option>
        </g:each>
      </select>
      <select name="owner-ownerType:tutors_individualIndex:${index}_individualType:children" class="validate-not-first">
        <option value=""><g:message code="message.select.defaultOption" /></option>
        <g:each var="owner" in="${individuals?.tutors}" status="ownerIndex">
          <option value="${ownerIndex}">${owner.fullName}</option>
        </g:each>
      </select>
      <input type="submit" name="submit-addRole-account-ownerType:tutors_individualIndex:${index}_individualType:children" value="${message(code:'action.add')}" />
      
      <label>${message(code:'homeFolder.property.foreignTutors.label')}</label>
      <input type="submit" name="submit-tutorsEdit-account" value="${message(code:'homeFolder.action.addNewTutor')}" />
    </fieldset>
  </g:each>

  <h3>
    <g:message code="homeFolder.header.rolesOnAdults" />
    <span><g:message code="homeFolder.header.rolesOnAdults.desc" /></span>
  </h3>
  <g:each var="it" in="${individuals?.adults}" status="index">
    <fieldset class="account-fieldset-edit validation-scope">
      <h4>
        <g:capdematEnumToField var="${it.title}" i18nKeyPrefix="homeFolder.adult.title" /> ${it.fullName}
      </h4>
      <dl>
      <g:each var="owner" in="${individuals.getRoleOwnersOnIndividual(it.fullName,individuals?.adults)}">
        <dt>
          <g:capdematEnumToFlag var="${owner.value.role}" i18nKeyPrefix="homeFolder.role" /> ${owner.value.owner.fullName}
        </dt>
        <dd><input type="submit" name="submit-removeRole-account-ownerType:adults_ownerIndex:${owner.key}_role:${owner.value.role}_individualIndex:${index}_individualType:adults" value="${message(code:'action.remove')}" /></dd>
      </g:each>
      <g:each var="owner" in="${individuals.getRoleOwnersOnIndividual(it.fullName,individuals?.tutors)}">
        <dt>
          <span class="tag-foreigner tag-state"><g:message code="homeFolder.property.foreign" /></span>
          <g:capdematEnumToFlag var="${owner.value.role}" i18nKeyPrefix="homeFolder.role" /> ${owner.value.owner.fullName}
        </dt>
        <dd><input type="submit" name="submit-removeRole-account-ownerType:tutors_ownerIndex:${owner.key}_role:${owner.value.role}_individualIndex:${index}_individualType:adults" value="${message(code:'action.remove')}" /></dd>
      </g:each>
      </dl>
      <p>(${message(code:'homeFolder.property.tutors.help')})</p>
      <label><g:message code="homeFolder.adult.property.tutors" /></label>
      <input type="hidden" name="role-ownerType:adults_individualIndex:${index}_individualType:adults" value="Tutor" />
      <select name="owner-ownerType:adults_individualIndex:${index}_individualType:adults" class="validate-not-first">
        <option value=""><g:message code="message.select.defaultOption" /></option>
        <g:each var="owner" in="${individuals?.adults}" status="ownerIndex">
          <option value="${ownerIndex}">${owner.fullName}</option>
        </g:each>
      </select>
      <input type="submit" name="submit-addRole-account-ownerType:adults_individualIndex:${index}_individualType:adults" value="${message(code:'action.add')}" />
      
      <label><g:message code="homeFolder.adult.property.foreignTutors" /></label>
      <input type="hidden" name="role-ownerType:tutors_individualIndex:${index}_individualType:adults" value="Tutor" />
      <select name="owner-ownerType:tutors_individualIndex:${index}_individualType:adults" class="validate-not-first">
        <option value=""><g:message code="message.select.defaultOption" /></option>
        <g:each var="owner" in="${individuals?.tutors}" status="ownerIndex">
          <option value="${ownerIndex}">${owner.fullName}</option>
        </g:each>
      </select>
      <input type="submit" name="submit-addRole-account-ownerType:tutors_individualIndex:${index}_individualType:adults" value="${message(code:'action.add')}" />
      
      <label>${message(code:'homeFolder.property.foreignTutors.label')}</label>
      <input type="submit" name="submit-tutorsEdit-account" value="${message(code:'homeFolder.action.addNewTutor')}" />
    </fieldset>
  </g:each>

</g:else>

