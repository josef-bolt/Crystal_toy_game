require "../lib/sdl/src/sdl"
require "../lib/sdl/src/image"
require "./input_handler.cr"
require "./game_state.cr"
require "./entity.cr"
require "./entity_renderer.cr"
require "./game.cr"
require "./sprite_locations.cr"

module TileEngine
  VERSION = "0.1.0"

  game = Game.new

  player = Player.new(sprite_location: SpriteLocations::PLAYER_SPRITE)
  gameState = GameState.new(
    map_width: game.map_width,
    map_height: game.map_height,
    player: player,
    player_location: {10, 10}
  )

  loop do
    event = InputHandler.handle_input(SDL::Event.wait)
    gameState.update(event)
    break if !gameState.running
    EntityRendering.render(gameState.player_location, game.tile_width, game.tile_height, player, game.renderer, game.sprite_texture)
  end
end
