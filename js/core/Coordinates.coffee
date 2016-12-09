# Represents a latitude and longitude
class Coordinates
  # @param lat [Number] The latitude
  # @param lon [Number] The longitude
  constructor: (@lat, @lon) ->

  # Calculate the distance between two coordinates
  # @param to [Coordinates] The coordinate to calculate to
  # @option unit [String] The unit to calculate in. m for miles, k for kilometers
  # @return [Number] The distance is the su
  distance: (to, unit = "m") ->
    if !(to instanceof Coordinates)
      throw new TypeError "You need to supply a Coordinate class, not a #{typeof to}!"
      return null

    radlat1 = Math.PI * @lat/180
    radlat2 = Math.PI * to.lat/180
    theta = @lon-to.lon
    radtheta = Math.PI * theta/180
    dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
    dist = Math.acos(dist)
    dist = dist * 180 / Math.PI
    dist = dist * 60 * 1.1515
    if unit is "k"
      dist = dist * 1.609344

    return dist

module.exports = Coordinates
