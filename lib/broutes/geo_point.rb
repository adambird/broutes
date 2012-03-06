module Broutes
  class GeoPoint
    attr_accessor :lat, :lon, :elevation, :distance
    
    def initialize(lat, lon, elevation=nil, distance=nil)
      @lat, @lon, @elevation, @distance = lat, lon, elevation, distance
    end
    
    class << self
      def from_hash(h)
        GeoPoint.new(h['lat'], h['lon'], h['elevation'], h['distance'])
      end
    end
    
    def ==(other)
      self.lat == other.lat && self.lon == other.lon && self.elevation == other.elevation && self.distance && other.distance
    end
    
    def to_hash
      h = {'lat' => self.lat, 'lon' => self.lon}
      h['elevation'] = self.elevation if self.elevation
      h['distance'] = self.distance if self.distance
      h
    end
  end
end