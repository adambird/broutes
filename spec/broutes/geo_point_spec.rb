require 'spec_helper'

describe GeoPoint do
  describe "#to_hash" do
    before(:each) do
      @point = GeoPoint.new(random_lat, random_lon)
    end
    
    subject { @point.to_hash }
    
    it "contains lat" do
      subject['lat'].should eq(@point.lat)
    end
    it "contains lon" do
      subject['lon'].should eq(@point.lon)
    end
    
    context "when only lat lon set" do
      it "should not contain distance" do
        subject.keys.should_not include('distance')
      end
      it "should not contain elevation" do
        subject.keys.should_not include('elevation')
      end
    end
    context "when elevation set" do
      before(:each) do
        @point.elevation = random_elevation
      end
      it "should contain elevation" do
        subject['elevation'].should eq(@point.elevation)
      end
    end
    context "when distance set" do
      before(:each) do
        @point.distance = random_distance
      end
      it "should contain distance" do
        subject['distance'].should eq(@point.distance)
      end
    end
  end
end
