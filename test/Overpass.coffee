Overpass = require '../js/api/Overpass'
assert = require 'assert'

describe 'Overpass', ->
  describe '#get', ->
    it 'should correctly return data from the Overpass API', ->
      overpass = new Overpass
      overpass.get 55.6061661022442,-4.4779640436172485,55.608235703481284,-4.471451640129089
      .then (data) ->
        assert data.ways
        assert data.nodes
        assert data.nodes[Object.keys(data.nodes)[0]].lat
        assert data.nodes[Object.keys(data.nodes)[0]].lon
        assert data.ways[Object.keys(data.ways)[0]].nodes
