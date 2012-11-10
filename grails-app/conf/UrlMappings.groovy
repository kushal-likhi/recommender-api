class UrlMappings {

	static mappings = {

        //Todo Remove this as security concern once all mappings are done
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

        //For REST API
        "/api/rest/$appId/event/report"(controller: 'restApi', action: 'reportEvent')
        "/api/rest/$appId/recommend"(controller: 'restApi', action: 'recommend')

        //Application Mappings
		"/"(controller: 'security', action: 'mainPageRelay')
        "/dashboard"(controller: 'user', action: 'dashBoard')

        //Error Pages
        "500"(view:'/error')
		"404"(view:'/notFound')
	}
}
