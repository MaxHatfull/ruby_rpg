# frozen_string_literal: true

module Asteroids
  class ShipEngine < Engine::Component
    ACCELERATION = 800
    DECELERATION = 800
    MAX_SPEED = 600
    TURNING_SPEED = 300

    def initialize
      @speed = Vector[0, 0, 0]
    end

    def update(delta_time)
      DEBUG_UI.children.first.ui_renderers.first.update_string("FPS: #{Engine.fps.round(4)}")
      if Engine::Input.key_down?(GLFW::KEY_UP)
        acceleration = ACCELERATION
        deceleration = 0
      elsif Engine::Input.key_down?(GLFW::KEY_DOWN)
        acceleration = 0
        deceleration = DECELERATION
      else
        acceleration = 0
        deceleration = 0
      end

      @speed += game_object.local_to_world_direction(Vector[0.0, (acceleration - deceleration) * delta_time, 0.0])
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
