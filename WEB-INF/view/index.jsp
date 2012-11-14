<%@ include file="/WEB-INF/template/include.jsp" %>
<spring:message var="pageTitle" code="index.title" scope="page"/>
<%@ include file="/WEB-INF/template/header.jsp" %>

<c:set var="anyExtension" value="false" />
<openmrs:authentication>
	<c:if test="${authenticatedUser != null}">
		<openmrs:extensionPoint pointId="org.openmrs.navigation.homepage" type="html" varStatus="status">
			<c:set var="anyExtension" value="true" />
			<openmrs:portlet url="${extension.portletUrl}" parameters="${extension.portletParameters}" moduleId="${extension.moduleId}" />
		</openmrs:extensionPoint>
	</c:if>
</openmrs:authentication>

<c:if test="${not anyExtension}">
	<c:choose><c:when test="${authenticatedUser != null}">
		<p><h3>Welcome to the Community Health Information Tracking System (CHITS)</h3></p>
		<p>CHITS is a system which stores patient medical records.  The system aims to provide centralized record tracking per health center and aide health workers on their field assignments.</p>
	</c:when><c:otherwise>
		<center>
		<br/><br/><br/>
		<%-- <img src="${pageContext.request.contextPath}<spring:theme code="image.logo.large" text="/images/openmrs_logo_white_large.png"/>" alt='<spring:message code="openmrs.title"/>' title='<spring:message code="openmrs.title"/>'/> --%>
		<openmrs:portlet url="welcome" parameters="showName=true|showLogin=true" />
		</center>
	</c:otherwise></c:choose>
</c:if>

<br />

<%@ include file="/WEB-INF/template/footer.jsp" %> 