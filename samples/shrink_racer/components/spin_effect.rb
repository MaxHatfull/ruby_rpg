# frozen_string_literal: true

module ShrinkRacer
  class SpinEffect < Engine::Component
    SPIN_DURATION = 0.5

    def initialize
      @spin_time = 1
    end

    def spin
      @spin_time = 0
      @spin_direction = [:left, :right].sample
    end

    def update(delta_time)
      if @spin_time < 1
        sign = {left: 1.0 , right: -1.0 }[@spin_direction]
        game_object.rotation = sign * Vector[0, 360, 0] * @spin_time
        @spin_time += delta_time / SPIN_DURATION
      end
    end
  end
end
