require "./entity_factory.cr"
require "./obstacle.cr"

module RoomBuilder

  def RoomBuilder.make_room(gameState, x, y, w, h)
    walls = [] of Obstacle
    ((x-1)..(x+w)).each { |idx| walls << EntityFactory.make_wall(gameState.game, {idx, y - 1}) }
    ((x-1)..(x+w)).each { |idx| walls << EntityFactory.make_wall(gameState.game, {idx, y + h}) }
    ((y-1)..(y+h)).each { |idx| walls << EntityFactory.make_wall(gameState.game, {x - 1, idx}) }
    ((x-1)..(x+w)).each { |idx| walls << EntityFactory.make_wall(gameState.game, {x + w, idx}) }
    gameState.add_entities(walls)
  end
end
