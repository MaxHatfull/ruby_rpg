# frozen_string_literal: true

module Asteroids
  module ShipShield
    def self.create
      Engine::GameObject.new(
        "Shield",
        pos: Vector[0,0,0],
        rotation: 0,
        components:
          [
            ShieldComponent.new,
            Engine::Components::SpriteRenderer.new(
              Vector[-50, 50],
              Vector[50, 50],
              Vector[50, -50],
              Vector[-50, -50],
              Engine::Texture.for(File.join(ASSETS_DIR, "Shield.png")).texture
            )
          ]
      )
    end
  end
end
