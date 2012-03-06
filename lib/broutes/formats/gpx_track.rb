require 'nokogiri'

module Broutes
  module Formats
    class GpxTrack
      def load(file, route)
        doc = Nokogiri::XML(file)
        doc.css('trkpt').each do |node|
          elevation = nil
          if elevation_node = node.at_css('ele')
            elevation = elevation_node.inner_text.to_f
          end
          route.add_point(node['lat'].to_f, node['lon'].to_f, elevation)
        end
      end
    end
  end
end