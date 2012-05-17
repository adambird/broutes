require 'nokogiri'

module Broutes::Formats
  class Tcx
    def load(file, route)
      doc = Nokogiri::XML(file)
      doc.css('Trackpoint').each do |node|
        location = point_location(node)
        route.add_point(location[0], location[1], point_elevation(node), point_time(node))
      end
    end

    def point_location(node)
      if position_node = node.at_css('Position')
        [ position_node.at_css('LatitudeDegrees').inner_text.to_f, position_node.at_css('LongitudeDegrees').inner_text.to_f ]
      end
    end

    def point_elevation(node)
      if elevation_node = node.at_css('AltitudeMeters')
        elevation_node.inner_text.to_f
      end
    end

    def point_time(node)
      if time_node = node.at_css('Time')
        DateTime.parse(time_node.inner_text).to_time.to_i
      end
    end
  end
end