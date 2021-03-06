<%@ page import="com.recommender.domain.FailedData" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'failedData.label', default: 'FailedData')}"/>
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
        <g:hasErrors bean="${failedDataInstance}">
            <div class="error-msg custom-msg">
                <g:renderErrors bean="${failedDataInstance}"/>
            </div>
        </g:hasErrors>
        <g:form action="save">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="application"><g:message code="failedData.application.label"
                                                            default="Application"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: failedDataInstance, field: 'application', 'errors')}">
                        <g:select name="application.id" from="${com.recommender.domain.Application.list()}"
                                  optionKey="id" value="${failedDataInstance?.application?.id}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="eventSource"><g:message code="failedData.eventSource.label"
                                                            default="Event Source"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: failedDataInstance, field: 'eventSource', 'errors')}">
                        <g:textField name="eventSource" value="${failedDataInstance?.eventSource}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="eventTarget"><g:message code="failedData.eventTarget.label"
                                                            default="Event Target"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: failedDataInstance, field: 'eventTarget', 'errors')}">
                        <g:textField name="eventTarget" value="${failedDataInstance?.eventTarget}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="reason"><g:message code="failedData.reason.label" default="Reason"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: failedDataInstance, field: 'reason', 'errors')}">
                        <g:textField name="reason" value="${failedDataInstance?.reason}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="weight"><g:message code="failedData.weight.label" default="Weight"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: failedDataInstance, field: 'weight', 'errors')}">
                        <g:textField name="weight" value="${fieldValue(bean: failedDataInstance, field: 'weight')}"/>
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
