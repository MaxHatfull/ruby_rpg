class ShipEngine < Engine::Component
  include Engine::Types

  ACCELERATION = 500
  MAX_SPEED = 400
  TURNING_SPEED = 200

  def initialize
    @speed = Vector.new(0, 0)
  end

  def update(delta_time)
    acceleration = Engine::Input.key_down?(GLFW::KEY_UP) ? ACCELERATION : 0
    @speed += Vector.new(0, acceleration * delta_time).rotate(game_object.rotation)
    if @speed.magnitude > MAX_SPEED
      @speed = @speed / @speed.magnitude * MAX_SPEED
    end
    game_object.pos += @speed * delta_time

    torque = Engine::Input.key_down?(GLFW::KEY_LEFT) ? -TURNING_SPEED : 0
    torque += Engine::Input.key_down?(GLFW::KEY_RIGHT) ? TURNING_SPEED : 0
    game_object.rotation += torque * delta_time
  end
end