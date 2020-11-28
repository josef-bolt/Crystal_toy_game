class Game
  getter :renderer, :map_width, :map_height, :tile_width, :tile_height, :sprite_texture
  @map_width : Int32
  @map_height : Int32
  @tile_width : Int32
  @tile_height : Int32

  WINDOW_WIDTH = 640
  WINDOW_HEIGHT = 480
  TILE_WIDTH = 16
  TILE_HEIGHT = 16
  MAP_TILES_IN_ROW = WINDOW_WIDTH // TILE_WIDTH
  MAP_TILES_IN_COLUMN = WINDOW_HEIGHT // TILE_HEIGHT
  TITLE = "Game!"
  IMG = SDL::IMG.load(File.join("resources", "sprites", "sprites.png"))

  def initialize
    SDL.init(SDL::Init::VIDEO)
    at_exit { SDL.quit }

    SDL::IMG.init(SDL::IMG::Init::PNG)
    at_exit { SDL::IMG.quit }

    @window = SDL::Window.new(TITLE, WINDOW_WIDTH, WINDOW_HEIGHT)
    @renderer = SDL::Renderer.new(@window)
    image = SDL::IMG.load(File.join("./resources", "sprites", "sprites.png"))
    @sprite_texture = SDL::Texture.from(image, @renderer)
    @map_width = MAP_TILES_IN_ROW
    @map_height = MAP_TILES_IN_COLUMN
    @tile_width = TILE_WIDTH
    @tile_height = TILE_HEIGHT
  end
end
