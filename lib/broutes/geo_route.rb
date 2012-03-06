module Broutes
  class GeoRoute
    
    attr_reader :start_point, :end_point, :total_distance
    
    def points
      get_points.to_enum
    end
    
    def add_point(lat, lon, elevation=nil)
      point = GeoPoint.new(lat, lon, elevation, 0)
      if @start_point
        @total_distance += Maths.haversine_distance(@end_point, point)
        point.distance = @total_distance
      else
        @start_point = point
        @total_distance = 0
      end
      
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
    
    private
    
    def get_points
      @_points ||= []
    end
  end
end