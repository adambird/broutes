require 'rake'
require 'rspec'
require "#{Rake.application.original_dir}/lib/broutes"

include Broutes
Broutes.logger.level = Logger::FATAL

def random_lat
  rand + rand(180)
end

def random_lon
  rand
end

def random_integer
  rand(100000).to_i
end

def random_elevation
  round_to(rand + rand(999), 3)
end

def random_distance
  round_to(rand + rand(999), 3)
end

def random_string
  (0...24).map{ ('a'..'z').to_a[rand(26)] }.join
end

def round_to(number, decimal_places)
  if number
    if decimal_places > 0
      ((number * 10**decimal_places).round.to_f / 10**decimal_places)
    else
      number.round
    end
  end
end

def last(enum)
  enum.collect{|item| item}.reverse.first
end

def open_file(name)
  File.open("#{Rake.application.original_dir}/spec/support/#{name}")
end