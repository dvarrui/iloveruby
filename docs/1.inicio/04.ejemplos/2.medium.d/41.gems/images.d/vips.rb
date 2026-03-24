#!/usr/bin/env ruby

require "vips"

# Find normalised histogram of reference image
ref = Vips::Image.new_from_file ARGV[0], access: :sequential 
ref_hist = ref.hist_find.hist_norm

ARGV[1..-1].each do |filename|
    # Find sample hist
    sample = Vips::Image.new_from_file filename, access: :sequential 
    sample_hist = sample.hist_find.hist_norm

    # Calculate sum of squares of differences; 
    # if it's over a threshold, print the filename
    diff_hist = (ref_hist - sample_hist) ** 2
    diff = diff_hist.avg * diff_hist.width * diff_hist.height

    puts "#{filename}\t#{diff}"
end

