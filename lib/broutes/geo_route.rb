module Broutes
  class GeoRoute
    
    attr_reader :start_point, :end_point, :total_distance, :total_ascent, :total_descent
    
    def points
      get_points.to_enum
    end
    
    def add_point(lat, lon, elevation=nil)
      point = GeoPoint.new(lat, lon, elevation, 0)
      if @start_point
        @total_distance += Broutes.haversine_distance(@end_point, point)
        point.distance = @total_distance
      else
        @start_point = point
        @total_distance = 0
      end
      @end_point = point
      get_points << point
    end

    
    private
    
    def get_points
      @_points ||= []
    end
  end
end