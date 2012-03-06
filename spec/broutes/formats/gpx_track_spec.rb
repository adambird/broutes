require 'spec_helper'

describe Formats::GpxTrack do
  describe "#load" do
    before(:each) do
      @file = open_file('single_lap_gpx_track.xml')
      @target = Formats::GpxTrack.new
      @route = GeoRoute.new
    end
    
    subject { @target.load(@file, @route) }
    
    # assert_equal 34, actual[:total_ascent].round
    # assert_equal 37, actual[:total_descent].round
      
    it "sets the start point lat" do
      subject
      @route.start_point.lat.should eq(52.9552055)
    end
    it "sets the start point lon" do
      subject
      @route.start_point.lon.should eq(-1.1558583)
    end
    it "sets the total distance" do
      subject
      round_to(@route.total_distance, 3).should eq(7.088)
    end
    it "sets the total ascent" do
      subject
      @route.total_ascent.round.should eq(34)
    end
  end
end
