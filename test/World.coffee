World = require '../js/world/World'

describe 'World', ->
  describe '#getStreet', ->
    it 'should correctly locate a street given a lat and long', ->
      world = new World
      street = world.getStreet()
