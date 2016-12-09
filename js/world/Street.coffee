# Describes a single point that makes up a street
class Street
  # @param lat [Number] The latitude of this street
  # @param lon [Number] The longitude of this street
  # @param connected [Array<Street>] A list of streets connected to this one
  constructor: (@lat, @lon, @connected) ->
