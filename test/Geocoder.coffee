assert = require "assert"
Geocoder = require "../js/api/Geocoder"
Promise = require 'promise'

describe "Geocoder", ->
  describe "#search", ->
    it "should return the correct coordinates for a search", ->
      london = new Geocoder "London, UK"
      return london.search()
      .then (result) ->
        assert.equal result.coords.lat, "51.5073219"
        assert.equal result.coords.lon, "-0.1276473"
    it "should return an exception when we search for something that doesn't exist", (done) ->
      nothing = new Geocoder "SDNFUIDNFnscsodinsdond"
      nothing.search()
      .then ->
        done new Error "The request succeeded when it wasn't supposed to!"
      .catch (e) ->
        done()

      return null
