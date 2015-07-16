require 'nokogiri'

module Broutes::Formats
  class Tcx
    def load(file, route)
      doc = Nokogiri::XML(file)
      Broutes.logger.info {"Loaded #{file} into #{doc.to_s.slice(0, 10)}"}

      i = 0
      doc.css('Trackpoint').each do |node|
        data = {
          elevation: point_elevation(node),
          time: point_time(node),
          distance: point_distance(node),
          heart_rate: point_heart_rate(node),
          power: point_power(node),
          speed: point_speed(node),
          cadence: point_cadence(node)
        }

        if location = point_location(node)
          data[:lat] = location[0]
          data[:lon] = location[1]
        end

        route.add_point(data)
        i += 1
      end
      Broutes.logger.info {"Loaded #{i} data points"}

      i = 0
      doc.css('Lap').each do |node|
        data = {
          start_time: lap_start_time(node),
          total_time: lap_total_time(node),
          distance: lap_distance(node),
          calories: lap_calories(node),
          average_speed: lap_avg_speed(node),
          maximum_speed: lap_maximum_speed(node),
          average_heart_rate: lap_average_heart_rate(node),
          maximum_heart_rate: lap_maximum_heart_rate(node)
        }

        route.add_lap(data)
        i += 1
      end
      Broutes.logger.info {"Loaded #{i} laps"}

      # Load in summary values if time and distance nil, ie no points
      unless route.total_time
        route.total_time = doc.css('Activities > Activity > Lap > TotalTimeSeconds').reduce(0) { |sum, node|
          sum + node.inner_text.to_i
        }
      end

      unless route.total_distance
        route.total_distance = doc.css('Activities > Activity > Lap > DistanceMeters').reduce(0) { |sum, node|
          sum + node.inner_text.to_i
        }
      end

      unless route.started_at
        route.started_at = DateTime.parse(doc.css('Activities > Activity > Lap').first['StartTime']).to_time
      end
    end

    def point_location(node)
      if position_node = node.at_css('Position')
        [ position_node.at_css('LatitudeDegrees').inner_text.to_f, position_node.at_css('LongitudeDegrees').inner_text.to_f ]
      end
    end

    def point_distance(node)
      if distance_node = node.at_css('DistanceMeters')
        distance_node.inner_text.to_f
      end
    end

    def point_elevation(node)
      if elevation_node = node.at_css('AltitudeMeters')
        elevation_node.inner_text.to_f
      end
    end

    def point_time(node)
      if time_node = node.at_css('Time')
        DateTime.parse(time_node.inner_text).to_time
      end
    end

    def point_heart_rate(node)
      if hr_node = node.at_css('HeartRateBpm')
        hr_node.inner_text.to_i
      end
    end

    def point_cadence(node)
      if cadence_node = node.at_css('Cadence')
        cadence_node.inner_text.to_i
      end
    end

    def point_power(node)
      if power_node = node.at_xpath('.//tpx:Watts', 'tpx' => 'http://www.garmin.com/xmlschemas/ActivityExtension/v2')
        power_node.inner_text.to_i
      end
    end

    def point_speed(node)
      if speed_node = node.at_xpath('.//tpx:Speed', 'tpx' => 'http://www.garmin.com/xmlschemas/ActivityExtension/v2')
        speed_node.inner_text.to_f
      end
    end

    def lap_start_time(node)
      DateTime.parse(node.attribute('StartTime').value) unless node.attribute('StartTime').nil?
    end

    def lap_total_time(node)
      if total_time_node = node.at_css('TotalTimeSeconds')
        total_time_node.inner_text.to_i
      end
    end

    def lap_distance(node)
      if distance_node = node.at_css('DistanceMeters')
        distance_node.inner_text.to_f
      end
    end

    def lap_maximum_speed(node)
      if maximum_speed_node = node.at_css('MaximumSpeed')
        maximum_speed_node.inner_text.to_f
      end
    end

    def lap_calories(node)
      if calories_node = node.at_css('Calories')
        calories_node.inner_text.to_i
      end
    end

    def lap_average_heart_rate(node)
      if average_heart_rate_node = node.at_css('AverageHeartRateBpm')
        average_heart_rate_node.inner_text.to_i
      end
    end

    def lap_maximum_heart_rate(node)
      if maximum_heart_rate_node = node.at_css('MaximumHeartRateBpm')
        maximum_heart_rate_node.inner_text.to_i
      end
    end

    def lap_avg_speed(node)
      if avg_speed_node = node.at_xpath('.//lx:AvgSpeed', 'lx' => 'http://www.garmin.com/xmlschemas/ActivityExtension/v2')
        avg_speed_node.inner_text.to_f
      end
    end
  end
end
