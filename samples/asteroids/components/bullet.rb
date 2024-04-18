class Bullet < Component
  SPEED = 1000

  def update(delta_time)
    pos = game_object.local_to_world_coordinate(0, -SPEED * delta_time)
    game_object.x = pos[:x]
    game_object.y = pos[:y]
    Engine.draw_circle(game_object.x, game_object.y, 5, r: rand, g: rand, b: rand)
  end
end
