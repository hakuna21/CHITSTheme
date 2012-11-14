package org.openmrs.module.chits.audit;

import java.io.Serializable;
import java.util.Date;

import org.openmrs.User;

/**
 * Stores information about a request. This bean was designed to be used together with hibernate for storage into the database.
 * 
 * @author Bren
 */
@SuppressWarnings("serial")
public class UserSessionInfo implements Serializable {
	/** Primary key ID */
	private Integer userSessionInfoId;

	/** The session identifier */
	private String sessionId;

	/** The IP address of the remote host */
	private String remoteAddress;

	/** The user agent passed-in by the browser */
	private String userAgent;

	/** The authenticated user */
	private User user;

	/** The time the user logged-in to the system */
	private Date loginTimestamp;

	/** The time the user logged-out of the system */
	private Date logoutTimestamp;

	/** Indicates if the session timed out */
	private boolean sessionTimedOut;

	public String getSessionId() {
		return sessionId;
	}

	public Integer getUserSessionInfoId() {
		return userSessionInfoId;
	}

	public void setUserSessionInfoId(Integer userSessionInfoId) {
		this.userSessionInfoId = userSessionInfoId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getRemoteAddress() {
		return remoteAddress;
	}

	public void setRemoteAddress(String remoteAddress) {
		this.remoteAddress = remoteAddress;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getLoginTimestamp() {
		return loginTimestamp;
	}

	public void setLoginTimestamp(Date loginTimestamp) {
		this.loginTimestamp = loginTimestamp;
	}

	public Date getLogoutTimestamp() {
		return logoutTimestamp;
	}

	public void setLogoutTimestamp(Date logoutTimestamp) {
		this.logoutTimestamp = logoutTimestamp;
	}

	public boolean isSessionTimedOut() {
		return sessionTimedOut;
	}

	public void setSessionTimedOut(boolean sessionTimedOut) {
		this.sessionTimedOut = sessionTimedOut;
	}

	@Override
	public String toString() {
		return "UserSessionInfo [userSessionInfoId=" + userSessionInfoId + ", sessionId=" + sessionId + ", remoteAddress=" + remoteAddress + ", userAgent="
				+ userAgent + ", user=" + user + ", loginTimestamp=" + loginTimestamp + ", logoutTimestamp=" + logoutTimestamp + "]";
	}
}
