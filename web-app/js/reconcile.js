$(document).ready(function() {
    initReconcile();
});
function initReconcile() {
    var httpData = $.httpData || function(xhr, type, s) { // lifted from jq1.4.4
        var ct = xhr.getResponseHeader("content-type") || "",
            xml = type === "xml" || !type && ct.indexOf("xml") >= 0,
            data = xml ? xhr.responseXML : xhr.responseText;

        if (xml && data.documentElement.nodeName === "parsererror") {
            $.error("parsererror");
        }

        if (s && s.dataFilter) {
            data = s.dataFilter(data, type);
        }

        if (typeof data === "string") {
            if (type === "json" || !type && ct.indexOf("json") >= 0) {
                data = $.parseJSON(data);
            } else if (type === "script" || !type && ct.indexOf("javascript") >= 0) {
                $.globalEval(data);
            }
        }
        return data;
    };

    jQuery("#ajax_spinner").ajaxStart(function() {
        jQuery(this).show();
    });
    jQuery("#ajax_spinner").ajaxStop(function() {
        jQuery(this).hide();
    });
    jQuery.ajaxSetup({cache: false});
    jQuery("#ajax_spinner").ajaxComplete(function(event, xhr, options) {
        var data = httpData(xhr, options.dataType, options);
        var inputFieldIndex = -1;
        try {
            inputFieldIndex = data.indexOf("Session TimedOut url");
        } catch(err) {
        }
        if (inputFieldIndex > -1) {
            window.location.href = data.substring(data.indexOf("=") + 1, data.length);
        }
    });
    jQuery(".asmSelect").asmSelect({
        addItemTarget: 'top'
    });
    var dates = $("#start, #end").datepicker({
        defaultDate: "+1w",
        prevText:'',nextText:'',
        dateFormat:'dd/mm/yy',
        changeMonth: true,
        onSelect: function(selectedDate) {
            var option = this.id == "start" ? "minDate" : "maxDate",
                instance = $(this).data("datepicker"),
                date = $.datepicker.parseDate(
                    instance.settings.dateFormat ||
                        $.datepicker._defaults.dateFormat,
                    selectedDate, instance.settings);
            dates.not(this).datepicker("option", option, date);
        }
    });
    $("#changeSite").toggle(showHidePanel, showHidePanel);
    $("#closePanel").click(showHidePanel)

    function showHidePanel() {
        var display = $('.context-pane').css('display');
        if (display == "block") {
            $(".context-pane").hide();
            $("#changeSite").removeClass('disabled');
        } else {
            $(".context-pane").show();
            $("#changeSite").addClass('disabled');
        }
    }
}