package com.recommender.domain

import com.recommender.dto.ApplicationStatsDto

class UserController {

    def beforeInterceptor = [action: this.&auth]

    def userService
    def applicationService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", createUser: 'POST', updateProfile: 'POST']

    private auth() {
        if (['list', 'create', 'update', 'delete', 'show'].contains(actionName) && !request.loggedInUser?.isAdmin) {
            redirect(action: 'dashBoard')
            return false
        }
    }

    def editProfile = {
        User user = request.loggedInUser
        if (!user) {
            flash.message = "Please login/Sign Up"
            redirect(uri: '/')
            return
        }
        [userInstance: user]
    }

    def updateProfile = {
        User userInstance = request.loggedInUser
        if (userInstance) {
            bindData(userInstance, params, ['id', 'email', 'password'])
            userInstance.password = params.password?.encodeAsSHA256()
            if (params.password && userInstance.validate() && userInstance.save(flush: true)) {
                flash.message = "Updated Profile Successfully"
                redirect(action: "dashBoard")
                return
            }
            else {
                flash.message = "Please enter valid entries"
                render(view: "editProfile")
            }
        }
        else {
            redirect(uri: '/')
        }
    }


    def dashBoard = {
        User loggedInUser = request.loggedInUser
        List appStats = applicationService.getAppiclationsDataStats(loggedInUser)
        Map wholeApplsStats = ['Total Succesful hits': appStats*.savedHits.findAll()?.sum(), "Total Failed Hits": appStats*.failedHits.findAll()?.sum(), "Total Recived Hits": appStats*.receivedHits.findAll()?.sum()]
        Map wholeAppsComapreStats = [:]
        appStats.each {ApplicationStatsDto applicationStatsDto ->
            wholeAppsComapreStats[applicationStatsDto.name] = applicationStatsDto.totalHits()
        }
        [wholeAppsComapreStats: wholeAppsComapreStats, wholeApplsStats: wholeApplsStats]
    }

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

    def save = {
        def userInstance = new User(params)
        userInstance.password = params.password?.encodeAsSHA256()
        if (params.password && userInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance])}"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            [userInstance: userInstance]
        }
    }

    def edit = {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [userInstance: userInstance]
        }
    }

    def update = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (userInstance.version > version) {

                    userInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'user.label', default: 'User')] as Object[], "Another user has updated this User while you were editing")
                    render(view: "edit", model: [userInstance: userInstance])
                    return
                }
            }
            String password = userInstance.password
            userInstance.properties = params
            userInstance.password = password
            if (password != params.password) {
                userInstance.password = params.password?.encodeAsSHA256()
            }
            if (params.password && !userInstance.hasErrors() && userInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance])}"
                redirect(action: "show", id: userInstance.id)
            }
            else {
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def userInstance = User.get(params.id)
        if (userInstance) {
            try {
                userInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])}"
            redirect(action: "list")
        }
    }

}
