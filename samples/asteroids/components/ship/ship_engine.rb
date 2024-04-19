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
    torque = Engine::Input.key_down?(GLFW::KEY_LEFT) ? -TURNING_SPEED : 0
    torque += Engine::Input.key_down?(GLFW::KEY_RIGHT) ? TURNING_SPEED : 0
    game_object.rotation -= torque * delta_time

    rotation = game_object.rotation * Math::PI / 180
    game_object.x += Math.sin(rotation) * @speed * delta_time
    game_object.y -= Math.cos(rotation) * @speed * delta_time
  end
end