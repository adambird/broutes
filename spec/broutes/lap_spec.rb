require 'spec_helper'

describe Lap do
  let(:start_time) { DateTime.parse("2015-03-13T07:47:11Z") }
  before(:each) do
    @lap = Lap.new(
      start_time: start_time,
      total_time: random_integer,
      distance: random_distance,
      calories: random_integer,
      average_speed: random_integer,
      maximum_speed: random_integer,
      average_heart_rate: random_integer,
      max: random_integer
    )
  end

  describe "#to_hash" do
    subject { @lap.to_hash }

    it "contains start_time" do
      subject['start_time'].should eq(@lap.start_time)
    end
    it "contains total_time" do
      subject['total_time'].should eq(@lap.total_time)
    end
    it "contains distance" do
      subject['distance'].should eq(@lap.distance)
    end
    it "contains calories" do
      subject['calories'].should eq(@lap.calories)
    end
    it "contains average_speed" do
      subject['average_speed'].should eq(@lap.average_speed)
    end
    it "contains maximum_speed" do
      subject['maximum_speed'].should eq(@lap.maximum_speed)
    end
    it "contains average_heart_rate" do
      subject['average_heart_rate'].should eq(@lap.average_heart_rate)
    end
    it "contains maximum_heart_rate" do
      subject['maximum_heart_rate'].should eq(@lap.maximum_heart_rate)
    end
  end

  describe "#==" do
    let(:start_time) { DateTime.parse("2015-03-13T07:47:11Z") }
    let(:same) { @lap }
    let(:different) { Lap.new(start_time: start_time, total_time: random_integer, distance: random_distance, calories: random_integer) }

    it "should return true when objects are the same" do
      (@lap == same).should eq(true)
    end
    it "should return false when objects are not the same" do
      (@lap == different).should eq(false)
    end
  end
end
