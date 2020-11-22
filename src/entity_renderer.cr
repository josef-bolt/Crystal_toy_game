module EntityRendering
  def EntityRendering.render(location, w, h, entity, renderer, sprite)
    renderer.draw_color = SDL::Color[0, 0, 0, 0]
    renderer.clear
    renderer.copy(sprite, entity.sprite_location, SDL::Rect[location[0]*w, location[1]*h, 16, 16])
    renderer.present
  end
end
