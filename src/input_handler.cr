class InputHandler

  def self.handle_input(input_event)
    case input_event
    when SDL::Event::Quit
      return :quit
    when SDL::Event::Keyboard
      if input_event.mod.lctrl? && input_event.sym.q?
        return :quit
      end
    end
  end
end
