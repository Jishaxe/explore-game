# Overpass returns XML, so we will turn it into a JSON object
parseString = require('xml2js').parseString
request = require 'request'

# Provides access to the Overpass API
class Overpass
  # Gets nodes and ways within a bounding box. Returns data in the following format:
  ###
  nodes:
    1234:
      tags:
        name: "Banana"
        type: "Hello"

  ways:
    32423:
      tags:
        name: "Potato"
      nodes:
        1234, 3292, 3932
  ###
  # Bounding box clauses always start with the lowest latitude (southernmost) followed by lowest longitude (westernmost), then highest latitude (northernmost) then highest longitude (easternmost).
  get: (s, w, n, e) ->
    query = "way(#{s},#{w},#{n},#{e});(._;>;);out body;"
    # Query that selects all the ways in the box and recurses the nodes in the ways

    return new Promise (resolve, reject) ->
      # Execute the query using overpass-api.de
      request  "http://overpass-api.de/api/interpreter?data=#{query}", (error, response, body) ->
        if error
          reject error
          return

        if response.statusCode isnt 200
          reject new Error "Non-200 status code: #{response.statusCode}"
          return

        # Define the structure we will store our data in
        data = {
          nodes: {},
          ways: {}
        }

        # Convert the returned XML into JSON using xml2js
        parseString body, (err, result) ->
          if err
            reject err
            return

          # Now put all the JSON data into a better format
          for node in result.osm.node
            node_data = node["$"]

            # Put each note lat and long in data.nodes
            data.nodes[node_data.id] = {lat: node_data.lat, lon: node_data.lon, tags: {}}

            # If there are tags in this node, add that too
            if node.tag
              for tag in node.tag
                key = tag['$'].k
                value = tag['$'].v
                data.nodes[node_data.id].tags[key] = value

          # Now process the ways
          for way in result.osm.way
            way_data = way['$']
            data.ways[way_data.id] = {nodes: [], tags: {}, name: null}

            # Bring all the tags in, and set the name if we find a name tag
            if way.tag
              for tag in way.tag
                key = tag['$'].k
                value = tag['$'].v
                data.ways[way_data.id].tags[key] = value
                # Set the name if this is a name tag
                if key is "name" then data.ways[way_data.id].name = value

            # Bring in the nodes for this way
            if way.nd
              for nd in way.nd
                data.ways[way_data.id].nodes.push nd['$'].ref

          # We're done, return the data
          resolve data





module.exports = Overpass
          #for node in data.osm.node


###
rocess = (data) ->
  nodes = {}
  for node in data.node
    node = node['$']
    nodes[node.id] = {
      lat: node.lat,
      lon: node.lon
    }

  for way in data.way
    name = null
    for tag in way.tag
      if tag['$'].k is "name"
        name = tag['$'].v

    if !name then continue

    for node in way.nd
      ref = node['$'].ref
      if nodes[ref]
        nodes[ref].name = name

  roads = []
  for id, node of nodes
    if node.name
      node.id = id
      roads.push(node)
  console.log roads


###
###
nodes:
  1234:
    tags:
      name: "Banana"
      type: "Hello"

ways:
  32423:
    tags:
      name: "Potato"
    nodes:
      1234, 3292, 3932
###
