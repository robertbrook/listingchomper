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
		
			
Feature: Timecode sanity checking
	Check each file for timecodes, indicated by the tag <hs_TimeCode time="dateTime" />
	where dateTime looks something like: <hs_TimeCode time="2010-06-02T15:14:31" />
		
	Scenario: Non-sequential timecodes
		Given a candidate XML file
		When an anomalous timecode is found
		Then the anomalous timecode should be deleted
			# If timecodes are not sequential, we need to understand in what way. 
			# In the sequence [1 2 4 3] the number 4 is out of sequence. The simplest thing is simply to delete it.
			# Most anomalies in timecodes will be more complex than the above example, eg. [1 2 3 10 5 4 6 7 9 8]
			# Removing anomalous timecodes leaves us with [1 2 3 5 6 7 8]
			# Each section will generally average about 15-25 minutes of copy, 
			# so the scope of error being introduced here is limited
		And a warning message should be written to the log file
		And the file should be queued for further processing
	
	Scenario: Original or rerendered file's timecode sequence makes no sense
		Given a non-repurposed candidate XML file
		When the timecodes are all the same (ie [1 1 1 1] etc)
		All the timecodes should be removed
		Then the output file should be queued for repurposing
		
	Scenario: Repurposed file's timecode sequence makes no sense
		Given a repurposed candidate XML file
		When the timecodes are all the same (ie [1 1 1 1] etc)
		Then an error should be written to the log file
		And the process move on to the next file
	
	Scenario: Sequential timecodes
		Given a candidate XML file
		When sequential timecodes are found
		Then the file should be queued for further processing
		
		
Feature: Timecode Regeneration
	"Regenerating" the xml file with properly formatted - and hopefully sequenced - timecodes
	 from the Word Comments in the matching .doc file

	Scenario: Failed rerender - missing .doc file
		Given an xml file with no timecodes
		When the matching .doc file is not found
		Then the original file should be queued for timetag repurposing

	Scenario: Failed rerender - no timecodes in .doc file
		Given an xml file with no timecodes
		And a matching .doc file
		When the .doc file contains no recoverable timecodes
		Then the original file should be queued for timetag repurposing
			
	Scenario: Successful rerender
		Given an xml file with no timecodes
		And a matching .doc file
		When the .doc file contains timecodes in the form of Word comments
		Then the file should be regenerated as [filename].regenerated.xml
		And a message should be written to the log file
		And the output file should be queued for sanity checking


Feature: Timetag Repurposing
	If the .doc file does not contain timecodes, we have no data to recover and must resort 
	to repurposing the <hs_time> tag. Where have the tag <hs_time>3.14 pm</hs_time> 
	we can add the timecode <hs_TimeCode time="[datefromdirectory]T15:14:00" /> where 
	datefromdirectory will look like, eg, 2010-06-02.

	Scenario: Successful repurposing
		Given an xml file with no timecodes
		When the repurposing process runs
		Then the file should be regenerated as [filename].repurposed.xml
		And a message should be written to the log file
		And the output file should be queued for sanity checking
		
	Scenario: Failed repurpose - timetags not found
		Given an xml file with no timecodes
		When the repurposing process runs
		Then an error should be written to the log file
		And the process should move on to the next file
		

Feature: Processing
	Something clever will presumably happen at this point.