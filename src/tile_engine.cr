require "../lib/sdl/src/sdl"
require "../lib/sdl/src/image"
require "./input_handler.cr"
require "./game_state.cr"
require "./entity.cr"
require "./game.cr"
require "./sprite_locations.cr"

module TileEngine
  VERSION = "0.1.0"

  game = Game.new

  img = SDL::IMG.load(File.join("resources", "sprites", "sprites.png"))
  sprite = SDL::Texture.from(img, game.renderer)
  player = Player.new(sprite: sprite, sprite_rect_location: SpriteLocations::PLAYER_SPRITE, location: {10, 10})
  gameState = GameState.new(
    map_width: game.map_width,
    map_height: game.map_height,
    player: player,
  )

  loop do
    event = InputHandler.handle_input(SDL::Event.wait)
    gameState.update(event)
    break if !gameState.running
    gameState.render(game.renderer)
  end
end
