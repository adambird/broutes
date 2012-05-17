require 'fit'

module Broutes::Formats
  class FitFile

    def load(file, route)
      fit_file = Fit::File.read(file)
      fit_file.records.select {|r| r.content.record_type == :record }.collect { |r| r.content }.each do |pr|
        route.add_point(convert_position(pr.position_lat), convert_position(pr.position_long), pr.altitude, pr.timestamp, pr.distance)
      end
    end

    def convert_position(value)
      (8.381903171539307e-08 * value).round(5)
    end
  end
end