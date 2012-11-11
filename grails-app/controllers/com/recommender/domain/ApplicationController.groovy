package com.recommender.domain

import org.apache.commons.lang.RandomStringUtils

class ApplicationController {

    def applicationService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def stats = {

    }

    def list = {
        User user = request.loggedInUser
        if (!user) {
            redirect(uri: '/')
            return
        }
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        List applications = Application.createCriteria().list(params) {
            if (!user.isAdmin) {
                eq('user', user)
            }
        }
        [applicationInstanceList: applications, applicationInstanceTotal: applications?.totalCount]
    }

    def create = {
        Application applicationInstance = new Application()
        applicationInstance.secretKey = UUID.randomUUID().toString()
        return [applicationInstance: applicationInstance]
    }

    def save = {
        def applicationInstance = new Application(params)
        User user = request.loggedInUser
        user.addToApplications(applicationInstance)
        if (user.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'application.label', default: 'Application'), applicationInstance])}"
            redirect(action: "list")
        }
        else {
            render(view: "create", model: [applicationInstance: applicationInstance])
        }
    }

    def show = {
        def applicationInstance = Application.get(params.id)
        if (!applicationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
            redirect(action: "list")
        }
        else {
            [applicationInstance: applicationInstance,statsDataMap:applicationService.getAppStatsData(applicationInstance) ]
        }
    }

    def edit = {
        def applicationInstance = Application.get(params.id)
        if (!applicationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [applicationInstance: applicationInstance]
        }
    }

    def update = {
        def applicationInstance = Application.get(params.id)
        if (applicationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (applicationInstance.version > version) {

                    applicationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'application.label', default: 'Application')] as Object[], "Another user has updated this Application while you were editing")
                    render(view: "edit", model: [applicationInstance: applicationInstance])
                    return
                }
            }
            bindData(applicationInstance, params, ['id', 'user.id'])
            if (!applicationInstance.hasErrors() && applicationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'application.label', default: 'Application'), applicationInstance])}"
                redirect(action: "show", id: applicationInstance.id)
            }
            else {
                render(view: "edit", model: [applicationInstance: applicationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def applicationInstance = Application.get(params.id)
        if (applicationInstance && (applicationInstance.user == request.loggedInUser || request.loggedInUser.isAdmin())) {
            try {
                applicationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
            redirect(action: "list")
        }
    }
}
