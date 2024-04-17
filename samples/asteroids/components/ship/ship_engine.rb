class ShipEngine < Component
  ACCERATION = 0.1
  MAX_SPEED = 5
  TURNING_SPEED = 4

  def start
    @speed = 0
  end

  def update
    acceleration = Engine.key_down?(GLFW::KEY_UP) ? ACCERATION : -ACCERATION / 2
    @speed += acceleration
    @speed = 0 if @speed < 0
    @speed = MAX_SPEED if @speed > MAX_SPEED
    torque = Engine.key_down?(GLFW::KEY_LEFT) ? -TURNING_SPEED : 0
    torque += Engine.key_down?(GLFW::KEY_RIGHT) ? TURNING_SPEED : 0
    game_object.rotation -= torque

    rotation = game_object.rotation * Math::PI / 180
    game_object.x += Math.sin(rotation) * @speed
    game_object.y -= Math.cos(rotation) * @speed

    Engine.draw_triangle(
      *game_object.local_to_world_coordinate(0, -40),
      *game_object.local_to_world_coordinate(-20, 40),
      *game_object.local_to_world_coordinate(20, 40)
    )
  end
end