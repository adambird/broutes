require 'fit'

module Broutes::Formats
  class FitFile

    def load(file, route)
      fit_file = Fit::File.read(file)
      Broutes.logger.info {"Started fit processing"}
      i = 0
      fit_file.records.select {|r| r.content && r.content.record_type == :record }.each do |r|
        begin
          pr = r.content
          data = { time: record_time(r) }
          data[:lat] = convert_position(pr.position_lat) if pr.respond_to?(:position_lat)
          data[:lon] = convert_position(pr.position_long) if pr.respond_to?(:position_long)
          data[:elevation] = pr.altitude if pr.respond_to?(:altitude)
          [:distance, :heart_rate, :power, :speed, :cadence, :temperature].each do |m| 
            data[m] = pr.send(m) if pr.respond_to?(m) 
          end

          route.add_point(data)
          i += 1
        rescue => e
          Broutes.logger.debug {"#{e.message} for #{r}"}
        end
      end
      Broutes.logger.info {"Loaded #{i} data points"}
    end

    def convert_position(value)
      (8.381903171539307e-08 * value).round(5)
    end

    def record_time(record)
      utc_seconds = record.content.timestamp
      utc_seconds += record.header.time_offset if record.header.compressed_timestamp? 
      Time.new(1989, 12, 31, 0, 0, 0, "+00:00") + utc_seconds #seconds since UTC 00:00 Dec 31 1989
    end

  end
end