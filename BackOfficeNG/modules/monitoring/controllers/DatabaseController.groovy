import grails.converters.JSON

public class DatabaseController {
    
    def monitoringService
    
    def index = { 
        def state = [:]
        
        if (params.pageState) state = JSON.parse(params.pageState)
        def authorities = monitoringService.getLocalAuthorities() as List
        def authoritiy = !state?.authorityName ? authorities.get(0) : state.authorityName
        def stats = monitoringService.getDatabaseInformation(authoritiy)
        
        //render service.queries
        //if(!params?.authorityName)
        return [
            pageState: (new JSON(state)).toString().encodeAsHTML(),
            authorities : authorities,
            authoritiy : authoritiy,
            stats : stats,
            state: state
        ]
    }
    
}
