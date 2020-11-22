module GameInitialization

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  TILE_WIDTH = 16
  TILE_HEIGHT = 16
  MAP_TILES_IN_ROW = WINDOW_WIDTH // TILE_WIDTH
  MAP_TILES_IN_COLUMN = WINDOW_HEIGHT // TILE_HEIGHT
  SPRITE_FILEPATH = "./resources/sprites/sprites.png"

  def GameInitialization.start_game
    SDL.init(SDL::Init::VIDEO)
    at_exit { SDL.quit }

    SDL::IMG.init(SDL::IMG::Init::PNG)
    at_exit { SDL::IMG.quit }
  end

  def GameInitialization.window
    SDL::Window.new(TITLE, WINDOW_WIDTH, WINDOW_HEIGHT)
  end

  def GameInitialization.renderer(window)
    SDL::Renderer.new(window)
  end

  def GameInitialization.sprite_texture(window)
    SDL::Texture.from(GameInitialization.sprite_sheet, GameInitialization.renderer(window))
  end

  private def GameInitialization.sprite_sheet
    SDL::IMG.load(File(SPRITE_FILEPATH))
  end
end
