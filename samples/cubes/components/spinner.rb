# frozen_string_literal: true

module Cubes
  class Spinner < Engine::Component
    def initialize(speed)
      @speed = speed
    end

    def update(delta_time)
      #game_object.rotation += Vector[@speed, @speed, @speed] * delta_time
    end
  end
end