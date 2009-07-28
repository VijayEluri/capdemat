package fr.cg95.cvq.business.authority;

import java.io.Serializable;
import java.util.Hashtable;
import java.util.Set;

import org.apache.commons.lang.builder.ToStringBuilder;


/**
 * @hibernate.class
 *  table="agent"
 *  lazy="false"
 *
 * @author bor@zenexity.fr
 */
public class Agent implements Serializable {

    public static final String SEARCH_BY_CATEGORY_ID = "categoryId";

    private static final long serialVersionUID = 1L;

    /** identifier field */
    private Long id;

    private String login;
    private String lastName;
    private String firstName;
    private Boolean active;

    private Set<CategoryRoles> categoriesRoles;
    private Set<SiteRoles> sitesRoles;
    private Hashtable<String, Hashtable<String, String>> preferences; 

    /** default constructor */
    public Agent() {
    }

    /**
     * @hibernate.id
     *  generator-class="sequence"
     *  column="id"
     */
    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @hibernate.property
     *  column="login"
     */
    public String getLogin() {
        return this.login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    /**
     * @hibernate.property
     *  column="last_name"
     */
    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * @hibernate.property
     *  column="first_name"
     */
    public String getFirstName() {
        return this.firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * @hibernate.set
     *  lazy="true"
     *  table="agent_category_roles"
     * @hibernate.key
     *  column="agent_id"
     * @hibernate.composite-element
     *  class="fr.cg95.cvq.business.authority.CategoryRoles"
     */
    public Set<CategoryRoles> getCategoriesRoles() {
        return this.categoriesRoles;
    }

    public void setCategoriesRoles(Set<CategoryRoles> categoriesRoles) {
        this.categoriesRoles = categoriesRoles;
    }

    /**
     * @hibernate.set
     *  lazy="true"
     *  table="agent_site_roles"
     * @hibernate.key
     *  column="agent_id"
     * @hibernate.composite-element
     *  class="fr.cg95.cvq.business.authority.SiteRoles"
     */
    public Set<SiteRoles> getSitesRoles() {
        return this.sitesRoles;
    }

    public void setSitesRoles(Set<SiteRoles> sitesRoles) {
        this.sitesRoles = sitesRoles;
    }

    /**
     * @hibernate.property
     *  column="active"
     */
    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    /**
     * @hibernate.property
     *  column="preferences"
     *  type="serializable"
     */
    public Hashtable<String, Hashtable<String, String>> getPreferences() {
        return this.preferences;
    }

    public void setPreferences(Hashtable<String, Hashtable<String, String>> preferences) {
        this.preferences = preferences;
    }
    
    public String toString() {
        return new ToStringBuilder(this)
            .append("login", getLogin())
            .append("id", getId())
            .toString();
    }
}
