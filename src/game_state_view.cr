require "./game_state.cr"
require "./game.cr"

class GameStateView
  @view_bounds : NamedTuple(x_min: Int32, x_max: Int32, y_min: Int32, y_max: Int32)

  def initialize(game : Game, game_state : GameState)
    @game = game
    @game_state = game_state
    @view_bounds = init_view_bounds
  end

  def update
    update_view_bounds if !in_view?(focal_location)
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

  private def in_view?(location)
    location[0] >= @view_bounds[:x_min] &&
      location[0] < @view_bounds[:x_max] &&
      location[1] >= @view_bounds[:y_min] &&
      location[1] < @view_bounds[:y_max]
  end

  private def screen_pos(entity)
    {
      (entity.location[0] - (@view_bounds[:x_min]) + Game::LEFT_PANEL_TILE_WIDTH) * Game::TILE_WIDTH,
      (entity.location[1] - @view_bounds[:y_min]) * Game::TILE_HEIGHT,
      Game::TILE_WIDTH,
      Game::TILE_HEIGHT
    }
  end

  private def init_view_bounds
    x_min = Math.max(0, focal_location[0] - (Game::WINDOW_TILE_WIDTH // 2))
    y_min = Math.max(0, focal_location[1] - (Game::WINDOW_TILE_HEIGHT // 2))
    {
      x_min: x_min,
      x_max: Math.min(@game_state.map.size, x_min + Game::WINDOW_TILE_WIDTH),
      y_min: y_min,
      y_max: Math.min(@game_state.map.first.size, y_min + Game::WINDOW_TILE_HEIGHT)
    }
  end

  private def update_view_bounds
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
