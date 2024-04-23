require_relative "../../src/engine/engine"

include Engine::Types

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  Ship.new(Vector.new(1920 / 2, 1080 / 2), 90)

  10.times do
    radius = rand(50..100)
    pos = Vector.new(rand(Engine.screen_width), rand(Engine.screen_height))
    Engine::GameObject.new(
      "Asteroid",
      pos: pos,
      rotation: rand * 360,
      components:
        [Asteroid.new(radius),
         Engine::Components::SpriteRenderer.new(
           Vector.new(-radius / 2, radius / 2),
           Vector.new(radius / 2, radius / 2),
           Vector.new(radius / 2, -radius / 2),
           Vector.new(-radius / 2, -radius / 2),
           Engine::Texture.new(File.join(__dir__, "assets", "Asteroid_01.png")).texture
         )]
    )
  end
end