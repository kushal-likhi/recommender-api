package com.recommender

import com.recommender.domain.User
import org.bson.types.ObjectId

class ApplicationTagLib {

    def isLoggedIn = {args,body->
        if (request.currentUser) {
            out << body()
        }
    }

    def isAdmin = {args,body->
        User user = User.get(new ObjectId(request.currentUser))
        if (user && user.isAdmin) {
            out << body()
        }
    }

    def loggedInUserName = {args,body->
        if (request.currentUser) {
            User user = User.get(new ObjectId(request.currentUser))
                out << user?.name
        }
    }

}
