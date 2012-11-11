grails {
    mongo {
        host = "127.0.0.1"
        port = 27017
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
