require "./color.cr"

class Entity
  getter :color

  def initialize(color : SDL::Color = Color.black)
    @color = color
  end
end
