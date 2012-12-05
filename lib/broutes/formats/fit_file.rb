require 'fit'

module Broutes::Formats
  class FitFile

    def load(file, route)
      fit_file = Fit::File.read(file)
      Broutes.logger.info {"Started fit processing"}
      i = 0
      fit_file.records.select {|r| r.content && r.content.record_type == :record }.collect { |r| r.content }.each do |pr|
        begin
          route.add_point(convert_position(pr.position_lat), convert_position(pr.position_long), pr.altitude, pr.timestamp, pr.distance)
          i += 1
        rescue => e
          Broutes.logger.debug {"#{e.message} for #{pr}"}
        end
      end
      Broutes.logger.info {"Loaded #{i} data points"}
    end

    def convert_position(value)
      (8.381903171539307e-08 * value).round(5)
    end
  end
end