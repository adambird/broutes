module Broutes
  class GeoPoint
    attr_accessor :lat, :lon, :elevation, :distance
    
    def initialize(lat, lon, elevation=nil, distance=nil)
      @lat, @lon, @elevation, @distance = lat, lon, elevation, distance
    end
    
    def ==(other)
      self.lat == other.lat && self.lon == other.lon && self.elevation == other.elevation && self.distance && other.distance
    end
    
  end
end