require "../lib/sdl/src/sdl"
require "./input_handler.cr"
require "./game_state.cr"
require "./entity.cr"
require "./color.cr"

module TileEngine
  VERSION = "0.1.0"
  SDL.init(SDL::Init::VIDEO)
  at_exit { SDL.quit }

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  TILE_WIDTH = 16
  TILE_HEIGHT = 16
  MAP_TILES_IN_ROW = WINDOW_WIDTH // TILE_WIDTH
  MAP_TILES_IN_COLUMN = WINDOW_HEIGHT // TILE_HEIGHT

  window = SDL::Window.new("Game!", WINDOW_WIDTH, WINDOW_HEIGHT)
  renderer = SDL::Renderer.new(window)
  renderer.draw_color = Color.black
  renderer.clear
  renderer.present

  gameState = GameState.new(map_width: MAP_TILES_IN_ROW, map_height: MAP_TILES_IN_COLUMN)
  player = Entity.new(color: Color.white)
  entities = [player]
  gameState.map[10][10] << player


  loop do
    input_event = SDL::Event.wait

    event = InputHandler.handle_input(input_event)
    gameState.update(event)
    break if !gameState.running
    # render
  end
end
