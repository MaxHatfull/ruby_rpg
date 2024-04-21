require_relative "../../src/engine/engine"

Engine.load(File.dirname(__FILE__))

Engine.start(
  title: 'Asteroids',
  width: 1920, height: 1080,
  background: 'navy',
  fullscreen: true
) do
  Engine::GameObject.new(
    "Ship",
    pos: Engine::Vector.new(300, 300),
    components:
      [ShipEngine.new,
       Gun.new,
       Engine::SpriteRenderer.new(
         Engine::Vector.new(-25, 25),
         Engine::Vector.new(25, 25),
         Engine::Vector.new(25, -25),
         Engine::Vector.new(-25, -25),
         Engine::Texture.new(File.join(__dir__, "assets", "Player.png")).texture
       )]
  )

  10.times do
    radius = rand(50..100)
    pos = Engine::Vector.new(rand(Engine.screen_width), rand(Engine.screen_height))
    Engine::GameObject.new(
      "Asteroid",
      pos: pos,
      rotation: rand * 360,
      components:
        [Asteroid.new(radius),
         Engine::SpriteRenderer.new(
           Engine::Vector.new(-radius, radius),
           Engine::Vector.new(radius, radius),
           Engine::Vector.new(radius, -radius),
           Engine::Vector.new(-radius, -radius),
           Engine::Texture.new(File.join(__dir__, "assets", "Asteroid_01.png")).texture
         )]
    )
  end
end