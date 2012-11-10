/*
 AXLE ENGINE (jQuery Plugin)
 * By Kushal Likhi
 * (c) kushal likhi
 * */


var axle={alertError:true,logError:true,plugin:{jquery:{register:function(){return function(e){e.fn.axle=function(t){var n=this;axle.resizeMonitor.addListener(this.selector,function(e){e();return e}(function(){n.find("*").each(function(){axle.engine.apply(e(this))});try{t()}catch(r){axle.reportError(r)}}));return this}}(jQuery)}}},reportError:function(e){try{if(axle.logError){console.log("[AXLE ERROR] "+e);console.log(e);window.yo=e}}catch(t){}if(axle.alertError){alert("[AXLE ERROR] "+e)}},toInt:function(e){return parseInt(e.replace(/px/ig,""),10)},apply:function(e,t,n){n.css({position:"absolute",zIndex:"1"});n.css(e,t)},parse:function(e){e=e.replace(/{([^}]+?)}(w|h|t|l|r|b)([\d\.]+)%/ig,function(e,t,n,r){switch(n.toString().toLowerCase()){case"h":return"(((window.jQuery('"+t+"').height())/100) * "+r+" )";break;case"w":return"(((window.jQuery('"+t+"').width())/100) * "+r+" )";break;case"t":return"((window.axle.toInt(window.jQuery('"+t+"').css('top'))/100) * "+r+" )";break;case"l":return"((window.axle.toInt(window.jQuery('"+t+"').css('left'))/100) * "+r+" )";break;case"b":return"((window.axle.toInt(window.jQuery('"+t+"').css('bottom'))/100) * "+r+" )";break;case"r":return"((window.axle.toInt(window.jQuery('"+t+"').css('right'))/100) * "+r+" )";break}});e=e.replace(/{([^}]+?)}(w|h|t|l|r|b)/ig,function(e,t,n){switch(n.toString().toLowerCase()){case"h":return"window.jQuery('"+t+"').height()";break;case"w":return"window.jQuery('"+t+"').width()";break;case"t":return"window.axle.toInt(window.jQuery('"+t+"').css('top'))";break;case"l":return"window.axle.toInt(window.jQuery('"+t+"').css('left'))";break;case"b":return"window.axle.toInt(window.jQuery('"+t+"').css('bottom'))";break;case"r":return"window.axle.toInt(window.jQuery('"+t+"').css('right'))";break}});e=e.replace(/(w|h)([\d\.]*)%/ig,function(e,t,n){switch(t.toString().toLowerCase()){case"h":return"((window.axle.availableDimensions.height/100) * "+n+" )";break;case"w":return"((window.axle.availableDimensions.width/100) * "+n+" )";break}});e=e.replace(/ (w|h) /ig,function(e,t){switch(t.toString().toLowerCase()){case"h":return" window.axle.availableDimensions.height ";break;case"w":return" window.axle.availableDimensions.width ";break}});e=e.replace(/ (w|h)$/ig,function(e,t){switch(t.toString().toLowerCase()){case"h":return" window.axle.availableDimensions.height ";break;case"w":return" window.axle.availableDimensions.width ";break}});return e},engine:function(){if(this.attr("data-axle-height")){axle.apply("height",eval(axle.parse(this.attr("data-axle-height")))+"px",this)}if(this.attr("data-axle-width")){axle.apply("width",eval(axle.parse(this.attr("data-axle-width")))+"px",this)}if(this.attr("data-axle-top")){axle.apply("top",eval(axle.parse(this.attr("data-axle-top")))+"px",this)}if(this.attr("data-axle-left")){axle.apply("left",eval(axle.parse(this.attr("data-axle-left")))+"px",this)}if(this.attr("data-axle-right")){axle.apply("right",eval(axle.parse(this.attr("data-axle-right")))+"px",this)}if(this.attr("data-axle-bottom")){axle.apply("bottom",eval(axle.parse(this.attr("data-axle-bottom")))+"px",this)}if(this.attr("data-axle-layer")){axle.apply("zIndex",eval(axle.parse(this.attr("data-axle-layer"))),this)}if(this.attr("onAxleLayout")){var random=parseInt(Math.random()*1e3,10);eval("window.axleCallbackInline"+random+" = function(){"+this.attr("onAxleLayout")+"}");window["axleCallbackInline"+random].apply(this)}},processAxleFiles:function(){try{jQuery.ajaxSetup({async:false});jQuery("link[rel='axle']").each(function(){var e="";$.ajax({url:jQuery(this).attr("href"),type:"GET",dataType:"text",async:false,success:function(t){e=t}});e=e.replace(/\{\{/g,"###open###").replace(/\}\}/g,"###close###");e.replace(/([^\{]+)\{([^\{]*)\}/g,function(e,t,n){var r=jQuery.trim(t).split(",");var i=[];axle.each(jQuery.trim(n).split(";"),function(){i.push(jQuery.trim(this))});axle.each(r,function(){axle.loadDataToElement.apply(jQuery(jQuery.trim(this)),[i])})})});jQuery.ajaxSetup({async:true})}catch(e){axle.reportError(e);jQuery.ajaxSetup({async:true})}finally{jQuery.ajaxSetup({async:true})}},loadDataToElement:function(e){var t=new axle.PropertyFileMapper(this);axle.each(e,function(){t.setProperty(this);t.execute()})},PropertyFileMapper:function(e){var t=this;this.setProperty=function(e){var n=[];e.replace(/([a-zA-Z\-]+):(.+)/,function(e,t,r){n=[t,r]});try{t.key=jQuery.trim(n[0])}catch(r){axle.reportError(r);t.key=null}try{t.value=jQuery.trim(n[1]).replace(/###open###/g,"{").replace(/###close###/g,"}")}catch(r){axle.reportError(r);t.value=null}};var n=function(e){return e.toString().toLowerCase().replace(/(height)|(width)|(top)|(left)|(right)|(bottom)|(layer)/,"")==""};this.execute=function(){try{if(n(t.key)){var r="data-axle-"+t.key;if(!e.attr(r)){e.attr(r,t.value)}}else{e.css(t.key,t.value)}}catch(i){axle.reportError(i)}}},ScreenAreaProvider:function(){var e=new Object;e.height=0;e.width=0;var t=this;var n=function(){var e=jQuery("meta[name='axleDefaultViewPort']");if(e.size()>0){return jQuery(e.attr("content"))}else{return jQuery(window)}}();this.findCurrentWindowSize=function(){e.width=n.width();e.height=n.height();t.availableHeight=e.height;t.availableWidth=e.width;t.availableScreenSize=e;return t}},resizeMonitor:{handlers:{},screenAreaProvider:{},previousSize:{},newSize:{},addListener:function(e,t){axle.resizeMonitor.handlers[e]=t},removeListener:function(e){delete axle.resizeMonitor.handlers[e]},monitor:function(){axle.resizeMonitor.newSize=axle.resizeMonitor.cloneDimensions(axle.resizeMonitor.screenAreaProvider.findCurrentWindowSize().availableScreenSize);axle.availableDimensions={height:axle.resizeMonitor.newSize.height,width:axle.resizeMonitor.newSize.width};if(axle.resizeMonitor.previousSize.height!=axle.resizeMonitor.newSize.height||axle.resizeMonitor.previousSize.width!=axle.resizeMonitor.newSize.width){var e=axle.resizeMonitor.cloneDimensions(axle.resizeMonitor.newSize);axle.resizeMonitor.executeHandlers(e.height,e.width)}axle.resizeMonitor.previousSize=axle.resizeMonitor.cloneDimensions(axle.resizeMonitor.newSize)},executeHandlers:function(e,t){for(var n in axle.resizeMonitor.handlers){try{axle.resizeMonitor.handlers[n](e,t)}catch(r){axle.reportError(r)}}},cloneDimensions:function(e){return{height:e.height,width:e.width}},start:function(){axle.resizeMonitor.previousSize=axle.resizeMonitor.cloneDimensions(axle.resizeMonitor.screenAreaProvider.findCurrentWindowSize().availableScreenSize);axle.resizeMonitor.monitor();setInterval("axle.resizeMonitor.monitor()",100);return axle.resizeMonitor},init:function(){axle.resizeMonitor.screenAreaProvider=new axle.ScreenAreaProvider;return axle.resizeMonitor.start()}},each:function(e,t){for(var n in e){if(e[n]&&typeof e[n]!="function"){t.apply(e[n])}}},loaded:function(){try{if(window["onAxleLayout"])window["onAxleLayout"].apply(jQuery("body"))}catch(e){axle.reportError(e)}},init:new function(){jQuery(document).ready(function(){axle.constructor()})},constructor:function(){axle.resizeMonitor.init();axle.plugin.jquery.register();axle.processAxleFiles();jQuery("body").axle(axle.loaded)}};