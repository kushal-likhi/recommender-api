package com.recommender.domain

import com.recommender.command.UserCo

class UserController {

    def userService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", createUser: 'POST', updateProfile: 'POST']


    def signUp = {

    }

    def createUser(UserCo userCo) {
        Map result = [:]
        try {
            result = userService.createUser(userCo)
        } catch (Exception ex) {
            result.message = "Error while creating user"
        }
        flash.message = result.message
        if (!result.user) {
            redirect(action: 'signUp')
            return
        }
        redirect(action: 'dashBoard')
    }


    def editProfile = {
        User user = User.list().first()
        if (!user) {
            flash.message = "Please login/Sign Up"
            redirect(uri: '/')
            return
        }
        [userInstance: user]
    }

    def updateProfile = {
        User userInstance = User.get(params.id)
        if (userInstance) {
            bindData(userInstance, params, ['id', 'email'])
            if (userInstance.validate() && userInstance.save(flush: true)) {
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
        User loggedInUser = User.list().first()
        [loggedInUser: loggedInUser, apps: loggedInUser.applications]
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
        if (userInstance.save(flush: true)) {
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
            userInstance.properties = params
            if (!userInstance.hasErrors() && userInstance.save(flush: true)) {
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

    def forgotPassword = {
        try {
            flash.message = userService.mailPassword(params.email)
        } catch (Exception ex) {
            log.error("UserController forgotPassword : " + ex)
            flash.message = " Sorry! Please try again"
        }
        redirect(uri: '/')
    }

}