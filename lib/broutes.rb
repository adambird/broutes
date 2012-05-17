module Broutes
  require 'broutes/geo_route'
  require 'broutes/geo_point'
  require 'broutes/maths'
  require 'broutes/formats'

  RAD_PER_DEG = 0.017453293  #  PI/180
  EARTH_RADIUS = 6371000 #m

  class << self
    def from_file(file, format)
      route = GeoRoute.new
      Formats::Factory.new.get(format).load(file, route)
      route
    end
  end
end