<%@ page import="com.recommender.domain.FailedData" %>



<div class="fieldcontain ${hasErrors(bean: failedDataInstance, field: 'application', 'error')} ">
    <label for="application">
        <g:message code="failedData.application.label" default="Application"/>

    </label>
    <g:select name="application.id" from="${com.recommender.domain.Application.list()}" optionKey="id"
              value="${failedDataInstance?.application?.id}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: failedDataInstance, field: 'eventSource', 'error')} ">
    <label for="eventSource">
        <g:message code="failedData.eventSource.label" default="Event Source"/>

    </label>
    <g:textField name="eventSource" value="${failedDataInstance?.eventSource}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: failedDataInstance, field: 'eventTarget', 'error')} ">
    <label for="eventTarget">
        <g:message code="failedData.eventTarget.label" default="Event Target"/>

    </label>
    <g:textField name="eventTarget" value="${failedDataInstance?.eventTarget}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: failedDataInstance, field: 'reason', 'error')} ">
    <label for="reason">
        <g:message code="failedData.reason.label" default="Reason"/>

    </label>
    <g:textField name="reason" value="${failedDataInstance?.reason}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: failedDataInstance, field: 'weight', 'error')} ">
    <label for="weight">
        <g:message code="failedData.weight.label" default="Weight"/>

    </label>
    <g:textField name="weight" value="${fieldValue(bean: failedDataInstance, field: 'weight')}"/>
</div>

