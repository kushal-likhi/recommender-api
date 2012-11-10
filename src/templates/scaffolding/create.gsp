<% import grails.persistence.Event %>
<% import org.codehaus.groovy.grails.plugins.PluginManagerHolder %>
<%=packageName%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}"/>
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
         <g:hasErrors bean="\${${propertyName}}">
            <div class="error-msg custom-msg">
            <g:renderErrors bean="\${${propertyName}}"/>
            </div>
        </g:hasErrors>
        <g:form action="save" <%=multiPart ? ' enctype="multipart/form-data"' : '' %> >
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
        <% excludedProps = Event.allEvents.toList() << 'version' << 'id' << 'dateCreated' << 'lastUpdated'
        persistentPropNames = domainClass.persistentProperties*.name
        props = domainClass.properties.findAll { persistentPropNames.contains(it.name) && !excludedProps.contains(it.name) }
        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
        display = true
        boolean hasHibernate = PluginManagerHolder.pluginManager.hasGrailsPlugin('hibernate')
        props.each { p ->
            if (!Collection.class.isAssignableFrom(p.type)) {
                if (hasHibernate) {
                    cp = domainClass.constrainedProperties[p.name]
                    display = (cp ? cp.display : true)
                }
                if (display) { %>
            <tr class="prop">
       <td valign="top" class="name">
           <label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
    </td>
        <td valign="top" class="value \${hasErrors(bean: ${propertyName}, field: '${p.name}', 'errors')}">
            ${renderEditor(p)}
        </td>
    </tr>
        <% }
        }
        } %>
    </tbody>
    </table>
        <div class="buttons">
            <span class="button"><g:submitButton name="create" class="submit small" value="\${message(code: 'default.button.create.label', default: 'Create')}"/></span>
        </div>
        </g:form>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>
</div>
</body>
</html>
