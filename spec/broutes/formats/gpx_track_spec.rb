require 'spec_helper'

describe Formats::GpxTrack do
  describe "#load" do
    before(:all) do
      @file = open_file('single_lap_gpx_track.gpx')
      @target = Formats::GpxTrack.new
      @route = GeoRoute.new

      @target.load(@file, @route)
    end

    it "sets the start point lat" do
      @route.start_point.lat.should eq(52.9552055)
    end
    it "sets the start point lon" do
      @route.start_point.lon.should eq(-1.1558583)
    end
    it "sets the total distance" do
      @route.total_distance.should eq(7088)
    end
    it "sets the total ascent" do
      @route.total_ascent.round.should eq(34)
    end
    it "sets the total descent" do
      @route.total_descent.round.should eq(37)
    end
    it "sets the total time" do
      @route.total_time.round.should eq(1231)
    end
    it "sets the started_at" do
      @route.started_at.to_i.should eq(Time.new(2011, 5, 19, 17, 57, 21).to_i)
    end
    it "sets the ended_at" do
      @route.ended_at.to_i.should eq(Time.new(2011, 5, 19, 18, 17, 52).to_i)
    end

    context "when file doesn't have elevation" do
      before(:all) do
        @file = open_file('single_lap_gpx_track_no_elevation.gpx')
        @target = Formats::GpxTrack.new
        @route = GeoRoute.new

        @target.load(@file, @route)
      end

      it "sets the start point lat" do
        @route.start_point.lat.should eq(52.926467718938)
      end
      it "sets the start point lon" do
        @route.start_point.lon.should eq(-1.216092432889)
      end
      it "sets the total distance" do
        @route.total_distance.should eq(123955)
      end
      it "sets the total ascent" do
        @route.total_ascent.should eq(0)
      end
      it "sets the total descent" do
        @route.total_descent.should eq(0)
      end
    end
  end
end
