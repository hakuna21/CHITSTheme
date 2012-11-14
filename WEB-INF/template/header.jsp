<%@ page errorPage="/errorhandler.jsp"
%><%@ page import="org.openmrs.web.WebConstants" %><%
	String useMinimalHeader = (String)session.getAttribute(WebConstants.OPENMRS_HEADER_USE_MINIMAL);
	if ("true".equals(useMinimalHeader)){
	   pageContext.setAttribute("useMinimalHeader", new Boolean(true));
	   session.removeAttribute(WebConstants.OPENMRS_HEADER_USE_MINIMAL);
	}
%><%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"
%><%@ page import="org.openmrs.web.WebConstants" %><%
	pageContext.setAttribute("msg", session.getAttribute(WebConstants.OPENMRS_MSG_ATTR));
	pageContext.setAttribute("msgArgs", session.getAttribute(WebConstants.OPENMRS_MSG_ARGS));
	pageContext.setAttribute("err", session.getAttribute(WebConstants.OPENMRS_ERROR_ATTR));
	pageContext.setAttribute("errArgs", session.getAttribute(WebConstants.OPENMRS_ERROR_ARGS));
	session.removeAttribute(WebConstants.OPENMRS_MSG_ATTR);
	session.removeAttribute(WebConstants.OPENMRS_MSG_ARGS);
	session.removeAttribute(WebConstants.OPENMRS_ERROR_ATTR);
	session.removeAttribute(WebConstants.OPENMRS_ERROR_ARGS);
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">
<head profile="http://gmpg.org/xfn/11">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"></meta>
<title>Community Health Information Tracking System</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/theme/script.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/theme/style.css?v=${deploymentTimestamp}" type="text/css" media="screen"></link>
<!--[if IE 6]><link rel="stylesheet" href="${pageContext.request.contextPath}/theme/style.ie6.css" type="text/css" media="screen" /><![endif]-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/theme/chits.css?v=${deploymentTimestamp}" type="text/css" media="screen"></link>
<meta name="robots" content="noindex,nofollow"></meta>

<openmrs:htmlInclude file="/openmrs.js" />
<openmrs:htmlInclude file="/scripts/openmrsmessages.js" appendLocale="true" />
<%--
<openmrs:htmlInclude file="/openmrs.css" />
<link href="<openmrs:contextPath/><spring:theme code='stylesheet' />" type="text/css" rel="stylesheet" />
<openmrs:htmlInclude file="/style.css" />
--%>
<style>div.Header-jpeg { background-image: url('${pageContext.request.contextPath}${GlobalProperty['chits.banner.image']}'); }</style>
<openmrs:htmlInclude file="/dwr/engine.js" />
<openmrs:htmlInclude file="/dwr/interface/DWRAlertService.js" />
<c:if test="${empty DO_NOT_INCLUDE_JQUERY}">
<openmrs:htmlInclude file="/scripts/jquery/jquery.min.js" />
<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui.custom.min.js" />
<openmrs:htmlInclude file="/scripts/jquery-ui/js/jquery-ui-datepicker-i18n.js" />
<link href="<openmrs:contextPath/>/scripts/jquery-ui/css/<spring:theme code='jqueryui.theme.name' />/jquery-ui.custom.css" type="text/css" rel="stylesheet" />
</c:if>
<%--<link rel="icon" type="image/ico" href="<openmrs:contextPath/><spring:theme code='favicon' />"> --%>
<link rel="icon" type="image/ico" href="<openmrs:contextPath/>/moduleResources/chits/images/chits-openmrs-favicon.ico" />

<c:choose><c:when test="${!empty pageTitle}"><title>${pageTitle}</title></c:when>
<c:otherwise><title><spring:message code="openmrs.title"/></title></c:otherwise></c:choose>

<script type="text/javascript">
<c:if test="${empty DO_NOT_INCLUDE_JQUERY}">
var $j = jQuery.noConflict();
</c:if>
/* variable used in js to know the context path */
var openmrsContextPath = '${pageContext.request.contextPath}';
var dwrLoadingMessage = '<spring:message code="general.loading" />';
var jsDateFormat = '<openmrs:datePattern localize="false"/>';
var jsLocale = '<%= org.openmrs.api.context.Context.getLocale() %>';

/* prevents users getting false dwr errors msgs when leaving pages */
var pageIsExiting = false;
if (jQuery)
    jQuery(window).bind('beforeunload', function () { pageIsExiting = true; } );

var handler = function(msg, ex) {
	if (!pageIsExiting) {
		var div = document.getElementById("openmrs_dwr_error");
		div.style.display = ""; // show the error div
		var msgDiv = document.getElementById("openmrs_dwr_error_msg");
		msgDiv.innerHTML = '<spring:message code="error.dwr"/>' + " <b>" + msg + "</b>";
	}
};
dwr.engine.setErrorHandler(handler);
dwr.engine.setWarningHandler(handler);

function notImplemented() {
	$j('<div></div>').html('Function not yet implemented').dialog({width:350,height:160,title:'Not Implemented',modal:true,buttons:{'OK':function(){$j(this).dialog('close')}}}).dialog('open');
}

function highlightErrors() {
	$j('input[type=button], input[type=submit]').button()
	$j(".error").animate({color:"#d00000",backgroundColor:"#ffff00"}, 2000)
	$j(".openmrs_msg").animate({color:"white",backgroundColor:"green"}, 2000)
	$j(".openmrs_error").animate({color:"#d00000",backgroundColor:"#ffff00"}, 2000)				
}

$j(document).ready(function() {
	highlightErrors()
	// jQuery("#patientTabs").tabs()
})
</script>

<openmrs:extensionPoint pointId="org.openmrs.headerFullIncludeExt" type="html" requiredClass="org.openmrs.module.web.extension.HeaderIncludeExt">
<c:forEach var="file" items="${extension.headerFiles}">
<openmrs:htmlInclude file="${file}" />
</c:forEach>
</openmrs:extensionPoint>
</head>
<%-- Start of template part --%>
<body>
<div class="PageBackgroundSimpleGradient"></div>
<div class="Main" id="pageBody">
<div class="Sheet">
<div class="Sheet-tl"></div><div class="Sheet-tr"><div></div></div><div class="Sheet-bl"><div></div></div><div class="Sheet-br"><div></div></div><div class="Sheet-tc"><div></div></div><div class="Sheet-bc"><div></div></div><div class="Sheet-cl"><div></div></div><div class="Sheet-cr"><div></div></div><div class="Sheet-cc"></div>

<%-- Sheet Body --%>
<div class="Sheet-body">
<%-- Banner --%>
<openmrs:authentication>
<div class="Header">
<div class="Header-jpeg"></div>
<div class="logo">
	<h1 id="name-text" class="logo-name"><span>${GlobalProperty['chits.health.center.name']}</span></h1>
	<div id="slogan-text" class="logo-text"><span>${GlobalProperty['chits.health.center.address']}</span></div>
</div>

<div id="chits-banner"><ul>
<c:choose><c:when test="${authenticatedUser != null}">
<% 
	try {
%><openmrs:portlet url="patientQueueStats" id="patientQueueStats" moduleId="chits"/><%
	} catch (Exception ex) {
		// just ignore -- this happens when CHITS hasn't been started!
		// ex.printStackTrace(); 
   }
%>
<li class="last">User ID: ${chits:coalesce(authenticatedUser.username, authenticatedUser.systemId)}<br/><a href="${pageContext.request.contextPath}/options.form">My Profile</a>&nbsp;<a href="${pageContext.request.contextPath}/logout">Logout</a></li>
</c:when><c:otherwise>
<%-- <li><a href="${pageContext.request.contextPath}/login.htm">Login</a></li> --%>
</c:otherwise></c:choose>
</ul></div>
</div>
<%-- End of Banner --%>

<%-- Content Layout --%>
<div class="contentLayout">
<c:if test="${authenticatedUser != null}">
<%@include file="sidebar.jsp" %>
</c:if>
</openmrs:authentication>							

<%-- Content --%>
<div class="content">
<div class="Post">
<div class="Post-body">
<%-- Start of Post-inner article --%>
<div class="Post-inner article">

<c:choose><c:when test="${useMinimalHeader}"><%@ include file="headerMinimal.jsp" %></c:when>
<c:otherwise><%@ include file="headerFull.jsp" %></c:otherwise></c:choose>
