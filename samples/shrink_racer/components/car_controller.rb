# frozen_string_literal: true

module ShrinkRacer
  class CarController < Engine::Component
    ACCELERATION = 300.0
    DRAG = 5.0
    SIDE_DRAG = 10.0
    WIND_UP_TIME = 0.25

    def initialize(spinner)
      @spinner = spinner
      @speed = Vector[0, 0, 0]
      @current_time = 0.0
      @last_shrink_time = -999.0
      @last_collision_time = -999.0
      @acceleration = 0
    end

    def start
      @target_scale = game_object.scale
    end

    def update(delta_time)
      @current_time += delta_time
      game_object.scale += 15.0 * (@target_scale - game_object.scale) * delta_time

      if @current_time - @last_collision_time > 0.5
        if Engine::Input.key_down?(GLFW::KEY_W)
          @acceleration += delta_time * max_acceleration / WIND_UP_TIME
        elsif Engine::Input.key_down?(GLFW::KEY_S)
          @acceleration -= delta_time * max_acceleration / WIND_UP_TIME
        else
          @acceleration = 0
        end
      else
        @acceleration = 0
      end

      @acceleration = @acceleration.clamp(-max_acceleration / 2, max_acceleration)

      thrust = @acceleration
      drag = -@speed.dot(game_object.forward.normalize) * DRAG
      side_drag = -@speed.dot(game_object.right.normalize) * SIDE_DRAG
      @speed += game_object.forward.normalize * (thrust + drag) * delta_time
      @speed += game_object.right.normalize * side_drag * delta_time

      game_object.pos += @speed * delta_time

      if Engine::Input.key_down?(GLFW::KEY_A)
        game_object.rotation[1] -= 90 * delta_time
      end
      if Engine::Input.key_down?(GLFW::KEY_D)
        game_object.rotation[1] += 90 * delta_time
      end
    end

    def max_acceleration
      ACCELERATION * game_object.scale[0]
    end

    def collide(tree_pos)
      flat_pos = Vector[game_object.pos[0], 0, game_object.pos[2]]
      flat_tree_pos = Vector[tree_pos[0], 0, tree_pos[2]]

      incident = (flat_tree_pos - flat_pos).normalize
      collision_speed = @speed.dot(incident)
      if collision_speed > 0
        @speed -= collision_speed * incident * 1.8
        @acceleration = 0
        @last_collision_time = @current_time

        if @current_time - @last_shrink_time > 0.5
          @target_scale *= 0.8
          @spinner.spin
          @last_shrink_time = @current_time
        end
      end
    end
  end
end
