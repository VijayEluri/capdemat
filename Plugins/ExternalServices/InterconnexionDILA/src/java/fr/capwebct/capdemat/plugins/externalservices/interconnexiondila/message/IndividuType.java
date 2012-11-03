//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2012.05.23 at 04:10:50 PM CEST 
//


package fr.capwebct.capdemat.plugins.externalservices.interconnexiondila.message;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * Informations caracterisant un individu
 * 
 * <p>Java class for IndividuType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="IndividuType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Nom" type="{http://www.message.interconnexiondila.externalservices.plugins.capdemat.capwebct.fr}NomType"/>
 *         &lt;element name="NomUsage" type="{http://www.message.interconnexiondila.externalservices.plugins.capdemat.capwebct.fr}NomType"/>
 *         &lt;element name="NomNaissance" type="{http://www.message.interconnexiondila.externalservices.plugins.capdemat.capwebct.fr}NomType"/>
 *         &lt;element name="Prenoms" type="{http://www.message.interconnexiondila.externalservices.plugins.capdemat.capwebct.fr}PrenomsType"/>
 *         &lt;element name="DateNaissance" type="{http://www.w3.org/2001/XMLSchema}date"/>
 *         &lt;element name="LieuNaissance" type="{http://www.message.interconnexiondila.externalservices.plugins.capdemat.capwebct.fr}LieuNaissanceType"/>
 *         &lt;element name="Filiation" type="{http://www.message.interconnexiondila.externalservices.plugins.capdemat.capwebct.fr}FiliationType" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "IndividuType", propOrder = {
    "nom",
    "nomUsage",
    "nomNaissance",
    "prenoms",
    "dateNaissance",
    "dateActe",
    "lieuActe",
    "lieuNaissance",
    "filiation"
})
public class IndividuType {

    @XmlElement(name = "Nom", required = true)
    protected String nom;
    @XmlElement(name = "NomUsage")
    protected String nomUsage;
    @XmlElement(name = "NomNaissance")
    protected String nomNaissance;
    @XmlElement(name = "Prenoms", required = true)
    protected String prenoms;
    @XmlElement(name = "DateNaissance", required = true)
    @XmlSchemaType(name = "date")
    protected String dateNaissance;
    @XmlElement(name = "DateActe", required = true)
    protected String dateActe;
    @XmlElement(name = "LieuActe", required = true)
    protected AdressePostaleType lieuActe;
    @XmlElement(name = "LieuNaissance", required = true)
    protected LieuNaissanceType lieuNaissance;
    @XmlElement(name = "Filiation")
    protected FiliationType filiation;

    /**
     * Gets the value of the nom property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNom() {
        return nom;
    }

    /**
     * Sets the value of the nom property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNom(String value) {
        this.nom = value;
    }

    /**
     * Gets the value of the nomUsage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNomUsage() {
        return nomUsage;
    }

    /**
     * Sets the value of the nomUsage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNomUsage(String value) {
        this.nomUsage = value;
    }

    /**
     * Gets the value of the nomNaissance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNomNaissance() {
        return nomNaissance;
    }

    /**
     * Sets the value of the nomNaissance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNomNaissance(String value) {
        this.nomNaissance = value;
    }

    /**
     * Gets the value of the prenoms property.
     * 
     * @return
     *     possible object is
     *     {@link PrenomsType }
     *     
     */
    public String getPrenoms() {
        return prenoms;
    }

    /**
     * Sets the value of the prenoms property.
     * 
     * @param value
     *     allowed object is
     *     {@link PrenomsType }
     *     
     */
    public void setPrenoms(String value) {
        this.prenoms = value;
    }

    /**
     * Gets the value of the dateNaissance property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public String getDateNaissance() {
        return dateNaissance;
    }

    /**
     * Sets the value of the dateNaissance property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setDateNaissance(String value) {
        this.dateNaissance = value;
    }
    public LieuNaissanceType getLieuNaissance() {
        return lieuNaissance;
    }
    public void setLieuNaissance(LieuNaissanceType value) {
        this.lieuNaissance = value;
    }

    public AdressePostaleType getLieuActe() {
        return lieuActe;
    }
    public void setLieuActe(AdressePostaleType value) {
        this.lieuActe = value;
    }
    


    public String getDateActe() {
        return dateActe;
    }
    public void setDateActe(String value) {
        this.dateActe = value;
    }


    /**
     * Gets the value of the filiation property.
     * 
     * @return
     *     possible object is
     *     {@link FiliationType }
     *     
     */
    public FiliationType getFiliation() {
        return filiation;
    }

    /**
     * Sets the value of the filiation property.
     * 
     * @param value
     *     allowed object is
     *     {@link FiliationType }
     *     
     */
    public void setFiliation(FiliationType value) {
        this.filiation = value;
    }

}