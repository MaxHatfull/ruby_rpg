# frozen_string_literal: true

module Asteroids
  class FpsComponent < Engine::Component
    def start
      @fps_counter = game_object.ui_renderers.first
    end

    def update(delta_time)
      @fps_counter.update_string("FPS: #{Engine.fps.round(4)}\nTotal Game Objects: #{Engine::GameObject.objects.count}\n\n#{game_objects_tallied}")
    end

    def game_objects_tallied
      Engine::GameObject.objects.map(&:name).tally.map do |game_obj, count|
        "#{game_obj} (#{count})"
      end.join("\n")
    end
  end
end
