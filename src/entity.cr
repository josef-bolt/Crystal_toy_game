require "./color.cr"

class Entity
  getter :sprite_location

  def initialize(sprite_location : Tuple(Int32, Int32, Int32, Int32))
    @sprite_location = SDL::Rect.new *sprite_location
  end
end
