class EntityManager

  def initialize
    @entities = []
  end

  def add_entity(entity)
    @entities << entity
  end

  def render_entities
    @entities.each { |e| e.render }
  end

end
