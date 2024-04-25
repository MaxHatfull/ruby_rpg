# frozen_string_literal: true

module Asteroids
  class Explosion
    def initialize(pos)
      Engine::GameObject.new(
        "Explosion",
        pos: pos,
        components: [
          Engine::Components::SpriteRenderer.new(
            Vector.new(-100, 100),
            Vector.new(100, 100),
            Vector.new(100, -100),
            Vector.new(-100, -100),
            Explosion.explosion_texture.texture,
            [
              { tl: Vector.new(1.0 / 6, 0), width: 1.0 / 6, height: 1 },
              { tl: Vector.new(2.0 / 6, 0), width: 1.0 / 6, height: 1 },
              { tl: Vector.new(3.0 / 6, 0), width: 1.0 / 6, height: 1 },
              { tl: Vector.new(4.0 / 6, 0), width: 1.0 / 6, height: 1 },
              { tl: Vector.new(5.0 / 6, 0), width: 1.0 / 6, height: 1 },
              { tl: Vector.new(0, 0), width: 1.0 / 6, height: 1 },
            ],
            20,
            false
          )
        ]
      )
    end

    private

    def self.explosion_texture
      @explosion_texture ||= Engine::Texture.new(File.join(ASSETS_DIR, "boom.png"))
    end
  end
end