<%@ page import="com.recommender.domain.FailedData" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'failedData.label', default: 'FailedData')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.show.label" args="[entityName]"/></h2>
        <ul>
            <li><g:link class="create" action="create">Add FailedData</g:link></li>
        </ul>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="failedData.application.label"
                                                         default="Application"/></td>

                <td valign="top" class="value"><g:link controller="application" action="show"
                                                       id="${failedDataInstance?.application?.id}">${failedDataInstance?.application?.encodeAsHTML()}</g:link></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="failedData.eventSource.label"
                                                         default="Event Source"/></td>

                <td valign="top" class="value">${fieldValue(bean: failedDataInstance, field: "eventSource")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="failedData.eventTarget.label"
                                                         default="Event Target"/></td>

                <td valign="top" class="value">${fieldValue(bean: failedDataInstance, field: "eventTarget")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="failedData.reason.label" default="Reason"/></td>

                <td valign="top" class="value">${fieldValue(bean: failedDataInstance, field: "reason")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="failedData.weight.label" default="Weight"/></td>

                <td valign="top" class="value">${fieldValue(bean: failedDataInstance, field: "weight")}</td>

            </tr>

            </tbody>
        </table>

        <div class="buttons">
            <p>
                <g:form>
                    <g:hiddenField name="id" value="${failedDataInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="submit small" action="edit"
                                                         value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
                    <span class="button"><g:actionSubmit class="submit small" action="delete"
                                                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </g:form>
            </p>
        </div>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>

</div>
</body>
</html>
