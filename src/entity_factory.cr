module EntityFactory
  def EntityFactory.make_wall(game, location)
    Obstacle.new(blocking: true, sprite: game.sprite_texture, sprite_rect_location: SpriteLocations::WALL, location: location)
  end
end

