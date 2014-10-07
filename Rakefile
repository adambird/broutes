require 'rake'
require 'rspec/core/rake_task'
require_relative 'lib/broutes'

task :default => :spec
RSpec::Core::RakeTask.new

task :parse, :input_file, :format do |t, args|
  Broutes.logger.level = Logger::ERROR
  puts args
  file = File.open(args[:input_file])
  route = Broutes.from_file(file, args[:format].to_sym)
  file.close
  puts route.to_hash
end
