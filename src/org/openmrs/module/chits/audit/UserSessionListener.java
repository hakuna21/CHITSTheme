package org.openmrs.module.chits.audit;

/**
 * Listeners that want to register to user login / logout events should implement the methods in this interface and register themselves with the
 * {@link UserSessionTracker} singleton.
 * 
 * @author Bren
 */
public interface UserSessionListener {
	/**
	 * A User has just logged in.
	 * 
	 * @param event
	 *            Contains information about the user session.
	 */
	public void userSessionCreated(UserSessionEvent event);

	/**
	 * A User has been logged out.
	 * 
	 * @param event
	 *            Contains information about the user session.
	 */
	public void userSessionDestroyed(UserSessionEvent event);
}
