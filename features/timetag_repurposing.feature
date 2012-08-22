
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
		
