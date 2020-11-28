require "./entity.cr"

class Player < Entity

  def process_move_input(input_event)
    @move_request = case input_event
                    when MoveEvent::Up then {0, -1}
                    when MoveEvent::Right then {1, 0}
                    when MoveEvent::Down then {0, 1}
                    when MoveEvent::Left then {-1, 0}
                    else {0, 0}
                    end
  end

  def update_requests
  end

  def move(location)
    @location = location
    @move_request = {0, 0}
  end
end
