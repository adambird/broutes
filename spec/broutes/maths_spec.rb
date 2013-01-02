require 'spec_helper'

describe Maths do
  describe ".haversine_distance" do
    before(:each) do
      @p1 = GeoPoint.new(lat: 39.06546, lon: -104.88544)
      @p2 = GeoPoint.new(lat: 39.06546, lon: -104.80)
    end

    subject { Maths.haversine_distance( @p1, @p2 ) }

    it "equals 7376.435 to 3dp" do
      round_to(subject, 3).should eq(7376.435)
    end
  end
end
