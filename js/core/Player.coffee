# Represents the player in the game
class Player
  constructor: ->
    @location = null

  # Teleports the player to a different location
  # @param location [Location] The location to teleport to
  teleport: (location) ->
