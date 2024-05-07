# frozen_string_literal: true

module Cubes
  class CameraRotator < Engine::Component
    ROTATION_SPEED = 100

    def update(delta_time)
      if Engine::Input.key_down?(GLFW::KEY_LEFT)
        Engine::Camera.instance.rotate(delta_time * ROTATION_SPEED, Vector[0, 1, 0])
      end
      if Engine::Input.key_down?(GLFW::KEY_RIGHT)
        Engine::Camera.instance.rotate(-delta_time * ROTATION_SPEED, Vector[0, 1, 0])
      end
      if Engine::Input.key_down?(GLFW::KEY_UP)
        Engine::Camera.instance.rotate(delta_time * ROTATION_SPEED, Engine::Camera.instance.right.normalize)
      end
      if Engine::Input.key_down?(GLFW::KEY_DOWN)
        Engine::Camera.instance.rotate(-delta_time * ROTATION_SPEED, Engine::Camera.instance.right.normalize)
      end
    end
  end
end