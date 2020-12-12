class VoronoiOverworldGenerator
  @map : Array(Array(Int32))
  @centre_points : Array(Tuple(Int32, Int32))

  NUMBER_OF_CENTRE_POINTS = 100

  def initialize(width : Int32, height : Int32)
    @width = width
    @height = height
    @map = Array.new(width) { Array.new(height) { 0 } }
    @centre_states = [1, 2, 2]
    @centre_points = [] of Tuple(Int32, Int32)
    init_centre_points
  end

  def generate
    (0...@width).each do |x|
      (0...@height).each do |y|
        @map[x][y] = closest_centre_state(x, y)
      end
    end
    @map
  end

  private def init_centre_points
    (0...NUMBER_OF_CENTRE_POINTS).each do
      x = Random.rand(@width)
      y = Random.rand(@height)
      state = @centre_states.sample(1).first

      @map[x][y] = state
      @centre_points << {x, y}
    end
  end

  private def closest_centre_state(x, y)
    closest_centre = closest_centre(x, y)
    @map[closest_centre[0]][closest_centre[1]]
  end

  private def closest_centre(x, y)
    closest_centre = @centre_points.first
    least_distance = distance(x, y, closest_centre)
    @centre_points[1..].each do |pos|
      distance = distance(x, y, pos)
      if distance < least_distance
        least_distance = distance
        closest_centre = pos
      end
    end
    closest_centre
  end

  private def distance(x, y, pos)
    Math.sqrt((x - pos[0])**2 + (y - pos[1])**2)
  end
end
