# frozen_string_literal: true

module Asteroids
  class FpsComponent < Engine::Component
    def start
      @fps_counter = game_object.ui_renderers.first
    end

    def update(delta_time)
      @fps_counter.update_string("FPS: #{Engine.fps.round(4)}")
    end
  end
end
