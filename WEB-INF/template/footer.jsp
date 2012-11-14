<% session.removeAttribute(org.openmrs.web.WebConstants.OPENMRS_HEADER_USE_MINIMAL); %>

<script type="text/javascript">
var oldOnLoad = window.onload
function init2() {
	if (oldOnLoad) {
		oldOnLoad();
		jQuery("#optionsForm").tabs()
	}
}

window.onload = init2
</script>
	   
<c:choose><c:when test="${useMinimalHeader}"><%@ include file="footerMinimal.jsp" %>
</c:when><c:otherwise><%@ include file="footerFull.jsp" %></c:otherwise></c:choose>
