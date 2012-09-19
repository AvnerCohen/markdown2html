#!/usr/bin/env ruby
require 'optparse'

options = {}
#http://developer.github.com/v3/markdown/
opt_parser = OptionParser.new do |opt|
	opt.banner = "Usage: r2h FILENAME [OPTIONS]"
	opt.separator  ""
	opt.separator  "Options"

	opt.on("-o","--output FILENAME","Output to a file") do |filename|
		options[:filename] = filename
	end
end


opt_parser.parse!
begin
	contents = File.read(options[:filename])
rescue
	puts "Couldn't find file <#{options[:filename]}>. Pray to your gods."
end
puts contents