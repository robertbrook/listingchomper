Feature: Processing

        Scenario: Opening the local noverlisting.txt file
                Given the input noverlisting.txt
                When the file is processed
                Then the file should be present
   
