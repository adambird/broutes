module Broutes
  class Lap
    attr_accessor :start_time, :total_time, :distance, :calories, :average_speed, :maximum_speed, :average_heart_rate, :maximum_heart_rate

    def initialize(args={})
      args.each_pair do |key, value| send("#{key}=", value) if respond_to?("#{key}=") end
    end

    def self.from_hash(h)
      Lap.new(h)
    end

    def ==(other)
      start_time == other.start_time &&
      total_time == other.total_time &&
      distance == other.distance &&
      calories == other.calories &&
      average_speed == other.average_speed &&
      maximum_speed == other.maximum_speed &&
      average_heart_rate == other.average_heart_rate &&
      maximum_heart_rate == other.maximum_heart_rate
    end

    def to_hash
      h = {}
      h['start_time'] = start_time if start_time
      h['total_time'] = total_time if total_time
      h['distance'] = distance if distance
      h['calories'] = calories if calories
      h['average_speed'] = average_speed if average_speed
      h['maximum_speed'] = maximum_speed if maximum_speed
      h['average_heart_rate'] = average_heart_rate if average_heart_rate
      h['maximum_heart_rate'] = maximum_heart_rate if maximum_heart_rate
      h
    end
  end
end
