package org.openmrs.module.chits.audit;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.openmrs.User;
import org.openmrs.module.chits.audit.UserSessionInfo;

/**
 * Intercepts the LoginServlet's doPost() method and CurrentUsers addUser() and removeUser() methods to post-process the login and logout mechanism for auditing
 * purposes since there is no direct way of adding extension points to those components.
 * 
 * @author Bren
 */
public privileged aspect UserSessionTrackingAspect {
	pointcut doPost(): execution(void org.openmrs.web.servlet.LoginServlet.doPost(HttpServletRequest, HttpServletResponse));

	pointcut addUser(): execution(* org.openmrs.web.user.CurrentUsers.addUser(HttpSession, User));

	pointcut removeUser(): execution(* org.openmrs.web.user.CurrentUsers.removeUser(HttpSession));

	before(HttpServletRequest req, HttpServletResponse res): doPost() && args(req, res) {
		// store information from the login servlet into the session
		final HttpSession session = req.getSession();
		final UserSessionInfo usi = new UserSessionInfo();
		usi.setSessionId(session.getId());
		usi.setRemoteAddress(req.getRemoteAddr());
		String userAgent = req.getHeader("User-Agent");
		if (userAgent != null && userAgent.length() > 128) {
			userAgent = userAgent.substring(0, 128);
		}
		
		// store user agent (max length = 128 chars)
		usi.setUserAgent(userAgent);

		// store user session info in the servlet context
		session.getServletContext().setAttribute(toServletContextKey(session), usi);
	}

	before(HttpSession session, User user): addUser() && args(session, user) {
		// obtain the request info from the servlet context
		final ServletContext servletContext = session.getServletContext();

		// obtain the request info from the session
		UserSessionInfo usi = (UserSessionInfo) servletContext.getAttribute(toServletContextKey(session));
		if (usi == null) {
			// create a blank request info instance containing just the session ID
			usi = new UserSessionInfo();
			usi.setSessionId(session.getId());

			// store into the session
			servletContext.setAttribute(toServletContextKey(session), usi);
		}

		// store the authenticated user
		usi.setUser(user);
		usi.setLoginTimestamp(new Date());

		// notify the UserSessionTracker
		final UserSessionTracker userSessionTracker = (UserSessionTracker) servletContext.getAttribute(UserSessionTracker.class.getName());
		if (userSessionTracker != null) {
			userSessionTracker.fireSessionCreated(servletContext, usi);
		}
	}

	before(HttpSession session): removeUser() && args(session) {
		// obtain the request info from the servlet context
		final ServletContext servletContext = session.getServletContext();

		try {
    		// load session data from servlet context
    		UserSessionInfo usi = (UserSessionInfo) servletContext.getAttribute(toServletContextKey(session));
    		if (usi != null) {
    			// update logout timestamp
    			usi.setLogoutTimestamp(new Date());
    
    			// notify the UserSessionTracker
    			final UserSessionTracker userSessionTracker = (UserSessionTracker) servletContext.getAttribute(UserSessionTracker.class.getName());
    			if (userSessionTracker != null) {
    				userSessionTracker.fireSessionDestroyed(servletContext, usi);
    			}
    		} else {
    			// not necessarily an error: perhaps the user never successfully logged-in
    			System.out.println("No UserSessionInfo attached to session with ID: " + session.getId());
    		}
		} finally {
			// session no longer needed
			servletContext.removeAttribute(toServletContextKey(session));
		}
	}
	
	private String toServletContextKey(HttpSession session) {
		return UserSessionInfo.class.getName() + "_" + session.getId();
	}
}
