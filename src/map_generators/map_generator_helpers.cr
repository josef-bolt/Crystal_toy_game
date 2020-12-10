require "./map_generator_strategy.cr"
require "./voronoi_overworld_generator.cr"

module MapGeneratorHelpers
  def MapGeneratorHelpers.generate(strategy, width, height)
    case strategy
    when MapGeneratorStrategy::VoronoiOverworld
      VoronoiOverworldGenerator.new(width, height).generate
    else
      raise "Map generator strategy not implemented"
    end
  end
end
