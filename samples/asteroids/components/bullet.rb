class Bullet < Engine::Component
  SPEED = 100

  def update(delta_time)
    game_object.pos = game_object.local_to_world_coordinate(0, SPEED * delta_time)
  end
end
