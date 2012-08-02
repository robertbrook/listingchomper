require 'process'

describe Process do

  context "with a local listing.txt file" do
    it "should open the file" 
  end

  
  it "should check section contiguity"
  # Disregard any Sent folders which do not contain a contiguous set of xml documents
  # We can check contiguity by polling Sent\files.txt (or files.htm) if that's easier than scanning each folder, although the filelisting in those files is chronological (by production time) rather than alphabetical.
  
  it "should check for latest section version"
  # Disregard superseded .xml files, ie. all those with identical Sections but anything other than the highest version number, eg AA-AD1-v0.xml can be disregarded in favour of AA-AD1-v2.xml
  
  it "should check for timecodes"
  # Check each remaining file for timecodes, indicated by the tag <hs_TimeCode time="dateTime" /> where dateTime looks something like: <hs_TimeCode time="2010-06-02T15:14:31" />
  # IF there are timecodes, check for timecode anomalies. IF NOT, rerender timecodes.
  
  it "should check for timecode anomalies"
  # Check that timecodes are sequential.
  # IF they are sequential, job done, queue up that file for subsequent processing or whatever it is we're going to do: queue for processing.
  # IF NOT, delete anomalous timecodes.
  
  it "should delete anomalous timecodes"
  
  it "should rerender timecodes"
  
  it "should repurpose timetags"
  
  it "should queue for processing"
  
end


