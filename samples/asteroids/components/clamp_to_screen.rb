# frozen_string_literal: true

class ClampToScreen < Engine::Component
  def update(delta_time)
    clamp_to_screen
  end

  private

  def clamp_to_screen
    if game_object.x > Engine.screen_width
      game_object.x = 0
    elsif game_object.x < 0
      game_object.x = Engine.screen_width
    end
    if game_object.y > Engine.screen_height
      game_object.y = 0
    elsif game_object.y < 0
      game_object.y = Engine.screen_height
    end
  end
end