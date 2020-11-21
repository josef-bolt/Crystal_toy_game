require "./entity.cr"

class Player < Entity

  def move_request(input_event)
    case input_event
    when MoveEvent::Up then return {0, -1}
    when MoveEvent::Right then return {1, 0}
    when MoveEvent::Down then return {0, 1}
    when MoveEvent::Left then return {-1, 0}
    else return {0, 0}
    end
  end
end
