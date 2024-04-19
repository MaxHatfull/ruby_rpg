class ShipEngine < Engine::Component
  ACCELERATION = 50
  MAX_SPEED = 500
  TURNING_SPEED = 100

  def initialize
    @speed = 0
  end

  def update(delta_time)
    acceleration = Engine::Input.key_down?(GLFW::KEY_UP) ? ACCELERATION : -ACCELERATION / 5
    @speed += acceleration
    @speed = 0 if @speed < 0
    @speed = MAX_SPEED if @speed > MAX_SPEED
    game_object.pos = game_object.local_to_world_coordinate(0, @speed * delta_time)

    torque = Engine::Input.key_down?(GLFW::KEY_LEFT) ? TURNING_SPEED : 0
    torque += Engine::Input.key_down?(GLFW::KEY_RIGHT) ? -TURNING_SPEED : 0
    game_object.rotation += torque * delta_time
  end
end