require 'spec_helper'

describe Formats::Tcx do
  describe "#load" do
    before(:all) do
      @file = open_file('single_lap.tcx')
      @target = Formats::Tcx.new
      @route = GeoRoute.new

      @target.load(@file, @route)
    end

    it "sets the start point lat" do
      @route.start_point.lat.should eq(52.94124)
    end
    it "sets the start point lon" do
      @route.start_point.lon.should eq(-1.26039)
    end
    it "sets the total distance" do
      round_to(@route.total_distance, 3).should eq(76.037)
    end
    it "sets the total ascent" do
      @route.total_ascent.round.should eq(1203)
    end
    it "sets the total descent" do
      @route.total_descent.round.should eq(1204)
    end
    it "sets the total time" do
      @route.total_time.round.should eq(10631)
    end
  end
end