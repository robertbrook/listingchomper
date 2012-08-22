Feature: File List Processing
	# The main process loop - everything starts from here
	
	Scenario: Input file missing
		Given the input path "missing-listing.txt"
		When the file processing starts
		Then it should log the error "missing input file"
		And the process should stop

	Scenario: Basic input file processing
		Given the input path "listing.txt"
		When the file processing starts
		Then it should create the working file "[datefromdirectory]_for_processing.txt"
		And the file should contain one day's worth of data from the Sent Folder
		And the output should be queued for contiguity checking


Feature: Contiguity Testing
	# Make sure the day's file set makes sense before trying to process the individual files

	Scenario: Non-contiguous file set
		Given "[datefromdirectory]_for_processing.txt" contains a non-contiguous list of xml documents
		When the list is tested
		Then the folder should be disregarded
		And an error should be written to the log file
			# Disregard any Sent folders which do not contain a contiguous set of xml documents
			# We can check contiguity by polling Sent\files.txt (or files.htm) 
			#  if that's easier than scanning each folder, although the filelisting 
			#  in those files is chronological (by production time) rather than alphabetical.
		And the process should stop

	Scenario: Multiple versions available, disregard old versions
		Given "[datefromdirectory]_for_processing.txt" contains a contiguous list of xml documents
		And the file list contains "AA-AD1-v0.xml" and "AA-AD1-v2.xml" 
		When the list is tested
		Then "AA-AD1-v0.xml" should be removed from "[datefromdirectory]_for_processing.txt"
		And "[datefromdirectory]_for_processing.txt" should be queued for processing at an individual file level