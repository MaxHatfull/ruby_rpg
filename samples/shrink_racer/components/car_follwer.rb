# frozen_string_literal: true

module ShrinkRacer
  class CarFollower < Engine::Component
    OFFSET = Vector[0, 2, -5]
    FOLLOW_SPEED = 5
    ROTATION_SPEED = 20
    def initialize(target)
      @target = target
    end

    def update(delta_time)
      target_pos = @target.local_to_world_coordinate(OFFSET)
      game_object.pos += (target_pos - game_object.pos) * delta_time * FOLLOW_SPEED

      target_rotation = @target.rotation + Vector[10, 180, 0]
      game_object.rotation += (target_rotation - game_object.rotation) * delta_time * FOLLOW_SPEED
    end
  end
end
