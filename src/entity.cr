require "./color.cr"

class Entity
  getter :sprite_location

  def initialize(sprite_location : SDL::Rect)
    @sprite_location = sprite_location
  end
end
