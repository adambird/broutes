require 'rake'
require_relative 'lib/broutes'

task :parse, :input_file, :format do |t, args|
  Broutes.logger.level = Logger::ERROR
  puts args
  file = File.open(args[:input_file])
  route = Broutes.from_file(file, args[:format].to_sym)
  file.close
  puts route.to_hash
end
