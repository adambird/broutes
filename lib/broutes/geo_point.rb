module Broutes
  class GeoPoint
    attr_accessor :lat, :lon, :elevation, :distance, :time, :heart_rate, :power, :speed, :cadence, :temperature

    def initialize(args={})
      args.each_pair do |key, value| send("#{key}=", value) if respond_to?("#{key}=") end
    end

    def self.from_hash(h)
      GeoPoint.new(h)
    end

    def ==(other)
      lat == other.lat &&
      lon == other.lon &&
      elevation == other.elevation &&
      distance == other.distance &&
      time == other.time &&
      heart_rate == other.heart_rate &&
      power == other.power &&
      speed == other.speed &&
      cadence == other.cadence &&
      temperature == other.temperature
    end

    def to_hash
      h = {'lat' => lat, 'lon' => lon}
      h['elevation'] = elevation if elevation
      h['distance'] = distance if distance
      h['time'] = time if time
      h['heart_rate'] = heart_rate if heart_rate
      h['power'] = power if power
      h['speed'] = speed if speed
      h['cadence'] = cadence if cadence
      h['temperature'] = temperature if temperature
      h
    end
  end
end