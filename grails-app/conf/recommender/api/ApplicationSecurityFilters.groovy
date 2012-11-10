package recommender.api

import com.recommender.domain.User
import com.recommender.security.StatelessSecurity
import org.bson.types.ObjectId

class ApplicationSecurityFilters {

    def filters = {
        all(controller: '*', action: '*') {
            before = {
                use(StatelessSecurity) {
                    request.enrichRequest(response)
                    if (request.currentUser) {
                        request.loggedInUser = User.get(new ObjectId(request.currentUser))
                    }
                }
                if (!request.loggedInUser && ['user', 'application', 'failedData', 'util'].contains(controllerName)) {
                    redirect(uri: '/')
                    return false
                }
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
