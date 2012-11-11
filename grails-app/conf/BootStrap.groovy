import com.recommender.domain.User
import com.mongodb.Mongo
import grails.util.GrailsUtil
import org.codehaus.groovy.grails.commons.GrailsApplication

class BootStrap {

    def init = { servletContext ->

        //To Create And Drop the database
        /*  switch (GrailsUtil.environment) {
            case GrailsApplication.ENV_DEVELOPMENT:
            case GrailsApplication.ENV_TEST:
            case 'qa':
                Mongo m = new Mongo()
                m.dropDatabase("recommender-api")
                break;
            case GrailsApplication.ENV_PRODUCTION:
                break;
        }*/

        if (!User.collection.findOne([email: "kushal@intelligrape.com"])) {
            new User(
                    email: "kushal@intelligrape.com",
                    enabled: true,
                    firstName: "Kushal",
                    lastName: "Likhi",
                    password: "yo".encodeAsSHA256()
            ).save()
        }

    def destroy = {
    }
}
