Coordinates = require '../js/core/Coordinates'
assert = require 'assert'

describe 'Coordinates', ->
  describe '#distance', ->
    it 'should correctly calculate the distance between two coordinates', ->
      coord1 = new Coordinates 52.820402, -0.901448
      coord2 = new Coordinates 52.736483, -1.149285

      # Compare for floating point inaccuracies
      # Fuck those things
      assert coord1.distance(coord2, 'm') < 11.95 and coord1.distance(coord2, 'm') > 11.85
      assert coord1.distance(coord2, 'k') < 19.20 and coord1.distance(coord2, 'k') > 19.10
