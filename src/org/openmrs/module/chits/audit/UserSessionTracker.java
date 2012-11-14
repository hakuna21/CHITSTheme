package org.openmrs.module.chits.audit;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * A helper event dispatcher for tracking / auditing user sessions.
 * 
 * @author Bren
 */
public class UserSessionTracker {
	/** Logger for this class and subclasses */
	protected final Log log = LogFactory.getLog(getClass());

	/** Contains all the user session listeners */
	private final Set<UserSessionListener> listeners = Collections.synchronizedSet(new HashSet<UserSessionListener>());

	public void addUserSessionListener(UserSessionListener listener) {
		listeners.add(listener);
	}

	public void removeUserSessionListener(UserSessionListener listener) {
		listeners.remove(listener);
	}

	/**
	 * Fires the session created event.
	 * 
	 * @param usi
	 *            The {@link UserSessionInfo} bean associated with this object
	 */
	public void fireSessionCreated(ServletContext servletContext, UserSessionInfo usi) {
		// create an event
		final UserSessionEvent event = new UserSessionEvent(usi);
		event.setServletContext(servletContext);

		// log the event
		log.info("User Login Event: " + usi);

		// notify the listeners
		notifyListeners(event, true);
	}

	/**
	 * Fires the session destroyed event.
	 * 
	 * @param usi
	 *            The {@link UserSessionInfo} bean associated with this object
	 */
	public void fireSessionDestroyed(ServletContext servletContext, UserSessionInfo usi) {
		// create an event
		final UserSessionEvent event = new UserSessionEvent(usi);
		event.setServletContext(servletContext);

		// log the event
		log.info("User Logoff Event: " + usi);

		// notify the listeners
		notifyListeners(event, false);
	}

	/**
	 * Dispatches the event to all listeners
	 * 
	 * @param event
	 *            The event to dispatch
	 * @param sessionCreated
	 *            If the session was created (or destroyed)
	 */
	private void notifyListeners(UserSessionEvent event, boolean created) {
		for (UserSessionListener listener : listeners) {
			try {
				if (created) {
					// user logged in (or session expired)
					listener.userSessionCreated(event);
				} else {
					// user logged off (or session expired)
					listener.userSessionDestroyed(event);
				}
			} catch (Exception ex) {
				// log the error
				log.error("Error notifying listener: " + event, ex);
			}
		}
	}
}
