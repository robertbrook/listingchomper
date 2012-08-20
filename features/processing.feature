Feature: Processing

        Scenario: Opening the local listing.txt file
                Given the input listing.txt
                When the file is processed
                Then the file should be present

        Scenario: Opening the local listing.txt file
                Given the input listing.txt
                When asked to isolate a single day's worth of data
                Then the single day's worth of data should be returned
                    # Also consider the listing file could only contain one day's worth of data?


        Scenario: Checking section contiguity
                Given a sent folder which does not contain a contiguous set of xml documents
                When the file is processed
                Then the folder should be disregarded
                
    # Disregard any Sent folders which do not contain a contiguous set of xml documents

  # We can check contiguity by polling Sent\files.txt (or files.htm) if that's easier than scanning each folder, although the filelisting in those files is chronological (by production time) rather than alphabetical.
  
        
        Scenario: Checking latest section version
                Given all those with identical Sections but anything other than the highest version number
                When the file is processed
                Then disregard superceded xml files
          # Disregard superseded .xml files, ie. all those with identical Sections but anything other than the highest version number, eg AA-AD1-v0.xml can be disregarded in favour of AA-AD1-v2.xml

        
        Scenario: Checking for timecodes
                Given a candidate XML file
                When a timecode is found
                Then the timecode should be processed
                
                 # Check each remaining file for timecodes, indicated by the tag <hs_TimeCode time="dateTime" /> where dateTime looks something like: <hs_TimeCode time="2010-06-02T15:14:31" />
  # IF there are timecodes, check for timecode anomalies. IF NOT, rerender timecodes.
        
        Scenario: Checking for timecode anomalies
                Given a candidate XML file
                When an anomalous timecode is found
                Then the anomalous timecode should be deleted
        
         # Check that timecodes are sequential.
  # IF they are sequential, job done, queue up that file for subsequent processing or whatever it is we're going to do: queue for processing.
  # IF NOT, delete anomalous timecodes.
  
   # If timecodes are not sequential, we need to understand in what way. In the sequence [1 2 4 3] the number 4 is out of sequence. The simplest thing is simply to delete it.
  # Most anomalies in timecodes will be more complex than the above example, eg. [1 2 3 10 5 4 6 7 9 8]
  # Removing anomalous timecodes leaves us with [1 2 3 5 6 7 8]
  # Each section will generally average about 15-25 minutes of copy, so the scope of error being introduced here is limited. If that all looks fine, queue for processing.
  # If not, another form of sequencing anomaly looks like this: [1 1 1 1] etc.
  # ie. all the timecodes in a Section are identical. In this case, we can recover some data by deleting all the timecodes and repurposing the <hs_time> tag (repurpose timetags). Not perfect, but better than nothing.

        
        Scenario: Rerendering timecodes
        
         # If an .xml file contains no timecodes at all, check whether there are timecodes in the corresponding .doc file.
  # If the .doc file contains timecodes (in the form of Word Comments), rerender the .xml file from it, including the timecodes, and then run that through the sequencing test above.
  
        
        Scenario: Repurposing timetags
          # If the .doc file does not contain timecodes, we have no data to recover and must resort to repurposing the <hs_time> tag. Where have the tag <hs_time>3.14 pm</hs_time> we can add the timecode <hs_TimeCode time="[datefromdirectory]T15:14:00" /> where datefromdirectory will look like, eg, 2010-06-02.

        Scenario: Writing log files
                Given a processing run
                When the process is running
                Then the log should be written
                    #should include all the deleted timecodes
    #should report that the timecodes were re-rendered
    #should report any repurposing of the hs_time tag
    #should report a complete failure to find/create timecodes
    #should report that a file was queued for processing

        
        Scenario: Queueing for processing
          # Something clever will presumably happen at this point.

        
        
        
        
