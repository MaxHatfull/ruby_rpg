# frozen_string_literal: true

module Asteroids
  class FpsComponent < Engine::Component
    def start
      @fps_counter = game_object.ui_renderers.first
    end

    def onscreen_message
      [
        "FPS: #{Engine.fps.round(4)}",
        "Total Game Objects: #{Engine::GameObject.objects.count}",
        "",
        "#{game_objects_tallied}"
      ].join("\n")
    end

    def update(delta_time)
      @fps_counter.update_string(onscreen_message)
    end

    def game_objects_tallied
      Engine::GameObject.objects.map(&:name).tally.map do |game_obj, count|
        "#{game_obj} (#{count})"
      end.join("\n")
    end
  end
end
