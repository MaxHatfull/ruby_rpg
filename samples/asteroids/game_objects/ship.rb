# frozen_string_literal: true

module Asteroids
  class Ship
    def initialize(pos, rotation)
      Engine::GameObject.new(
        "Ship",
        pos: pos,
        rotation: rotation,
        components:
          [ShipEngine.new,
           ClampToScreen.new,
           Gun.new,
           Engine::Components::SpriteRenderer.new(
             Vector[-25, 25],
             Vector[25, 25],
             Vector[25, -25],
             Vector[-25, -25],
             Engine::Texture.for(File.join(ASSETS_DIR, "Player.png")).texture
           )]
      )
    end
  end
end
