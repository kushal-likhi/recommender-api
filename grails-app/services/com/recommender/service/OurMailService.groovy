package com.recommender.service

class OurMailService {

    static transactional = false

    def groovyPageRenderer
    def mailService

    void sendMail(String emailTo, String emailSubject, String template, Map model) {
        mailService.sendMail {
            to emailTo
            subject emailSubject
            html(groovyPageRenderer.render(template: "/mailTemplate/${template}", model: model))
        }
    }
}
