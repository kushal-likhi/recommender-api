<%@ page import="com.recommender.domain.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>
        <div class="bheadr"></div>
    </div>
    <div class="block_content">
        <g:hasErrors bean="${userInstance}">
            <div class="error-msg custom-msg">
                <g:renderErrors bean="${userInstance}"/>
            </div>
        </g:hasErrors>
        <g:form method="post" controller="user" action="updateProfile">
            <g:hiddenField name="id" value="${userInstance?.id}"/>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tbody>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="email"><g:message code="user.email.label" default="Email"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'email', 'errors')}">
                        ${userInstance?.email}
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
                        <g:passwordField name="password" value="${userInstance?.password}"/>
                    </td>
                </tr>

                </tbody>
            </table>

            <div class="buttons">
                <span class="button"><g:submitButton class="submit small" name="Update"
                                                     value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
            </div>

            <div class="bendl"></div>

            <div class="bendr"></div>
        </g:form>
    </div>
</div>
</div>
</body>
</html>
