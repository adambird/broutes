module Broutes
  require 'logger'
  require_relative 'broutes/geo_route'
  require_relative 'broutes/geo_point'
  require_relative 'broutes/maths'
  require_relative 'broutes/formats'

  RAD_PER_DEG = 0.017453293  #  PI/180
  EARTH_RADIUS = 6371000 #m

  def self.from_file(file, format)
    route = GeoRoute.new
    unless processor = Formats::Factory.new.get(format)
      Broutes.logger.warn {"unable to interpret format #{format}"}
      return
    end
    Broutes.logger.debug {"found processor #{processor}"}
    processor.load(file, route)
    route
  end

  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end