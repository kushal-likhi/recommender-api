package com.recommender

import com.recommender.domain.User

class ApplicationTagLib {

    def isLoggedIn = {
        if (session.user) {
            out << body()
        }
    }

    def isAdmin = {
        User user = session.user
        if (user && user.admin) {
            out << body()
        }
    }

    def loggedInUserName = {
        if (session.user) {
            out << session.user?.name
        }
    }

}
