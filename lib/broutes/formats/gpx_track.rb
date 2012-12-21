require 'nokogiri'

module Broutes::Formats
  class GpxTrack

    def load(file, route)
      doc = Nokogiri::XML(file)
      Broutes.logger.info {"Loaded #{file} into #{doc.to_s.slice(0, 10)}"}

      i = 0
      doc.css('trkpt').each do |node|
        p = route.add_point(node['lat'].to_f, node['lon'].to_f, point_elevation(node), point_time(node))
        i += 1
      end
      Broutes.logger.info {"Loaded #{i} data points"}
    end

    def point_elevation(node)
      if elevation_node = node.at_css('ele')
        elevation_node.inner_text.to_f
      end
    end

    def point_time(node)
      if time_node = node.at_css('time')
        DateTime.parse(time_node.inner_text).to_time
      end
    end
  end
end