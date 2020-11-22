require "../lib/sdl/src/sdl"
require "../lib/sdl/src/image"
require "./input_handler.cr"
require "./game_state.cr"
require "./entity.cr"
require "./entity_renderer"

module TileEngine
  VERSION = "0.1.0"

  SDL.init(SDL::Init::VIDEO)
  at_exit { SDL.quit }
  window = SDL::Window.new("Game!", WINDOW_WIDTH, WINDOW_HEIGHT)

  SDL::IMG.init(SDL::IMG::Init::PNG)
  at_exit { SDL::IMG.quit }

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  TILE_WIDTH = 16
  TILE_HEIGHT = 16
  MAP_TILES_IN_ROW = WINDOW_WIDTH // TILE_WIDTH
  MAP_TILES_IN_COLUMN = WINDOW_HEIGHT // TILE_HEIGHT

  renderer = SDL::Renderer.new(window)
  renderer.draw_color = Color.black
  image = SDL::IMG.load(File.join("./resources", "sprites", "sprites.png"))
  sprite = SDL::Texture.from(image, renderer)

  player = Player.new(sprite_location: SDL::Rect[32, 97, 16, 16])
  gameState = GameState.new(
    map_width: MAP_TILES_IN_ROW,
    map_height: MAP_TILES_IN_COLUMN,
    player: player,
    player_location: {10, 10}
  )

  loop do
    input_event = SDL::Event.wait

    event = InputHandler.handle_input(input_event)
    gameState.update(event)
    break if !gameState.running
    EntityRendering.render(gameState.player_location, TILE_WIDTH, TILE_HEIGHT, player, renderer, sprite)
  end
end
