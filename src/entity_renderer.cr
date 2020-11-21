module EntityRendering
# TODO: Make this not gross
  def EntityRendering.render(location, w, h, entity, renderer)
    rect = SDL::Rect[w*location[0], h*location[1], w, h]
    draw_color = renderer.draw_color
    renderer.draw_color = entity.color
    renderer.fill_rect(rect)
    renderer.draw_color = draw_color
  end
end
