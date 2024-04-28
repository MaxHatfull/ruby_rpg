# frozen_string_literal: true

module Asteroids
  class ShipEngine < Engine::Component
    ACCELERATION = 500
    MAX_SPEED = 400
    TURNING_SPEED = 200

    def initialize
      @speed = Vector[0, 0, 0]
    end

    def update(delta_time)
      acceleration = Engine::Input.key_down?(GLFW::KEY_UP) ? ACCELERATION : 0
      @speed += game_object.local_to_world_direction(Vector[0.0, acceleration * delta_time, 0.0])
      if @speed.magnitude > MAX_SPEED
        @speed = @speed / @speed.magnitude * MAX_SPEED
      end
      game_object.pos += @speed * delta_time

      torque = Engine::Input.key_down?(GLFW::KEY_LEFT) ? -TURNING_SPEED : 0
      torque += Engine::Input.key_down?(GLFW::KEY_RIGHT) ? TURNING_SPEED : 0
      game_object.rotation += Vector[0, 0, torque * delta_time]
    end
  end
end