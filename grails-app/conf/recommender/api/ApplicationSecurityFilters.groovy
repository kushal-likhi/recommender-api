package recommender.api

import com.recommender.security.StatelessSecurity

class ApplicationSecurityFilters {

    def filters = {
        all(controller: '*', action: '*') {
            before = {
                use(StatelessSecurity) {request.enrichRequest(response)}
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
