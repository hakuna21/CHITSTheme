package org.openmrs.module.chits;

import org.openmrs.Concept;
import org.openmrs.api.context.Context;

/**
 * Supports retrieval of a concept ID and caches the results for subsequent calls.
 * 
 * @author Bren
 */
public interface CachedConceptId {
	/** Returns the concept ID cached for subsequent calls */
	public Integer getConceptId();

	/** Returns the name of the concept */
	public String getConceptName();

	public static class CachedConceptNameId {
		private final String name;
		private Integer conceptId;

		public CachedConceptNameId(String name) {
			this.name = name;
		}

		/**
		 * Returns the cached concept ID parameter if not null, otherwise, loads the concept ID from the concept service.
		 * 
		 * @param cachedConcept
		 * @param conceptId
		 * @return
		 */
		public Integer getCachedConceptId() {
			if (conceptId == null) {
				// cache concept Id for subsequent calls
				final Concept concept = Context.getConceptService().getConceptByName(name);
				if (concept == null) {
					throw new IllegalStateException("Concept not defined for name: " + name);
				}

				// cache the concept ID for future reference
				conceptId = concept.getConceptId();
			}

			// return the concept ID
			return conceptId;
		}

		public String getName() {
			return name;
		}
	}
}
