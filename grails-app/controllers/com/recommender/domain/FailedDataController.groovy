package com.recommender.domain

class FailedDataController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [failedDataInstanceList: FailedData.list(params), failedDataInstanceTotal: FailedData.count()]
    }

    def create = {
        def failedDataInstance = new FailedData()
        failedDataInstance.properties = params
        return [failedDataInstance: failedDataInstance]
    }

    def save = {
        def failedDataInstance = new FailedData(params)
        if (failedDataInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'failedData.label', default: 'FailedData'), failedDataInstance])}"
            redirect(action: "show", id: failedDataInstance.id)
        }
        else {
            render(view: "create", model: [failedDataInstance: failedDataInstance])
        }
    }

    def show = {
        def failedDataInstance = FailedData.get(params.id)
        if (!failedDataInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'failedData.label', default: 'FailedData'), params.id])}"
            redirect(action: "list")
        }
        else {
            [failedDataInstance: failedDataInstance]
        }
    }

    def edit = {
        def failedDataInstance = FailedData.get(params.id)
        if (!failedDataInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'failedData.label', default: 'FailedData'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [failedDataInstance: failedDataInstance]
        }
    }

    def update = {
        def failedDataInstance = FailedData.get(params.id)
        if (failedDataInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (failedDataInstance.version > version) {

                    failedDataInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'failedData.label', default: 'FailedData')] as Object[], "Another user has updated this FailedData while you were editing")
                    render(view: "edit", model: [failedDataInstance: failedDataInstance])
                    return
                }
            }
            failedDataInstance.properties = params
            if (!failedDataInstance.hasErrors() && failedDataInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'failedData.label', default: 'FailedData'), failedDataInstance])}"
                redirect(action: "show", id: failedDataInstance.id)
            }
            else {
                render(view: "edit", model: [failedDataInstance: failedDataInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'failedData.label', default: 'FailedData'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def failedDataInstance = FailedData.get(params.id)
        if (failedDataInstance) {
            try {
                failedDataInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'failedData.label', default: 'FailedData'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'failedData.label', default: 'FailedData'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'failedData.label', default: 'FailedData'), params.id])}"
            redirect(action: "list")
        }
    }
}
