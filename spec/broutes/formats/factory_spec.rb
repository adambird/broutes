require 'spec_helper'

describe Formats::Factory do
  describe "#get" do

    let(:factory) { Formats::Factory.new }

    context "when :gpx_track passed" do
      it "returns GpxTrack" do
        factory.get(:gpx_track).should be_an_instance_of(Formats::GpxTrack)
      end
    end
    context "when 'application/vnd.ant.fit' passed" do
      it "returns FitFile" do
        factory.get('application/vnd.ant.fit').should be_an_instance_of(Formats::FitFile)
      end
    end
    context "when :fit passed" do
      it "returns FitFile" do
        factory.get(:fit).should be_an_instance_of(Formats::FitFile)
      end
    end
    context "when unrecognised" do
      it "returns nil" do
        factory.get(random_string).should be_nil
      end
    end
  end
end
