# Broutes

Ruby gem for parsing and extracting common data structures from geo route file formats like GPX.

Used in the [Bunch Rides](http://www.bunch.cc) web app.

[![endorse](https://api.coderwall.com/adambird/endorsecount.png)](https://coderwall.com/adambird)

## Supported Formats

+ [GPX Track](http://en.wikipedia.org/wiki/GPS_eXchange_Format)
+ [Garmin TCX](http://developer.garmin.com/schemas/tcx/v2/)
+ [ANT+ FIT](http://www.thisisant.com/developer/)

## Usage

Add this to your Gemfile

```ruby
  gem 'broutes'
```

Then open a file and pass it in to the from_file method along with the format.

	file = File.open('path to route file')
	route = Broutes.from_file(file, :gpx_track)
	
The format string can either be a symbol, mimetype or filename from which the extension is used.

<table>
  <tr><th>Format</th><th>Symbol</th><th>Mime Type</th><th>File Extension</th></tr>
  <tr><td>GPX Track</td><td>:gpx_track</td><td>application/gpx+xml</td><td>.gpx</td></tr>
  <tr><td>Garmin TCX</td><td>:tcx</td><td>application/vnd.garmin.tcx+xml</td><td>.tcx</td></tr>
  <tr><td>ANT+ FIT</td><td>:fit</td><td>application/vnd.ant.fit</td><td>.fit</td></tr>
</table>

The result route file will have a total distance, ascent and descent info as well as start and end points. Each point will also have it's location, elevation and distance along the route.

If the format used supports laps (TCX formats), the route will also have each lap. Each lap will have it's start time, total time, distance covered, calories burned, the average and maximum speed, and the average and maximum heart rate.

