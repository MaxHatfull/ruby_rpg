# frozen_string_literal: true

module ShrinkRacer
  class CarFollower < Engine::Component
    OFFSET = Vector[0, 0.4, -0.8]
    CAMERA_ANGLE = Vector[10, 180, 0]
    FOLLOW_SPEED = 5
    ROTATION_SPEED = 20

    def initialize(target)
      @target = target
    end

    def start
      game_object.pos = target_pos
      game_object.rotation = target_rotation
    end

    def update(delta_time)
      game_object.pos = target_pos #(target_pos - game_object.pos) * delta_time * FOLLOW_SPEED
      game_object.rotation = target_rotation #(target_rotation - game_object.rotation) * delta_time * FOLLOW_SPEED
    end

    private

    def target_pos
      @target.local_to_world_coordinate(OFFSET / @target.scale[0])
    end

    def target_rotation
      @target.rotation + CAMERA_ANGLE
    end
  end
end
