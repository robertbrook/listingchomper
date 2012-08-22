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

