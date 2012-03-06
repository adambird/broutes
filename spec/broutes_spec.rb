require 'spec_helper'

describe Broutes do
  describe ".haversine_distance" do
    before(:each) do
      @p1 = GeoPoint.new(39.06546, -104.88544)
      @p2 = GeoPoint.new(39.06546, -104.80)
    end
    
    subject { Broutes.haversine_distance( @p1, @p2 ) }

    it "equals 7.376 to 3dp" do
      round_to(subject, 3).should eq(7.376)
    end
  end
end
