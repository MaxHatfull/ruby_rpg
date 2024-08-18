# frozen_string_literal: true

module ShrinkRacer
  class CarController < Engine::Component
    ACCELERATION = 1.0
    DRAG = 0.5
    SIDE_DRAG = 0.9
    def initialize
      @speed = Vector[0, 0, 0]
    end
    def update(delta_time)
      thrust = 0
      if Engine::Input.key_down?(GLFW::KEY_SPACE) || Engine::Input.key_down?(GLFW::KEY_W)
        thrust = ACCELERATION
      end
      if Engine::Input.key_down?(GLFW::KEY_S)
        thrust -= ACCELERATION / 2
      end
      drag = -@speed.dot(game_object.forward) * DRAG
      side_drag = -@speed.dot(game_object.right)
      @speed += game_object.forward * (thrust + drag)
      @speed += game_object.right * (side_drag)

      game_object.pos += @speed * delta_time

      if Engine::Input.key_down?(GLFW::KEY_A)
        game_object.rotation[1] -= 90 * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_D)
        game_object.rotation[1] += 90 * delta_time
      end
    end

    def collide(tree_pos)
      flat_pos = Vector[game_object.pos[0], 0, game_object.pos[2]]
      flat_tree_pos = Vector[tree_pos[0], 0, tree_pos[2]]
      incident = (flat_tree_pos - flat_pos).normalize
      collision_speed = @speed.dot(incident)
      @speed -= collision_speed * incident if collision_speed > 0
    end
  end
end
