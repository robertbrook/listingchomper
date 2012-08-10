
def process()
        open_the_file()
        check_section_contiguity()
        check_latest_section_version()
        check_for_timecodes()
        check_for_timecode_anomalies()
        delete_anomalous_timecodes()
        rerender_timecodes()
        repurpose_timetags()
        queue_for_processing()
end

def open_the_file()
        listingfile = File.new("noverlisting.txt")
        listinglines = listingfile.readlines

        lines_to_ignore = listinglines[0..3]
end

def check_section_contiguity()
end

def check_latest_section_version()
end

def check_for_timecodes()
end

def check_for_timecode_anomalies()
end

def delete_anomalous_timecodes()
end

def rerender_timecodes()
end

def repurpose_timetags()
end

def queue_for_processing()
end
