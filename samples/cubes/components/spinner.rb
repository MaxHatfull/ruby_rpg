# frozen_string_literal: true

module Cubes
  class Spinner < Engine::Component
    def initialize(speed)
      @speed = speed
      @time = 0
    end

    def update(delta_time)
      @time += delta_time
      game_object.rotation = Engine::Quaternion.from_angle_axis(@time * @speed, Vector[1, 1, 0].normalize).to_euler
    end
  end
end
