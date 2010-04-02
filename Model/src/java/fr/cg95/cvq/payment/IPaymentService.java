package fr.cg95.cvq.payment;

import java.net.URL;
import java.util.List;
import java.util.Map;
import java.util.Set;

import fr.cg95.cvq.business.users.HomeFolder;
import fr.cg95.cvq.business.users.payment.Payment;
import fr.cg95.cvq.business.users.payment.PaymentMode;
import fr.cg95.cvq.business.users.payment.PurchaseItem;
import fr.cg95.cvq.exception.CvqException;
import fr.cg95.cvq.exception.CvqModelException;
import fr.cg95.cvq.exception.CvqObjectNotFoundException;
import fr.cg95.cvq.security.annotation.IsHomeFolder;
import fr.cg95.cvq.util.Critere;


/**
 * Service dedicated to the management and monitoring of payments.
 *
 * @author bor@zenexity.fr
 */
public interface IPaymentService {

    String EXTERNAL_INVOICES = "ExternalInvoices";
    String EXTERNAL_DEPOSIT_ACCOUNTS = "ExternalDepositAccounts";
    String EXTERNAL_TICKETING_ACCOUNTS = "ExternalTicketingAccounts";

    String DATE_TYPE_INITIALIZATION = "dateTypeInitialization";
    String DATE_TYPE_COMMIT = "dateTypeCommit";
    
    /**
     * Get the list of all known brokers and their associated friendly labels 
     * for the current local authority.
     * 
     * @return a map of (broker, friendly label)
     */
    Map<String, String> getAllBrokers();
    
    /**
     * Create a payment container object "based" on the given purchase item.
     * 
     * @throws CvqException if payment container could not be created (security requirement, ...)
     */
    Payment createPaymentContainer(PurchaseItem purchaseItem, PaymentMode paymentMode)
        throws CvqException;
    
    /**
     * Add a purchase item to the user's payment and update payment information accordingly.
     * 
     * @throws CvqInvalidBrokerException if the item to be added has a broker different
     *         than already added items.
     */
    void addPurchaseItemToPayment(Payment payment, PurchaseItem purchaseItem)
        throws CvqInvalidBrokerException, CvqModelException, CvqException, 
            CvqObjectNotFoundException;
    
    /**
     * Remove a purchase item from the user's payment and update payment information accordingly.
     */
    void removePurchaseItemFromPayment(Payment payment, PurchaseItem purchaseItem);
    
    /**
     * Initialize a payment transaction with the payment provider associated to chosen items.
     */
    URL initPayment(Payment payment)
        throws CvqException;

    /**
     * Commit a payment initialized by {@link #initPayment}.
     *
     * @param parameters a map of all other needed HTTP request parameters received 
     *        from the payment provider.
     *
     * @return payment commit status
     *         (see {@link #UNKNOWN_RETURN}, {@link #OK_RETURN}, {@link #CANCELLED_RETURN}, 
     *              {@link #REFUSED_RETURN}).
     */
    PaymentResultStatus commitPayment(final Map<String, String> parameters)
        throws CvqException;
    
    PaymentResultStatus getStateFromParameters(final Map<String, String> parameters)
        throws CvqException;
    
    /**
     * Get all payments issued by the given home folder.
     */
    List<Payment> getByHomeFolder(@IsHomeFolder final HomeFolder homeFolder);
    
    /**
     * Get a constrained list of payments according to a set of criteria and requirements.
     *
     * @param criteriaSet a set of {@link Critere criteria} to be applied to the search
     * @param sort an ordering to apply to results. value is one of the SEARCH_* static
     *        string defined in this service (null to use default sort on payments ids)
     * @param dir the direction of the sort (asc or desc, asc by default)
     * @param recordsReturned the number of records to return (-1 to get all results)
     * @param startIndex the start index of the records to return
     */
    List<Payment> get(Set<Critere> criteriaSet, final String sort, final String dir, 
            final int recordsReturned, final int startIndex)
        throws CvqException;    
    
    /**
     * Get a count of payments matching the given criteria.
     */
    Long getCount(Set<Critere> criteriaSet);
    
    /**
     * Get a payment by id.
     */
    Payment getById(final Long id) throws CvqObjectNotFoundException;
    
    /**
     * Delete a payment.
     */
    void delete(final Long id) throws CvqObjectNotFoundException;

    /**
     * Delete a payment.
     */
    void delete(final Payment payment);
    
}