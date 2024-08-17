# frozen_string_literal: true

module ShrinkRacer
  class CameraRotator < Engine::Component
    ROTATION_SPEED = 60
    MOVE_SPEED = 5

    def update(delta_time)
      if Engine::Input.key_down?(GLFW::KEY_LEFT)
        game_object.rotation[1] -= ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_RIGHT)
        game_object.rotation[1] += ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_UP)
        game_object.rotation[0] -= ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_DOWN)
        game_object.rotation[0] += ROTATION_SPEED * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_LEFT_SHIFT)
        speed = MOVE_SPEED * 2
      else
        speed = MOVE_SPEED
      end
      if Engine::Input.key_down?(GLFW::KEY_A)
        game_object.pos -= game_object.right * speed * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_D)
        game_object.pos += game_object.right * speed * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_W)
        game_object.pos -= Vector[game_object.forward[0], 0, game_object.forward[2]].normalize * speed * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_S)
        game_object.pos += Vector[game_object.forward[0], 0, game_object.forward[2]].normalize * speed * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_Q)
        game_object.pos -= Vector[0, 1, 0] * speed * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_E)
        game_object.pos += Vector[0, 1, 0] * speed * delta_time
      end
    end
  end
end
