# frozen_string_literal: true

module ShrinkRacer
  class Spinner < Engine::Component
    def update(delta_time)
      game_object.rotation += Vector[0, 90, 0] * delta_time
    end
  end
end
