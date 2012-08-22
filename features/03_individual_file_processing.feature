Feature: Individual File Processing

	Iterate over each individual file to:
		a) make sure it makes sense
		b) attempt to fix it if it doesn't make sense
		c) queue it for "further processing" if it all checks out

	Scenario: The file contains TimeCode tags
		Given a candidate XML file
		When timecodes are found
		Then the file should be queued for sanity checking
		
	Scenario: The file does not contain TimeCode tags
		Given a candidate XML file
		When no timecodes are found
		Then the file should be queued for rerendering
		And a note should be made in the log file
		
