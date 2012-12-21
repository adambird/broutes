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
      it "raises ArgumentError nil" do
        expect { factory.get(random_string) }.to raise_error(ArgumentError)
      end
    end
    context "tcx filename" do
      it "returns Tcx" do
        factory.get("2012-12-30-12-23.tcx").should be_an_instance_of(Formats::Tcx)
      end
    end
  end
end
