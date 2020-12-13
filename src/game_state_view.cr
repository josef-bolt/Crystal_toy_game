require "./game_state.cr"
require "./game.cr"

class GameStateView
  @current_view_bounds : NamedTuple(x_min: Int32, x_max: Int32, y_min: Int32, y_max: Int32)

  def initialize(game : Game, game_state : GameState)
    @game = game
    @game_state = game_state
    @current_view_bounds = current_view_bounds
  end

  def update
    @current_view_bounds = current_view_bounds if !in_view?(focal_location)
    render
  end

  def render
    renderer = @game.renderer
    renderer.draw_color = SDL::Color[0, 0, 0, 0]
    renderer.clear
    render_interface
    render_entities
    renderer.present
  end

  private def focal_location
    @game_state.player.location
  end

  private def render_entities
    @game_state.entity_list.each do |e|
      e.render(@game.renderer, screen_pos(e)) if in_view?(e.location)
    end
  end

  private def current_view_bounds
    x_max = view_x_max
    y_max = view_y_max
    {
      x_min: x_max - Game::MAP_TILE_WIDTH,
      x_max: x_max,
      y_min: y_max - Game::MAP_TILE_HEIGHT,
      y_max: y_max
    }
  end

  private def view_x_max
    pos = focal_location[0]
    (1..3).map { |i| i*Game::MAP_TILE_WIDTH }.select { |b| b > pos }.first
  end

  private def view_y_max
    pos = focal_location[1]
    (1..3).map { |i| i*Game::MAP_TILE_HEIGHT }.select { |b| b > pos }.first
  end

  private def in_view?(location)
    location[0] >= @current_view_bounds[:x_min] &&
      location[0] < @current_view_bounds[:x_max] &&
      location[1] >= @current_view_bounds[:y_min] &&
      location[1] < @current_view_bounds[:y_max]
  end

  private def screen_pos(entity)
    {
      (entity.location[0] - (@current_view_bounds[:x_min]) + Game::LEFT_PANEL_TILE_WIDTH) * Game::TILE_WIDTH,
      (entity.location[1] - @current_view_bounds[:y_min]) * Game::TILE_HEIGHT,
      Game::TILE_WIDTH,
      Game::TILE_HEIGHT
    }
  end

  private def render_interface
    renderer = @game.renderer
    (0..Game::WINDOW_TILE_HEIGHT).each do |t|
      renderer.copy(
        @game.sprite_texture,
        SDL::Rect.new(*SpriteLocations::PANEL_SEPARATOR),
        SDL::Rect[
        Game::TILE_HEIGHT*Game::LEFT_PANEL_TILE_WIDTH - Game::TILE_WIDTH,
        Game::TILE_WIDTH*t,
        Game::TILE_WIDTH // 2,
        Game::TILE_HEIGHT
      ])
    end
  end
end
