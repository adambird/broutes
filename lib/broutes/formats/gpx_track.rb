require 'nokogiri'

module Broutes
  module Formats
    class GpxTrack
      def load(file, route)
        doc = Nokogiri::XML(file)
        doc.css('trkpt').each do |node|
          route.add_point(node['lat'].to_f, node['lon'].to_f)
        end
      end
    end
  end
end