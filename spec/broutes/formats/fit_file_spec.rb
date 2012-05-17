require 'spec_helper'

describe Formats::FitFile do
  describe "#load" do
    before(:all) do
      @file = open_file('sample.fit')
      @target = Formats::FitFile.new
      @route = GeoRoute.new

      @target.load(@file, @route)
    end

    it "sets the start point lat" do
      @route.start_point.lat.should eq(52.93066)
    end
    it "sets the start point lon" do
      @route.start_point.lon.should eq(-1.22402)
    end
    it "sets the total distance" do
      @route.total_distance.should eq(92068)
    end
    it "sets the total ascent" do
      @route.total_ascent.round.should eq(1176)
    end
    it "sets the total descent" do
      @route.total_descent.round.should eq(1177)
    end
    it "sets the total time" do
      @route.total_time.round.should eq(13675)
    end
  end
end