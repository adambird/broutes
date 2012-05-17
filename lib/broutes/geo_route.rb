module Broutes
  class GeoRoute

    attr_reader :start_point, :end_point

    def points
      get_points.to_enum
    end

    class << self
      def from_hash(h)
        route = GeoRoute.new
        h['points'].each { |p| route.add_point(p['lat'], p['lon'], p['elevation']) }
        return route
      end
    end

    def to_hash
      {
        'start_point' => start_point.to_hash,
        'end_point' => end_point.to_hash,
        'total_distance' => total_distance,
        'total_time' => total_time,
        'total_ascent' => total_ascent,
        'total_descent' => total_ascent,
        'points' => points.collect { |p| p.to_hash }
      }
    end

    def add_point(lat, lon, elevation=nil, time=nil, distance=nil)
      point = GeoPoint.new(lat, lon, elevation, 0, time)
      if @start_point
        if distance
          @total_distance = distance
        else
          @total_distance += Maths.haversine_distance(@end_point, point)
        end
      else
        @start_point = point
        @total_distance = distance || 0
      end

      point.distance = @total_distance
      process_elevation_delta(@end_point, point)

      @end_point = point
      get_points << point
    end

    def process_elevation_delta(last_point, new_point)
      if last_point && new_point && last_point.elevation && new_point.elevation
        delta = new_point.elevation - last_point.elevation
        @_total_ascent = self.total_ascent + (delta > 0 ? delta : 0)
        @_total_descent = self.total_descent - (delta < 0 ? delta : 0)
      end
    end

    def total_ascent
      @_total_ascent ||= 0
    end

    def total_descent
      @_total_descent ||= 0
    end

    # Public : Total time in seconds between the start point and end point
    #
    # Returns Fixnum time in seconds
    def total_time
      @end_point.time - @start_point.time if @end_point.time && @start_point.time
    end

    # Public : Total distance measured between points in whole metres
    #
    # Returns Float distance in m
    def total_distance
      @total_distance.round if @total_distance
    end

    def hilliness
      (total_distance > 0) ? (total_ascent / total_distance) : 0
    end

    private

    def get_points
      @_points ||= []
    end
  end
end