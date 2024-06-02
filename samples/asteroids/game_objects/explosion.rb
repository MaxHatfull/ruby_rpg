# frozen_string_literal: true

module Asteroids
  module Explosion
    def self.create(pos)
      Engine::GameObject.new(
        "Explosion",
        pos: pos,
        components: [
          Engine::Components::SpriteRenderer.new(
            Vector[-100, 100],
            Vector[100, 100],
            Vector[100, -100],
            Vector[-100, -100],
            Explosion.explosion_texture.texture,
            [
              { tl: Vector[1.0 / 6, 0], width: 1.0 / 6, height: 1 },
              { tl: Vector[2.0 / 6, 0], width: 1.0 / 6, height: 1 },
              { tl: Vector[3.0 / 6, 0], width: 1.0 / 6, height: 1 },
              { tl: Vector[4.0 / 6, 0], width: 1.0 / 6, height: 1 },
              { tl: Vector[5.0 / 6, 0], width: 1.0 / 6, height: 1 },
              { tl: Vector[0, 0], width: 1.0 / 6, height: 1 },
            ],
            20,
            false
          )
        ]
      )
    end

    private

    def self.explosion_texture
      @explosion_texture ||= Engine::Texture.for(File.join(ASSETS_DIR, "boom.png"))
    end
  end
end
