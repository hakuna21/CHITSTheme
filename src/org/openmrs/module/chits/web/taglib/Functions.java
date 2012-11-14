package org.openmrs.module.chits.web.taglib;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.ConceptMap;
import org.openmrs.Encounter;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.PatientProgram;
import org.openmrs.PatientState;
import org.openmrs.Person;
import org.openmrs.api.ConceptService;
import org.openmrs.api.ObsService;
import org.openmrs.api.ProgramWorkflowService;
import org.openmrs.api.context.Context;
import org.openmrs.module.chits.CachedConceptId;
import org.openmrs.module.chits.CachedProgramConceptId;

/**
 * Taglib functions.
 * 
 * @author Bren
 */
public class Functions {
	/** Logger for this class and subclasses */
	protected final static Log log = LogFactory.getLog(Functions.class);

	/**
	 * Returns an ordered List of observation matching the given concept name sorted by ascending observation date / time.
	 * <ul>
	 * <li>If the 'var' parameter is an Encounter, the encounter's observations are searched.</li>
	 * <li>If the 'var' parameter is an Obs, the observation group's members are searched.</li>
	 * <li>If the 'var' parameter is a Person, all matching observations for that person are returned.</li>
	 * </ul>
	 * 
	 * @param encounterOrObsOrPerson
	 *            Either an {@link Encounter}, an {@link Obs}, or a {@link Person} instance.
	 * @return A {@link List} of {@link Obs} instances.
	 */
	public static List<Obs> observations(Object encounterOrObsOrPerson, Object concept) {
		// return the observations matching the concept name
		final List<Obs> observations = new ArrayList<Obs>();

		Integer conceptId;
		if (concept instanceof Concept) {
			conceptId = ((Concept) concept).getConceptId();
		} else if (concept instanceof CachedConceptId) {
			conceptId = ((CachedConceptId) concept).getConceptId();
		} else {
			throw new IllegalArgumentException("Unknown concept type: " + concept);
		}

		if (encounterOrObsOrPerson instanceof Encounter) {
			// search the observations in this encounter
			for (Obs obs : ((Encounter) encounterOrObsOrPerson).getObsAtTopLevel(false)) {
				if (conceptId.equals(obs.getConcept().getConceptId())) {
					observations.add(obs);
				}
			}
		} else if (encounterOrObsOrPerson instanceof Obs) {
			// search the group members of this observation
			final Set<Obs> members = ((Obs) encounterOrObsOrPerson).getGroupMembers();
			if (members != null) {
				for (Obs obs : members) {
					if (!Boolean.TRUE.equals(obs.isVoided()) && conceptId.equals(obs.getConcept().getConceptId())) {
						observations.add(obs);
					}
				}
			}
		} else if (encounterOrObsOrPerson instanceof Person) {
			// search the person's observations
			final ObsService obsService = Context.getObsService();
			final ConceptService conceptService = Context.getConceptService();
			observations.addAll(obsService.getObservationsByPersonAndConcept((Person) encounterOrObsOrPerson, conceptService.getConcept(conceptId)));
		} else if (encounterOrObsOrPerson != null) {
			// invalid! return an empty list but log the error
			log.warn("Unsupported data type passed: " + encounterOrObsOrPerson.getClass());
		}

		// sort the observations by ascending date and time
		Collections.sort(observations, new Comparator<Obs>() {
			@Override
			public int compare(Obs o1, Obs o2) {
				// NOTE: obsDateTime is a 'NOT-NULL' property of the Obs entity, so there is no need for null checking!
				int comp = o1.getObsDatetime().compareTo(o2.getObsDatetime());
				if (comp == 0 && o1.getObsId() != null && o2.getObsId() != null) {
					// for items of the same timestamp, sort by ascending observation ID
					comp = o1.getObsId().compareTo(o2.getObsId());
				}

				return comp;
			}
		});

		// send back the matching observations
		return observations;
	}

	/**
	 * Returns the first (i.e., most recent) observation matching the given concept name, or null if the observation was not found.
	 * <ul>
	 * <li>If the 'var' parameter is an Encounter, the encounter's first matching observation is returned.</li>
	 * <li>If the 'var' parameter is an Obs, the observations group member's first matching observation is returned.</li>
	 * <li>If the 'var' parameter is a Person, the first matching observation for that person is returned.</li>
	 * </ul>
	 * 
	 * @param encounterOrObsOrPerson
	 *            Either an {@link Encounter}, an {@link Obs}, or a {@link Person} instance.
	 * @return The first matching {@link Obs} (observation).
	 */
	public static Obs observation(Object encounterOrObsOrPerson, Object concept) {
		final List<Obs> observations = observations(encounterOrObsOrPerson, concept);
		if (observations.size() > 0) {
			// return last matching (i.e., most recent) matching observation
			return observations.get(observations.size() - 1);
		}

		// no matching observation
		return null;
	}

	/**
	 * Returns the concept with the given name.
	 * 
	 * @param conceptName
	 *            The name of the concept.
	 * @return The name of the concept
	 */
	public static Concept concept(CachedConceptId cachedConcept) {
		return Context.getConceptService().getConcept(cachedConcept.getConceptId());
	}

	/**
	 * Returns the concept with the given name or id.
	 * 
	 * @param conceptName
	 *            The name of the concept.
	 * @return The name of the concept
	 */
	public static Concept conceptByIdOrName(String conceptIdOrName) {
		if (conceptIdOrName != null) {
			return Context.getConceptService().getConcept(conceptIdOrName);
		} else {
			return null;
		}
	}

	/**
	 * Return the corresponding mapping source code value for the given concept and source name.
	 * 
	 * @param concept
	 *            The concept to retrieve the mapping source code of
	 * @param sourceName
	 *            The source name of the mapping to look for
	 * @return The source code value of the concept for the given source name mapping
	 */
	public static String mapping(Concept concept, String sourceName) {
		if (concept != null) {
			for (ConceptMap cm : concept.getConceptMappings()) {
				if (cm != null && cm.getSource() != null && cm.getSource().getName() != null && cm.getSource().getName().equalsIgnoreCase(sourceName)) {
					return cm.getSourceCode();
				}
			}
		}

		// ICD10 code was not found
		return null;
	}

	/**
	 * Returns the concepts that answer the given cached concept question sorted by sortWeight.
	 * 
	 * @param cachedConcept
	 *            The concept to retrieve the concept answers of
	 * @return A List of concepts that are answers to the concept
	 */
	public static List<Concept> answers(CachedConceptId cachedConcept) {
		final List<Concept> answers = new ArrayList<Concept>();

		// sort the answers by 'sortWeight'
		final List<ConceptAnswer> sortedCAs = new ArrayList<ConceptAnswer>(concept(cachedConcept).getAnswers());
		Collections.sort(sortedCAs);

		// add each concept answer to the return value
		for (ConceptAnswer ca : sortedCAs) {
			answers.add(ca.getAnswerConcept());
		}

		return answers;
	}

	/**
	 * Returns the concepts set members that belong to the concept parent.
	 * 
	 * @param cachedConcept
	 *            The concept set to retrieve the concept members of
	 * @return A List of concepts that are members of the concept set
	 */
	public static List<Concept> members(CachedConceptId cachedConcept) {
		// return set members
		return new ArrayList<Concept>(concept(cachedConcept).getSetMembers());
	}

	/**
	 * Returns whether the patient is currently active in the given program.
	 * 
	 * @param patient
	 *            The patient to check if currently active in the given program.
	 * @param cachedProgram
	 *            The program to check if the patient is active in
	 * @return If the patient is currently active in the given program
	 */
	public static boolean isInProgram(Patient patient, CachedProgramConceptId cachedProgram) {
		return getActivePatientProgram(patient, cachedProgram) != null;
	}

	/**
	 * Finds the active {@link PatientProgram} record for the given patient (i.e., where dateCompleted == null). It is assumed that a patient will have only one
	 * active program record at a time; if patient has multiple active records for a program, only the first will be returned.
	 * 
	 * @param patient
	 *            The patient to get the active program for (i.e., where dateCompleted == null)
	 * @param cachedProgram
	 *            The program ID enum constant
	 * @return The {@link PatientProgram} record where the patient is currently active in, if any.
	 */
	public static PatientProgram getActivePatientProgram(Patient patient, CachedProgramConceptId cachedProgram) {
		final Date now = new Date();
		final ProgramWorkflowService svc = Context.getProgramWorkflowService();

		// get programs where patient is active based on today's date
		final List<PatientProgram> programs = svc.getPatientPrograms(patient, svc.getProgram(cachedProgram.getProgramId()), null, now, now, null, false);
		PatientProgram activeProgram = null;
		for (PatientProgram program : programs) {
			if (program.getDateCompleted() == null) {
				if (activeProgram == null) {
					// this is the program that should be considered 'active' for the patient
					activeProgram = program;
				} else {
					// patient has multiple records that are 'active'... log a warning and ignore the subsequent records
					log.warn("Patient (" + patient + ") active in more than one program instance for: " + cachedProgram);
				}
			}
		}

		// return the program that the patient is currently active in (if any)
		return activeProgram;
	}

	/**
	 * Filters a List of observations to include only those with the specified coded value.
	 * 
	 * @param listToFilter
	 *            The list to filter
	 * @return A new list containing only those items that are instances of {@link Obs} and have coded values as specified.
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List filterByCodedValue(List listToFilter, CachedConceptId matchingCodedValue) {
		final List filtered = new ArrayList();
		final Concept c = concept(matchingCodedValue);
		for (Object o : listToFilter) {
			if (o instanceof Obs) {
				final Obs obs = (Obs) o;
				if (c.equals(obs.getValueCoded())) {
					// matches, so add to result
					filtered.add(obs);
				}
			}
		}
		return filtered;
	}

	/**
	 * Returns a reversed version of the given list
	 * 
	 * @param listToReverse
	 *            The list to reverse
	 * @return A new list containing the same items, but in reverse
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static List reverse(List listToFilter) {
		final List reversed = new ArrayList();
		reversed.addAll(listToFilter);
		Collections.reverse(reversed);

		return reversed;
	}

	/**
	 * Returns the state record of the patient, but only if the patient is currently active in the program.
	 * 
	 * @param patient
	 *            The patient to get the patient program state of
	 * @param cachedProgram
	 *            The program to get the patient's state of
	 * @param cachedState
	 *            The state to get the patient state record of.
	 * @return the patient state record in the given program if found and the patient is currently active in the program.
	 */
	public static PatientState getPatientState(Patient patient, CachedProgramConceptId cachedProgram, CachedConceptId cachedState) {
		// get programs where patient is active based on today's date
		final PatientProgram program = getActivePatientProgram(patient, cachedProgram);
		if (program != null) {
			for (PatientState state : program.getStates()) {
				if (cachedState.getConceptId().equals(state.getState().getConcept().getId())) {
					// this is the state we were looking for
					return state;
				}
			}
		}

		// patient does not have that state
		return null;
	}

	/**
	 * Finds the matching state record of the given patientProgram, if found.
	 * 
	 * @param patientProgram
	 *            The patient program to search the patient program state of
	 * @param cachedState
	 *            The state to get the patient program state record of.
	 * @return the patient state record in the given patient program if found
	 */
	public static PatientState findPatientProgramState(PatientProgram patientProgram, CachedConceptId cachedState) {
		// get programs where patient is active based on today's date
		if (patientProgram != null) {
			for (PatientState state : patientProgram.getStates()) {
				if (cachedState.getConceptId().equals(state.getState().getConcept().getId())) {
					// this is the state we were looking for
					return state;
				}
			}
		}

		// patient program does not have that state
		return null;
	}

	/**
	 * Returns the first non-null object (or in the case of strings, non-empty) of the two.
	 * 
	 * @param o1
	 *            The first object - will be returned if non-null
	 * @param o2
	 *            The second object - will be returned if o1 is null
	 * @return o1 if non null, otherwise o2
	 */
	public static Object coalesce(Object o1, Object o2) {
		if (o1 != null) {
			if (!(o1 instanceof String) || !StringUtils.isEmpty((String) o1)) {
				// o1 is not null and not an empty string (or not a string at all...)
				return o1;
			}
		}

		// either o1 is null or is an empty string, so return o2 regardless
		return o2;
	}

	/**
	 * Returns the concept used to represent a 'true' coded value for Obs with a Boolean datatype.
	 * 
	 * @return The concept used to represent true or yes.
	 */
	public static Concept trueConcept() {
		return Context.getConceptService().getTrueConcept();
	}

	/**
	 * Returns the concept used to represent a 'false' coded value for Obs with a Boolean datatype.
	 * 
	 * @return The concept used to represent false or no.
	 */
	public static Concept falseConcept() {
		return Context.getConceptService().getFalseConcept();
	}

	/**
	 * Returns the latest patient program record that the patient has been enrolled in (whether active or completed) based on the enrollment date.
	 * 
	 * @param patient
	 *            The patient to get the latest patient program of
	 * @param cachedProgram
	 *            The program to get the latest record for
	 * @return The latest patient program record for the patient, or null if never been enrolled
	 */
	public static PatientProgram getLatestPatientProgram(Patient patient, CachedProgramConceptId cachedProgram) {
		// get all patient program records where patient has been enrolled into this program
		PatientProgram latestProgram = null;

		final ProgramWorkflowService svc = Context.getProgramWorkflowService();
		final List<PatientProgram> programs = svc.getPatientPrograms(patient, svc.getProgram(cachedProgram.getProgramId()), null, null, null, null, false);
		for (PatientProgram program : programs) {
			if (program.getDateEnrolled() != null) {
				if (latestProgram == null) {
					// this is the only program found yet
					latestProgram = program;
				} else if (program.getDateEnrolled().after(latestProgram.getDateEnrolled())) {
					// this program was registered at a later date
					latestProgram = program;
				} else if (program.getDateEnrolled().equals(latestProgram.getDateEnrolled()) && program.getId() > latestProgram.getId()) {
					// this program was registered at the exact same date, but since it has a higher primary key ID, it is considered to be later
					latestProgram = program;
				}
			}
		}

		// return the latest patient program record found (if any)
		return latestProgram;
	}
}
