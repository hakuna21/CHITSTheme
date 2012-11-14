package org.openmrs.module.chits;

import org.openmrs.Program;
import org.openmrs.api.context.Context;

/**
 * Supports retrieval of a program ID and caches the results for subsequent calls in addition to the underlying {@link CachedConceptId}
 * 
 * @author Bren
 */
public interface CachedProgramConceptId extends CachedConceptId {
	/** Returns the "Program" workflow states of the program */
	public CachedConceptId[] getStates();

	/** Returns the program ID cached for subsequent calls */
	public Integer getProgramId();

	/**
	 * Utility helper class for obtaining the program Id if a cached value is not yet available.
	 * 
	 * @author Bren
	 */
	public static class CachedProgramNameId {
		private final String name;
		private Integer programId;

		public CachedProgramNameId(String name) {
			this.name = name;
		}

		/**
		 * Returns the cached program ID parameter if not null, otherwise, loads the program ID from the program workflow service.
		 * 
		 * @param cachedProgram
		 * @param programId
		 * @return
		 */
		public Integer getCachedProgramId() {
			if (programId == null) {
				// cache program Id for subsequent calls
				final Program program = Context.getProgramWorkflowService().getProgramByName(name);
				programId = program != null ? program.getProgramId() : null;
			}

			// return the program ID
			return programId;
		}
	}
}
