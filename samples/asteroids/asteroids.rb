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
         Engine::Texture.new(File.join(__dir__, "Player.png")).texture
       )]
  )
end