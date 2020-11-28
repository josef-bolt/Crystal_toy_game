require "./color.cr"

abstract class Entity
  getter :move_request
  property :location
  def initialize(sprite : SDL::Texture,  sprite_rect_location : Tuple(Int32, Int32, Int32, Int32), location : Tuple(Int32, Int32))
    @sprite = sprite
    @sprite_location = SDL::Rect.new *sprite_rect_location
    @location = location
    @width = 16
    @height = 16
    @move_request = {0, 0}
  end

  def render(renderer)
    renderer.copy(@sprite, @sprite_location, SDL::Rect[@location[0]*@width, @location[1]*@height, @width, @height] )
  end

  abstract def update_requests
  abstract def move(location)
end
