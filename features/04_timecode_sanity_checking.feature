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
		Then All the timecodes should be removed
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
		
		