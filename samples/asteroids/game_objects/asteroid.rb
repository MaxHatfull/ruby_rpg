# frozen_string_literal: true

class Asteroid
  def initialize(pos, rotation, radius)
    Engine::GameObject.new(
      "Asteroid",
      pos: pos,
      rotation: rotation,
      components:
        [AsteroidComponent.new(radius),
         ConstantDrift.new(rand(150)),
         ClampToScreen.new,
         Engine::Components::SpriteRenderer.new(
           Vector.new(-radius / 2, radius / 2),
           Vector.new(radius / 2, radius / 2),
           Vector.new(radius / 2, -radius / 2),
           Vector.new(-radius / 2, -radius / 2),
           Asteroid.asteroid_texture
         )]
    )
  end

  private

  def self.asteroid_texture
    @asteroid_texture ||= Engine::Texture.new(File.join(ASSETS_DIR, "Asteroid_01.png")).texture
  end
end