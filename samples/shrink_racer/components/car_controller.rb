# frozen_string_literal: true

module ShrinkRacer
  class CarController < Engine::Component
    ACCELERATION = 1.0
    DRAG = 0.04
    def initialize
      @speed = 0
    end
    def update(delta_time)
      thrust = 0
      if Engine::Input.key_down?(GLFW::KEY_SPACE) || Engine::Input.key_down?(GLFW::KEY_W)
        thrust = ACCELERATION
      end
      if Engine::Input.key_down?(GLFW::KEY_S)
        thrust -= ACCELERATION / 2
      end
      drag = -@speed * DRAG
      @speed += thrust + drag
      game_object.pos += game_object.forward * @speed * delta_time

      if Engine::Input.key_down?(GLFW::KEY_A)
        game_object.rotation[1] -= 90 * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_D)
        game_object.rotation[1] += 90 * delta_time
      end
    end
  end
end
