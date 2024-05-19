# frozen_string_literal: true

module Cubes
  class Light
    def initialize(pos, range, colour)
      Engine::GameObject.new(
        "Light",
        pos: pos,
        components: [
          Engine::Components::PointLight.new(range: range, colour: colour),
        ]
      )
    end
  end
end