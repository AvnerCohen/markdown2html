#!/usr/bin/env ruby
require 'optparse'
require 'rest-client'
require 'json'

options = {}

opt_parser = OptionParser.new do |opt|
	opt.banner = "Usage: r2h.rb [OPTIONS]"
	opt.separator  ""
	opt.separator  "Options"
	opt.on("-i","--output input_filename","Input file nae") do |input_filename|
		options[:input_filename] = input_filename
	end
	opt.on("-o","--output output_filename","Output to a file") do |output_filename|
		options[:output_filename] = output_filename
	end
end


opt_parser.parse!



begin
	contents = File.read(options[:input_filename])
rescue
	puts "**FAIURE**\nCouldn't find file '#{options[:input_filename]}'. Pray to your gods."
	exit
end


def to_html(file_content)
	begin
		RestClient.post 'https://api.github.com/markdown', JSON.dump({"text" => file_content})
	rescue => e
		puts "**FAIURE**\n"
		e.response
		exit
	end

end



response = to_html(contents)

if options[:output_filename]
	File.open(options[:output_filename], 'w') {|f| f.write(response) }
	puts "#{options[:output_filename]} was written, #{response.length} bytes."
else
	puts response
end

puts "\n\nDONE!"






