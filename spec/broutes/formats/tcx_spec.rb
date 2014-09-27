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
      @route.total_distance.should eq(76037)
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
    it "sets the started_at" do
      @route.started_at.to_i.should eq(Time.new(2012, 3, 15, 21, 20, 38).to_i)
    end
    it "sets the ended_at" do
      @route.ended_at.to_i.should eq(Time.new(2012, 3, 16, 00, 17, 49).to_i)
    end
    it "can create hash" do
      @route.to_hash
    end
  end

  describe "#load Garmin Training Centre" do
    before(:all) do
      @file = open_file('garmin_training_center.tcx')
      @target = Formats::Tcx.new
      @route = GeoRoute.new

      @target.load(@file, @route)
    end

    it "sets the start point lat" do
      @route.start_point.lat.should eq(52.930873)
    end
    it "sets the start point lon" do
      @route.start_point.lon.should eq(-1.2236503)
    end
    it "extracts the heart rate" do
      @route.start_point.heart_rate.should eq(77)
    end
    it "extracts the cadence" do
      @route.start_point.cadence.should eq(85)
    end
    it "extracts the speed" do
      @route.start_point.speed.should eq(11.3190002)
    end
    it "extracts the power" do
      @route.start_point.power.should eq(297)
    end
    it "sets the total distance" do
      @route.total_distance.should eq(43892)
    end
    it "sets the total ascent" do
      @route.total_ascent.round.should eq(416)
    end
    it "sets the total descent" do
      @route.total_descent.round.should eq(404)
    end
    it "sets the total time" do
      @route.total_time.round.should eq(6926)
    end
    it "can create hash" do
      @route.to_hash
    end
  end

  describe "file without GPS coordinates" do
    before(:all) do
      @file = open_file('no_gps_coordinates.tcx')
      @target = Formats::Tcx.new
      @route = GeoRoute.new

      @target.load(@file, @route)
    end

    it "sets the total time" do
      @route.total_time.should eq(653)
    end
    it "sets the start point lat" do
      @route.start_point.lat.should be_nil
    end
    it "sets the start point lon" do
      @route.start_point.lon.should be_nil
    end
    it "sets the total distance" do
      @route.total_distance.should eq(0)
    end
    it "sets the total ascent" do
      @route.total_ascent.should eq(2.403564500000016)
    end
    it "sets the total descent" do
      @route.total_descent.should eq(2.8841553000000033)
    end
    it "can create hash" do
      @route.to_hash
    end
  end

  describe "file without points only summary" do
    before(:all) do
      @file = open_file('summary_no_points.tcx')
      @target = Formats::Tcx.new
      @route = GeoRoute.new

      @target.load(@file, @route)
    end

    it "sets the total time" do
      @route.total_time.should eq(2490)
    end
    it "start_point should be nil" do
      @route.start_point.should be_nil
    end
    it "sets the total distance" do
      @route.total_distance.should eq(21146)
    end
    it "sets the total ascent" do
      @route.total_ascent.should eq(0)
    end
    it "sets the total descent" do
      @route.total_descent.should eq(0)
    end
    it "can create hash" do
      @route.to_hash
    end
    it "sets the started_at" do
      @route.started_at.to_i.should eq(DateTime.parse("2012-09-05T18:55:11Z").to_time.to_i)
    end
    it "include the started at in the hash" do
      @route.to_hash['started_at'].should_not be_nil
    end
  end
end
