class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller: 'security', action: 'mainPageRelay')
        "/dashboard"(controller: 'user', action: 'dashBoard')
		"500"(view:'/error')
		"404"(view:'/notFound')
	}
}
