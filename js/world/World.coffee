# Represents the Streets in view in this
class World
  constructor: ->
    # A promise that will resolve to a list of streets in the area
    @streets = null

  # Returns the closest Street to the specified coords
  # @param lat [Number] The latitude of the street to get
  # @param lon [Number] The longitude of the street to get
  # @return [Promise<Street>] The closest street to this coordinate, or null if nothing is found.
  getStreet: (lat, long) ->

  # Centers the view on the specified Street.
  # This will trigger a load of the data
