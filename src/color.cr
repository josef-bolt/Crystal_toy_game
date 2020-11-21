class Color
  def self.black
    SDL::Color[0, 0, 0, 0]
  end

  def self.white
    SDL::Color[255, 255, 255, 255]
  end
end
