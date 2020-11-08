require "../lib/sdl/src/sdl"

module TileEngine
  VERSION = "0.1.0"
  SDL.init(SDL::Init::VIDEO)
  at_exit { SDL.quit }

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  TILE_WIDTH = 16
  TILE_HEIGHT = 16
  MAP_TILES_IN_ROW = WINDOW_WIDTH / TILE_WIDTH
  MAP_TILES_IN_COLUMN = WINDOW_HEIGHT / TILE_HEIGHT

  window = SDL::Window.new("Game!", WINDOW_WIDTH, WINDOW_HEIGHT)
  renderer = SDL::Renderer.new(window)

  loop do
    event = SDL::Event.wait

    case event
    when SDL::Event::Quit
      break
    when SDL::Event::Keyboard
      if event.mod.lctrl? && event.sym.q?
        break
      end
    end
  end
end
