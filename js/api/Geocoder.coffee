config = require 'config'
request = require 'request'
Promise = require 'promise'
Coordinates = require '../core/Coordinates'

# Handles translating a human-readable place name into a set of coordinates.
# Data retrieved from the pickpoint.io API - © OpenStreetMap contributors
# @example How to resolve a place name to coordinates
#   london = new Geocoder "London, UK"
#   london.search()
#   .then (result) ->
#     console.log "Longitude: #{result.lon}"
#     console.log "Latitude: #{result.lat}"
#   .catch (error) ->
#     console.error "Couldn't get coords: #{error}"
class Geocoder
  # Creates a new Geocoder instance for the specified search term
  # @param [String] search_text The text to search for
  constructor: (@search_text) ->

  # Carry out a search for the specified search text
  # @return [Promise] A promise with the eventual results of the search, or an error
  search: ->
    text = @search_text
    return new Promise (resolve, reject) ->
      request {
        url: "https://api.pickpoint.io/v1/forward?key=#{config.get 'PickPointIO.api_key'}&q=#{text}"
        json: true},
      (error, response, body) ->
        if error
          reject error
          return

        if response.statusCode isnt 200
          reject new Error "Non-200 status code: #{response.statusCode}"
          return

        if body.length is 0
          reject new Error "No results for search #{text}"
          return

        body[0].coords = new Coordinates body[0].lat, body[0].lon
        resolve body[0] # Return the first result

module.exports = Geocoder
