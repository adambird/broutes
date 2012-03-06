require 'spec_helper'

describe GeoRoute do
  describe "#add_point" do
    before(:each) do
      @route = GeoRoute.new
      @lat = random_lat
      @lon = random_lon
      @elevation = 35.6000000
      @new_point = GeoPoint.new(@lat, @lon, @elevation, 0)
    end
    
    subject { @route.add_point(@lat, @lon, @elevation) }
    
    context "when route is empty" do
      
      it "sets the start point to the new_point" do
        subject
        @route.start_point.should eq(@new_point)
      end
      it "should set the total distance to zero" do
        subject
        @route.total_distance.should eq(0)
      end
      it "should add the start point to the points list" do
        subject
        @route.points.first.should eq(@route.start_point)
      end
    end
    context "when route already has a start point" do
      before(:each) do
        @start_point = GeoPoint.new(random_lat, random_lon, random_elevation, 0)
        @route.add_point(@start_point.lat, @start_point.lon, @start_point.elevation)
      end
      
      it "should not change start_point" do
        subject
        @route.start_point.should eq(@start_point)
      end
      it "should set the total distance to be haversine distance between the start_point and the new point" do
        subject
        @route.total_distance.should eq(Broutes.haversine_distance(@start_point, @new_point))
      end
      it "set the distance of the point to be the haverside_distance between the start_point" do
        subject
        last(@route.points).distance.should eq(Broutes.haversine_distance(@start_point, @new_point))
      end
    end
    
    context "when route already has at least two points" do
      before(:each) do
        @start_point = GeoPoint.new(random_lat, random_lon, random_elevation)
        @next_point = GeoPoint.new(random_lat, random_lon, random_elevation)
        @route.add_point(@start_point.lat, @start_point.lon, @start_point.elevation)
        @route.add_point(@next_point.lat, @next_point.lon, @next_point.elevation)
      end
      it "should set the total distance to haversine distance along all points" do
        subject
        @route.total_distance.should eq(
          Broutes.haversine_distance(@start_point, @next_point) +
          Broutes.haversine_distance(@next_point, @new_point)
          )
      end
      it "set the distance of the point to haversine distance along all points" do
        subject
        last(@route.points).distance.should eq(
          Broutes.haversine_distance(@start_point, @next_point) +
          Broutes.haversine_distance(@next_point, @new_point)
          )
      end
      
    end
  end
end
