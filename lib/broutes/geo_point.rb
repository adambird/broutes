module Broutes
  class GeoPoint
    attr_accessor :lat, :lon, :elevation, :distance, :time, :heart_rate, :power

    def initialize(lat, lon, elevation=nil, distance=nil, time=nil, heart_rate=nil, power=nil)
      @lat, @lon, @elevation, @distance, @time, @heart_rate, @power = lat, lon, elevation, distance, time, heart_rate, power
    end

    class << self
      def from_hash(h)
        GeoPoint.new(h['lat'], h['lon'], h['elevation'], h['distance'], h['time'], h['heart_rate'], h['power'])
      end
    end

    def ==(other)
      lat == other.lat &&
      lon == other.lon &&
      elevation == other.elevation &&
      distance == other.distance &&
      time == other.time &&
      heart_rate == other.heart_rate &&
      power == other.power
    end

    def to_hash
      h = {'lat' => lat, 'lon' => lon}
      h['elevation'] = elevation if elevation
      h['distance'] = distance if distance
      h['time'] = time if time
      h['heart_rate'] = heart_rate if heart_rate
      h['power'] = power if power
      h
    end
  end
end