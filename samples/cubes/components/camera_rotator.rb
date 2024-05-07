# frozen_string_literal: true

module Cubes
  class CameraRotator < Engine::Component
    ROTATION_SPEED = 100

    def update(delta_time)
      if Engine::Input.key_down?(GLFW::KEY_LEFT)
        game_object.rotation[1] += ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_RIGHT)
        game_object.rotation[1] -= ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_UP)
        game_object.rotation[0] += ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_DOWN)
        game_object.rotation[0] -= ROTATION_SPEED * delta_time
      end
    end
  end
end