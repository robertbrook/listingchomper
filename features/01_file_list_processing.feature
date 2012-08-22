Feature: File List Processing

	The main process loop - everything starts from here
	
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


