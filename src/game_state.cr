require "./entity.cr"

class GameState
  @map : Array(Array(Array(Entity)))
  getter :map
  getter :running

  def initialize(
    running : Bool = true,
    map_width : Int = 0,
    map_height : Int = 0
  )
    @running = running
    @map = Array.new(map_width) { Array.new(map_height) { [] of Entity } }
  end

  def update(input_event)
    @running = false if input_event == :quit
  end
end
