# frozen_string_literal: true

module Presentation
  module DirectionalLight
    def self.create
      Engine::GameObject.new(
        "Direction Light",
        rotation: Vector[-60, 180, 30],
        components: [
          Engine::Components::DirectionLight.new(
            colour: Vector[1.4, 1.4, 1.2],
            )
        ])
    end
  end
end
