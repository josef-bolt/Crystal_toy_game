require "./entity.cr"
require "./player.cr"
require "./input_handler.cr"

class GameState
  @map : Array(Array(Array(Entity)))
  @player : Player
  getter :map, :running, :player_location

  def initialize(
    running : Bool = true,
    map_width : Int = 0,
    map_height : Int = 0,
    player : Player = Player.new,
    player_location = {0, 0}
  )
    @running = running
    @map = Array.new(map_width) { Array.new(map_height) { [] of Entity } }
    @player = player
    @player_location = player_location
    fetch_map_location(@map, @player_location) << @player
  end

  def update(input_event)
    case input_event
    when QuitEvent then @running = false
    when MoveEvent then handle_move_request(@player.move_request(input_event))
    end
  end

  private def fetch_map_location(map, location)
    return map[location[0]][location[1]]
  end

  private def handle_move_request(request)
    new_location = translate_position(@player_location, request)
    remove_player
    place_player(new_location)
  end

  private def translate_position(location_pos, location_change)
    {location_pos[0] + location_change[0], location_pos[1] + location_change[1]}
  end

  private def remove_player
    @map[@player_location[0]][@player_location[1]].delete(@player)
  end

  private def place_player(location)
    fetch_map_location(@map, location )<< @player
    @player_location = location
  end
end
