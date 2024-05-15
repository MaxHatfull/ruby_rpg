# frozen_string_literal: true

module Engine::Components
  class PerspectiveCamera < Engine::Component
    def initialize(fov:, aspect:, near:, far:)
      @fov = fov
      @aspect = aspect
      @near = near
      @far = far

      Engine::Camera.instance = self
    end

    def matrix
      @matrix ||=
        begin
          (rotation * translation * projection).transpose
        end
    end

    def rotation
      Matrix[
        [game_object.forward[0], game_object.up[0], game_object.right[0], 0],
        [game_object.forward[1], game_object.up[1], game_object.right[1], 0],
        [game_object.forward[2], game_object.up[2], game_object.right[2], 0],
        [0, 0, 0, 1]
      ]
    end

    def translation
      Matrix[
        [1, 0, 0, -game_object.pos[0]],
        [0, 1, 0, -game_object.pos[1]],
        [0, 0, 1, -game_object.pos[2]],
        [0, 0, 0, 1]
      ]
    end

    def projection
      fov = @fov * Math::PI / 180
      Matrix[
        [1 / (Math.tan(fov / 2) * @aspect), 0, 0, 0],
        [0, 1 / Math.tan(fov / 2), 0, 0],
        [0, 0, (@far + @near) / (@near - @far), 2 * @far * @near / (@near - @far)],
        [0, 0, -1, 0]
      ]
    end

    def update(delta_time)
      @matrix = nil if game_object.rotation != @rotation
      @rotation = game_object.rotation
    end
  end
end
