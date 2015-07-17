module Broutes
  class GeoRoute

    attr_reader :start_point, :end_point, :started_at, :ended_at, :total_time
    attr_writer :total_distance, :started_at
    attr_accessor :total_time

    def points
      get_points.to_enum
    end

    def laps
      get_laps.to_enum
    end

    def initialize(args={})
      args.each_pair do |key, value|
        if key.to_sym == :points
          value.each { |p| add_point(p) }
        elsif key.to_sym == :laps
          value.each { |l| add_lap(l) }
        else
          send("#{key}=", value) if respond_to?("#{key}=")
        end
      end
    end

    def self.from_hash(h)
      route = GeoRoute.new h
    end

    def to_hash
      h = {
        'total_distance' => total_distance,
        'total_time' => total_time,
        'total_ascent' => total_ascent,
        'total_descent' => total_ascent,
        'points' => points.collect { |p| p.to_hash },
        'laps' => laps.collect { |l| l.to_hash }
      }
      h['start_point'] = start_point.to_hash if start_point
      h['end_point'] = end_point.to_hash if end_point
      h['started_at'] = @started_at if @started_at
      h
    end

    def add_point(args)
      point = GeoPoint.new(args)
      if @start_point
        if point.distance
          @total_distance = point.distance
        else
          if distance = Maths.haversine_distance(@end_point, point)
            @total_distance += distance
          end
        end

        @total_time = point.time - @start_point.time if point.time
      else
        @start_point = point
        @total_distance = point.distance || 0
      end

      point.distance = @total_distance
      process_elevation_delta(@end_point, point)

      @end_point = point
      get_points << point
    end

    def add_lap(args)
      get_laps << Lap.new(args)
    end

    def process_elevation_delta(last_point, new_point)
      if last_point && new_point && last_point.elevation && new_point.elevation
        delta = new_point.elevation - last_point.elevation
        @_total_ascent = self.total_ascent + (delta > 0 ? delta : 0)
        @_total_descent = self.total_descent - (delta < 0 ? delta : 0)
      end
    end

    def started_at
      return @started_at if @started_at
      @start_point.time if @start_point
    end

    def ended_at
      @end_point.time if @end_point
    end

    def total_ascent
      @_total_ascent ||= 0
    end

    def total_descent
      @_total_descent ||= 0
    end

    # Public : Total distance measured between points in whole metres
    #
    # Returns Float distance in m
    def total_distance
      @total_distance.round if @total_distance
    end

    # Public : Measure of how hilly the route is. Measured as total ascent (m) / distance (km)
    #
    # Returns Float measure
    def hilliness
      (total_distance > 0) ? (total_ascent * 1000 / total_distance) : 0
    end

    # Public: Get average heart_rate for whole GeoRoute.
    #
    # Examples
    #   @route.average_heart_rate
    #   # => 12
    #
    # Returns Integer average, or 0 if no heart_rate on points.
    def average_heart_rate
      points = @_points
      points.map { |p| p.heart_rate || 0 }.inject { |sum, hr| sum + hr } / points.count
    end

    # Public: Get average power for whole GeoRoute.
    #
    # Examples
    #   @route.average_power
    #   # => 250
    #
    # Returns Float average, or 0 if no power on points.
    def average_power
      points = @_points
      points.map { |p| p.power || 0 }.inject { |sum, p| sum + p } / points.count
    end

    # Public: Get maximum speed for whole GeoRoute.
    #
    # Examples
    #   @route.maximum_speed
    #   # => 5.50
    #
    # Returns Float maximum, or 0.0 if no speed on points.
    def maximum_speed
      points = @_points
      points.map { |p| p.speed }.compact.max || 0.0
    end

    # Public: Get minimum speed for whole GeoRoute.
    #
    # Examples
    #   @route.minimum_speed
    #   # => 1.50
    #
    # Returns Float minimum, or 0.0 if no speed on points.
    def minimum_speed
      points = @_points
      points.map { |p| p.speed }.compact.min || 0.0
    end

    # Public: Get average speed for whole GeoRoute.
    #
    # Examples
    #   @route.average_speed
    #   # => 2.50
    #
    # Returns Float average, or 0.0 if no speed on points.
    def average_speed
      points = @_points
      points.map { |p| p.speed || 0.0 }.inject { |sum, p| sum + p } / points.count
    end

    # Public: Get maximum heart rate for whole GeoRoute.
    #
    # Examples
    #   @route.maximum_heart_rate
    #   # => 180
    #
    # Returns Integer maximum, or 0 if no heart rate on points.
    def maximum_heart_rate
      points = @_points
      points.map { |p| p.heart_rate }.compact.max || 0
    end

    # Public: Get minimum heart rate for whole GeoRoute.
    #
    # Examples
    #   @route.minimum_heart_rate
    #   # => 100
    #
    # Returns Integer minimum, or 0 if no heart rate on points.
    def minimum_heart_rate
      points = @_points
      points.map { |p| p.heart_rate }.compact.min || 0
    end

    # Public: Get maximum elevation for whole GeoRoute.
    #
    # Examples
    #   @route.maximum_elevation
    #   # => 1000
    #
    # Returns Integer maximum, or 0 if no elevation on points.
    def maximum_elevation
      points = @_points
      points.map { |p| p.elevation }.compact.max || 0
    end

    # Public: Get minimum elevation for whole GeoRoute.
    #
    # Examples
    #   @route.minimum_elevation
    #   # => 10
    #
    # Returns Integer minimum, or 0 if no elevation on points.
    def minimum_elevation
      points = @_points
      points.map { |p| p.elevation }.compact.min || 0
    end

    # Public: Get total calories for whole GeoRoute.
    #
    # Examples
    #   @route.total_calories
    #   # => 10
    #
    # Returns Integer calories, or 0 if no calories on laps.
    def total_calories
      laps = @_laps
      laps.map { |l| l.calories || 0 }.inject { |sum, l| sum + l }
    end

    private

    def get_points
      @_points ||= []
    end

    def get_laps
      @_laps ||= []
    end
  end
end
