World = require '../js/world/World'

describe 'World', ->
  describe '#getStreet', ->
    it 'should correctly locate a street given a lat and long', ->
      world = new World
      world.getStreet(55.6098486, -4.4884013).then (street) ->
        # This should bring up the node 335695906, part of Holehouse Road (30418408)
        assert street.id == 335695906
        assert street.name == "Holehouse Road"
