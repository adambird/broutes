# Broutes

Ruby gem for parsing and extracting common data structures from geo route file formats like GPX.

## Supported Formats

+ :gpx_track [GPX Track](http://en.wikipedia.org/wiki/GPS_eXchange_Format)

## Usage

Early stage of development so need to reference this repository for the gem 

	gem 'broutes', :git => 'git@github.com:adambird/broutes.git'
	
Then open a file and pass it in to the from_file method

	file = File.open('path to route file')
	route = Broutes.from_file(file, :gpx_track)
	
The result route file will have a total distance, ascent and descent info as well as start and end points. Each point will also have it's location, elevation and distance along the route.

