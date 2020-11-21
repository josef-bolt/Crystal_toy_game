class QuitEvent
end

enum MoveEvent
  Up
  Right
  Down
  Left
end

class InputHandler
  def self.handle_input(input_event)
    case input_event
    when SDL::Event::Quit
      return QuitEvent.new
    when SDL::Event::Keyboard
      handle_keyboard_input(input_event)
    end
  end

  def self.handle_keyboard_input(input_event)
    sym = input_event.sym.to_s

    case
    when quit_symbols.includes?(sym) then return QuitEvent.new
    when move_symbol_mapping.keys.includes?(sym) then return move_symbol_mapping[sym]
    end
  end

  def self.quit_symbols
    Set.new ["ESCAPE"]
  end

  def self.move_symbol_mapping
    {
      "H" => MoveEvent::Left,
      "J" => MoveEvent::Down,
      "K" => MoveEvent::Up,
      "L" => MoveEvent::Right
    }
  end
end
