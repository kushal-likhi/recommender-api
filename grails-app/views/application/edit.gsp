<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>
        <div class="bheadr"></div>
    </div>
    <div class="block_content">
        <g:hasErrors bean="${applicationInstance}">
            <div class="error-msg custom-msg">
                <g:renderErrors bean="${applicationInstance}"/>
            </div>
        </g:hasErrors>
        <g:form method="post">
            <g:hiddenField name="id" value="${applicationInstance?.id}"/>
            <g:hiddenField name="version" value="${applicationInstance?.version}"/>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name"><g:message code="application.name.label"
                                                     default="Name"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'name', 'errors')}">
                        <g:textField name="name" value="${applicationInstance?.name}"/>
                    </td>
                </tr>


                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="algorithm"><g:message code="application.algorithm.label"
                                                          default="Algorithm"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'algorithm', 'errors')}">
                        <g:select name="algorithm" from="${com.recommender.enums.AlgorithmType?.values()}"
                                  keys="${com.recommender.enums.AlgorithmType?.values()*.name()}"
                                  value="${applicationInstance?.algorithm?.name()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secretKey"><g:message code="application.secretKey.label"
                                                          default="Secret Key"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'secretKey', 'errors')}">
                        ${applicationInstance?.secretKey}"
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="buttons">
                <span class="button"><g:actionSubmit class="submit small" action="update"
                                                     value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
                <span class="button"><g:actionSubmit class="submit small" action="delete"
                                                     value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
            </div>

            <div class="bendl"></div>

            <div class="bendr"></div>
        </g:form>
    </div>
</div>
</div>
</body>
</html>
