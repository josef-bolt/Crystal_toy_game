require "./color.cr"

abstract class Entity
  getter :move_request, :blocking
  property :location
  def initialize(
    sprite : SDL::Texture,
    sprite_rect_location : Tuple(Int32, Int32, Int32, Int32),
    location : Tuple(Int32, Int32),
    blocking : Bool = false
  )
    @sprite = sprite
    @sprite_location = SDL::Rect.new *sprite_rect_location
    @location = location
    @width = 16
    @height = 16
    @move_request = {0, 0}
    @blocking = blocking
  end

  def render(renderer)
    renderer.copy(@sprite, @sprite_location, SDL::Rect.new *location_in_window)
  end

  private def location_in_window
    {
      Game::TILE_WIDTH*@location[0] + Game::TILE_WIDTH*Game::LEFT_PANEL_TILE_WIDTH,
      Game::TILE_HEIGHT*@location[1],
      Game::TILE_WIDTH,
      Game::TILE_HEIGHT
    }
  end

  abstract def update_requests
  abstract def move(location)
end
