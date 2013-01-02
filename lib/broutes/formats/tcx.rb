require 'nokogiri'

module Broutes::Formats
  class Tcx
    def load(file, route)
      doc = Nokogiri::XML(file)
      Broutes.logger.info {"Loaded #{file} into #{doc.to_s.slice(0, 10)}"}

      i = 0
      doc.css('Trackpoint').each do |node|
        if location = point_location(node)
          p = route.add_point(location[0], location[1], point_elevation(node), point_time(node), point_distance(node), point_heart_rate(node))
          i += 1
        end
      end
      Broutes.logger.info {"Loaded #{i} data points"}
    end

    def point_location(node)
      if position_node = node.at_css('Position')
        [ position_node.at_css('LatitudeDegrees').inner_text.to_f, position_node.at_css('LongitudeDegrees').inner_text.to_f ]
      end
    end

    def point_distance(node)
      if distance_node = node.at_css('DistanceMeters')
        distance_node.inner_text.to_f
      end
    end

    def point_elevation(node)
      if elevation_node = node.at_css('AltitudeMeters')
        elevation_node.inner_text.to_f
      end
    end

    def point_time(node)
      if time_node = node.at_css('Time')
        DateTime.parse(time_node.inner_text).to_time
      end
    end

    def point_heart_rate(node)
      if hr_node = node.at_css('HeartRateBpm')
        hr_node.inner_text.to_i
      end
    end
  end
end