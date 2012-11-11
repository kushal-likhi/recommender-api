<%@ page import="com.recommender.domain.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.create.label" args="[entityName]"/></h2>
    </div>

    <div class="block_content">
        <g:hasErrors bean="${userInstance}">
            <div class="error-msg custom-msg">
                <g:renderErrors bean="${userInstance}"/>
            </div>
        </g:hasErrors>
        <g:form action="save">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="email"><g:message code="user.email.label" default="Email"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'email', 'errors')}">
                        <g:textField name="email" value="${userInstance?.email}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="firstName"><g:message code="user.firstName.label" default="First Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'firstName', 'errors')}">
                        <g:textField name="firstName" value="${userInstance?.firstName}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="lastName"><g:message code="user.lastName.label" default="Last Name"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'lastName', 'errors')}">
                        <g:textField name="lastName" value="${userInstance?.lastName}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="password"><g:message code="user.password.label" default="Password"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">
                        <g:passwordField name="password" value="test"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="enabled"><g:message code="user.enabled.label" default="Enabled"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'enabled', 'errors')}">
                        <g:checkBox name="enabled" value="${userInstance?.enabled}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="enabled"><g:message code="user.isAdmin.label" default="Admin"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'isAdmin', 'errors')}">
                        <g:checkBox name="enabled" value="${userInstance?.isAdmin}"/>
                    </td>
                </tr>


                </tbody>
            </table>

            <div class="buttons">
                <span class="button"><g:submitButton name="create" class="submit small"
                                                     value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
            </div>
        </g:form>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>
</div>
</body>
</html>
