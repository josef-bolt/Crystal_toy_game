require "../lib/sdl/src/sdl"
require "../lib/sdl/src/image"
require "./input_handler.cr"
require "./game_state.cr"
require "./entity.cr"
require "./game.cr"
require "./sprite_locations.cr"
require "./room_builder.cr"
require "./game_state_view.cr"

module TileEngine
  VERSION = "0.1.0"

  game = Game.new

  player = Player.new(sprite: game.sprite_texture, sprite_rect_location: SpriteLocations::PLAYER, location: {10, 10})
  game_state = GameState.new(game: game, player: player)
  game_state_view = GameStateView.new(game: game, game_state: game_state)
  # RoomBuilder.make_room(gameState, 10, 10, 5, 5)

  loop do
    event = InputHandler.handle_input(SDL::Event.wait)
    game_state.update(event)
    break if !game_state.running
    game_state_view.update
  end
end
