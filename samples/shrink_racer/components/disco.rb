# frozen_string_literal: true

module ShrinkRacer
  class Disco < Engine::Component
    def start
      @light = game_object.components.first
    end

    def update(delta_time)
      @last_change ||= 0
      if @last_change > 0.1
        @light.colour = Vector[rand, rand, rand] * 2
        @last_change = 0
      end
      @last_change += delta_time
    end
  end
end
