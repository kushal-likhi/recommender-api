grails {
    mongo {
//        host = "localhost"
//        port = 27017
//        username = "blah"
//        password = "blah"
        databaseName = "recommender-api"
        options {
            autoConnectRetry = true
            connectTimeout = 300
        }
    }
}
environments {
    development {

    }
    test {

    }
    production {

    }
}
