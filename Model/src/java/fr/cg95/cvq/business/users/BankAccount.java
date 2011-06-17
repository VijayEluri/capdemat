package fr.cg95.cvq.business.users;

import java.io.Serializable;

import net.sf.oval.constraint.MatchPattern;
import net.sf.oval.constraint.NotNull;

import org.apache.commons.lang3.CharSequenceUtils;
import org.apache.commons.lang3.StringUtils;

import fr.cg95.cvq.service.users.IsIBAN;
import fr.cg95.cvq.xml.common.BankAccountType;

/**
 * @hibernate.class
 *  table="bank_account"
 *  lazy="false"
 */
public class BankAccount implements Cloneable, Serializable {

    private static final long serialVersionUID = 1L;

    public static BankAccountType modelToXml(BankAccount bankAccount) {
        if (bankAccount == null) return null;
        BankAccountType bankAccountType = BankAccountType.Factory.newInstance();
        bankAccountType.setBIC(bankAccount.BIC);
        bankAccountType.setIBAN(bankAccount.IBAN);
        return bankAccountType;
    }

    public static BankAccount xmlToModel(BankAccountType bankAccountType) {
        if (bankAccountType == null) return null;
        BankAccount bankAccount= new BankAccount();
        bankAccount.id = bankAccountType.getId();
        bankAccount.BIC = bankAccountType.getBIC();
        bankAccount.IBAN = bankAccountType.getIBAN();
        return bankAccount;
    }

    private Long id;

    @NotNull(message = "BIC")
    @MatchPattern(pattern = {"^[a-zA-Z]{6}[a-zA-Z0-9]{2,5}$"}, message = "BIC")
    private String BIC;

    @NotNull(message = "IBAN")
    @MatchPattern(pattern = {"^[a-zA-Z0-9]{14,34}$"}, message = "IBAN")
    @IsIBAN(message = "IBAN")
    private String IBAN;

    /**
     * @hibernate.id
     *  generator-class="sequence"
     *  column="id"
     */
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @hibernate.property
     *  column="bic"
     *  not-null="true"
     */
    public String getBIC() {
        return BIC;
    }

    public void setBIC(String bIC) {
        BIC = StringUtils.upperCase(StringUtils.deleteWhitespace(bIC));
    }

    /**
     * @hibernate.property
     *  column="iban"
     *  not-null="true"
     */
    public String getIBAN() {
        return IBAN;
    }

    public void setIBAN(String iBAN) {
        IBAN = StringUtils.upperCase(StringUtils.deleteWhitespace(iBAN));
    }

    @Override
    public BankAccount clone() {
        BankAccount result = new BankAccount();
        result.BIC = BIC;
        result.IBAN = IBAN;
        return result;
    }

    public FrenchRIB toFrenchRIB() {
        if (CharSequenceUtils.length(IBAN) != 27 || !IBAN.startsWith("FR")) return null;
        FrenchRIB result = new FrenchRIB();
        result.setBankCode(Integer.valueOf(IBAN.substring(4, 9)));
        result.setCounterCode(Integer.valueOf(IBAN.substring(9, 14)));
        result.setAccountNumber(IBAN.substring(14, 25));
        result.setAccountKey(Integer.valueOf(IBAN.substring(25, 27)));
        return result;
    }
}
