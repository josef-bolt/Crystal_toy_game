require "../lib/sdl/src/sdl"
require "../lib/sdl/src/image"
require "./input_handler.cr"
require "./game_state.cr"
require "./entity.cr"
require "./game.cr"
require "./sprite_locations.cr"
require "./room_builder.cr"

module TileEngine
  VERSION = "0.1.0"

  game = Game.new

  player = Player.new(sprite: game.sprite_texture, sprite_rect_location: SpriteLocations::PLAYER, location: {10, 10})
  gameState = GameState.new(game: game,map_width: game.map_width, map_height: game.map_height, player: player)
  RoomBuilder.make_room(gameState, 10, 10, 5, 5)

  loop do
    event = InputHandler.handle_input(SDL::Event.wait)
    gameState.update(event)
    break if !gameState.running
    gameState.render(game.renderer)
  end
end
