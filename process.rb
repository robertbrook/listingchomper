require 'yaml'

listingfile = File.new("listing.txt")
listinglines = listingfile.readlines

lines_to_ignore = listinglines[0..3]
