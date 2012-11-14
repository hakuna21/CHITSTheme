package org.openmrs.module.chits.audit;

import java.util.EventObject;

import javax.servlet.ServletContext;

/**
 * Encapsulate a user session event (login or logoff) attached to a {@link UserSessionInfo} object.
 * 
 * @author Bren
 */
@SuppressWarnings("serial")
public class UserSessionEvent extends EventObject {
	/** The {@link UserSessionInfo} information */
	private final UserSessionInfo userSessionInfo;

	/** The {@link ServletContext} when this event was fired */
	private ServletContext servletContext;

	/**
	 * A user session event containing {@link UserSessionInfo} information
	 * 
	 * @param userSessionInfo
	 *            The {@link UserSessionInfo} information
	 */
	public UserSessionEvent(UserSessionInfo userSessionInfo) {
		super(userSessionInfo);
		this.userSessionInfo = userSessionInfo;
	}

	public UserSessionInfo getUserSessionInfo() {
		return userSessionInfo;
	}

	public ServletContext getServletContext() {
		return servletContext;
	}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@Override
	public String toString() {
		return "UserSessionEvent [userSessionInfo=" + userSessionInfo + "]";
	}
}
