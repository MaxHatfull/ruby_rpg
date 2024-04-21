class Bullet < Engine::Component
  SPEED = 500
  LIFE_SPAN = 2

  def update(delta_time)
    game_object.pos = game_object.local_to_world_coordinate(0, SPEED * delta_time)
    clamp_to_screen

    game_object.destroy! if Time.now - game_object.created_at > LIFE_SPAN
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
