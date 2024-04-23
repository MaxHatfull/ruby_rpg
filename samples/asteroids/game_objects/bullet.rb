# frozen_string_literal: true

class Bullet
  BULLET_SIZE = 5

  def initialize(pos, rotation)
    Engine::GameObject.new(
      "Bullet",
      pos: pos,
      rotation: rotation,
      components: [
        Projectile.new,
        Engine::Components::SpriteRenderer.new(
          Vector.new(-BULLET_SIZE / 2, BULLET_SIZE / 2),
          Vector.new(BULLET_SIZE / 2, BULLET_SIZE / 2),
          Vector.new(BULLET_SIZE / 2, -BULLET_SIZE / 2),
          Vector.new(-BULLET_SIZE / 2, -BULLET_SIZE / 2),
          Bullet.texture
        )
      ]
    )
  end

  def self.texture
    @texture ||= Engine::Texture.new(File.join(ASSETS_DIR, "Square.png")).texture
  end
end