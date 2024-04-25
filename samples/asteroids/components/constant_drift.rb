# frozen_string_literal: true

module Asteroids
  class ConstantDrift < Engine::Component
    include Engine::Types

    def initialize(drift)
      @drift = drift
    end

    def update(delta_time)
      game_object.pos = game_object.local_to_world_coordinate(0, @drift * delta_time)
    end
  end
end
