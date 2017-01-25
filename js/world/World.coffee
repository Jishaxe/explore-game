# Represents the Streets in view in this
Overpass = require '../api/Overpass'

class World
  constructor: (@radius = 0.1) ->
    # A promise that will resolve to a list of streets in the area
    @streets = null

  # Returns the closest Street to the specified coords
  # @param lat [Number] The latitude of the street to get
  # @param lon [Number] The longitude of the street to get
  # @return [Promise<Street>] The closest street to this coordinate, or null if nothing is found.
  getStreet: (lat, long) ->
    #  # Bounding box clauses always start with the lowest latitude (southernmost) followed by lowest longitude (westernmost), then highest latitude (northernmost) then highest longitude (easternmost).
    # Build a bounding box for checking the area
    #s, w, n, e
    s = lat - 0.0005
    w = long - 0.0005
    n = lat + 0.0005
    e = long + 0.0005

    return new Promise (resolve, reject) ->
      api = new Overpass
      api.get s, w, n, e
      .then (data) ->
        console.log "Found #{Object.keys(data.nodes).length} nodes and #{Object.keys(data.ways).length} ways"
        console.log data.ways

  # Centers the view on the specified Street.
  # This will trigger a load of the data
  center: (street) ->


module.exports = World
