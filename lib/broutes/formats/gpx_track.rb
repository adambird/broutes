require 'nokogiri'

module Broutes::Formats
  class GpxTrack
    def load(file, route)
      doc = Nokogiri::XML(file)
      doc.css('trkpt').each do |node|
        route.add_point(node['lat'].to_f, node['lon'].to_f, point_elevation(node), point_time(node))
      end
    end

    def point_elevation(node)
      if elevation_node = node.at_css('ele')
        elevation_node.inner_text.to_f
      end
    end

    def point_time(node)
      if time_node = node.at_css('time')
        DateTime.parse(time_node.inner_text).to_time.to_i
      end
    end
  end
end