<%@ page import="com.recommender.domain.Application" %>



<div class="fieldcontain ${hasErrors(bean: applicationInstance, field: 'algorithm', 'error')} ">
    <label for="algorithm">
        <g:message code="application.algorithm.label" default="Algorithm"/>

    </label>
    <g:select name="algorithm" from="${com.recommender.enums.AlgorithmType?.values()}"
              keys="${com.recommender.enums.AlgorithmType?.values()*.name()}"
              value="${applicationInstance?.algorithm?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: applicationInstance, field: 'failedEntries', 'error')} ">
    <label for="failedEntries">
        <g:message code="application.failedEntries.label" default="Failed Entries"/>

    </label>

    <ul>
        <g:each in="${applicationInstance?.failedEntries ?}" var="f">
            <li><g:link controller="failedData" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
        </g:each>
    </ul>
    <g:link controller="failedData" action="create"
            params="['application.id': applicationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'failedData.label', default: 'FailedData')])}</g:link>

</div>

<div class="fieldcontain ${hasErrors(bean: applicationInstance, field: 'secretKey', 'error')} ">
    <label for="secretKey">
        <g:message code="application.secretKey.label" default="Secret Key"/>

    </label>
    <g:textField name="secretKey" value="${applicationInstance?.secretKey}"/>
</div>


