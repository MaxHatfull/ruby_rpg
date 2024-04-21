class ShipEngine < Engine::Component
  ACCELERATION = 500
  MAX_SPEED = 400
  TURNING_SPEED = 200

  def initialize
    @speed = Engine::Vector.new(0, 0)
  end

  def update(delta_time)
    acceleration = Engine::Input.key_down?(GLFW::KEY_UP) ? ACCELERATION : 0
    @speed += Engine::Vector.new(0, acceleration * delta_time).rotate(game_object.rotation)
    if @speed.magnitude > MAX_SPEED
      @speed = @speed / @speed.magnitude * MAX_SPEED
    end
    game_object.pos += @speed * delta_time
    clamp_to_screen

    torque = Engine::Input.key_down?(GLFW::KEY_LEFT) ? TURNING_SPEED : 0
    torque += Engine::Input.key_down?(GLFW::KEY_RIGHT) ? -TURNING_SPEED : 0
    game_object.rotation += torque * delta_time
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