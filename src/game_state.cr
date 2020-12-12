require "./entity.cr"
require "./player.cr"
require "./input_handler.cr"
require "./map_initialization.cr"

class GameState
  @map : Array(Array(Array(Entity)))
  @player : Player
  getter :map, :running, :game, :player, :entity_list

  def initialize(
    game : Game,
    running : Bool = true,
    player : Player = Player.new
  )
    @game = game
    @running = running
    @player = player
    @entity_list = [player] of Entity
    @map = init_map
    MapInitialization.init_overworld_terrain(self)
    init_entity_locations
  end

  def update(input_event)
    case input_event
    when QuitEvent then @running = false
    when MoveEvent then @player.process_move_input(input_event)
    end
    update_entities_requests
    handle_entity_requests
  end

  def add_entities(entities)
    entities.each do |e|
      @entity_list << e
      place_entity(e)
    end
  end

  private def init_map
    map = Array.new(Game::MAP_TILES_IN_ROW) { Array.new(Game::MAP_TILES_IN_COLUMN) { [] of Entity } }
  end

  private def fetch_map_location(location)
    return @map[location[0]][location[1]]
  end

  private def update_entities_requests
    @entity_list.each { |e| e.update_requests }
  end

  private def handle_entity_requests
    @entity_list.each do |e|
      handle_move_request(e)
    end
  end

  private def handle_move_request(entity)
    move_entity(entity) if can_move?(entity)
  end

  private def can_move?(entity)
    request_in_bounds?(entity) && !blocked?(entity)
  end

  private def move_entity(entity)
    remove_entity(entity)
    entity.move(new_location(entity.location, entity.move_request))
    place_entity(entity)
  end

  private def remove_entity(entity)
    fetch_map_location(entity.location).delete(entity)
  end

  private def place_entity(entity)
    fetch_map_location(entity.location) << entity
  end

  private def new_location(current_location, location_change)
    {current_location[0] + location_change[0], current_location[1] + location_change[1]}
  end

  private def init_entity_locations
    @entity_list.each { |e| @map[e.location[0]][e.location[1]] << e }
  end

  private def blocked?(entity)
    location = new_location(entity.location, entity.move_request)
    return fetch_map_location(location).any? { |e| e.blocking }
  end

  private def request_in_bounds?(entity)
    location = new_location(entity.location, entity.move_request)

    (location[0] >= 0) &&
      (location[0] < @map.size) &&
      (location[1] >= 0) &&
      (location[1] < @map[0].size)
  end
end
