module Broutes
  class GeoPoint
    attr_accessor :lat, :lon, :elevation, :distance, :time

    def initialize(lat, lon, elevation=nil, distance=nil, time=nil)
      @lat, @lon, @elevation, @distance, @time = lat, lon, elevation, distance, time
    end

    class << self
      def from_hash(h)
        GeoPoint.new(h['lat'], h['lon'], h['elevation'], h['distance'], h['time'])
      end
    end

    def ==(other)
      lat == other.lat &&
      lon == other.lon &&
      elevation == other.elevation &&
      distance == other.distance &&
      time == other.time
    end

    def to_hash
      h = {'lat' => lat, 'lon' => lon}
      h['elevation'] = elevation if elevation
      h['distance'] = distance if distance
      h['time'] = time if time
      h
    end
  end
end