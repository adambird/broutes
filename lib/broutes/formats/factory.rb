module Broutes
  module Formats
    class Factory
      def get!(format)
        case 
        when :gpx_track
          GpxTrack.new
        else
          raise StandardError.new("#{format} not recognised")
        end
      end
    end
  end
end