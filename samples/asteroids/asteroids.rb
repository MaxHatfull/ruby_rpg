require_relative "../../src/engine/engine"

include Engine::Types

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  Engine::GameObject.new(
    "Ship",
    pos: Vector.new(300, 300),
    rotation: 45,
    components:
      [ShipEngine.new,
       Gun.new,
       Engine::SpriteRenderer.new(
         Vector.new(-25, 25),
         Vector.new(25, 25),
         Vector.new(25, -25),
         Vector.new(-25, -25),
         Engine::Texture.new(File.join(__dir__, "assets", "Player.png")).texture
       )]
  )

  10.times do
    radius = rand(50..100)
    pos = Vector.new(rand(Engine.screen_width), rand(Engine.screen_height))
    Engine::GameObject.new(
      "Asteroid",
      pos: pos,
      rotation: rand * 360,
      components:
        [Asteroid.new(radius),
         Engine::SpriteRenderer.new(
           Vector.new(-radius / 2, radius / 2),
           Vector.new(radius / 2, radius / 2),
           Vector.new(radius / 2, -radius / 2),
           Vector.new(-radius / 2, -radius / 2),
           Engine::Texture.new(File.join(__dir__, "assets", "Asteroid_01.png")).texture
         )]
    )
  end
end