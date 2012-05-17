# Public : provides factory method for loading appropriate route file parser
module Broutes::Formats
  class Factory
    # Public : factory method
    #
    # format   - Symbol describing the format [:gpx_track, :tcx, :fit]
    #
    # Returns a route file parser
    def get(format)
      case format
      when :gpx_track
        GpxTrack.new
      when :tcx
        Tcx.new
      when :fit
        Fit.new
      end
    end
  end
end