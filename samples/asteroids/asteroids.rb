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
    pos: { x: 300, y: 300 },
    components:
      [ShipEngine.new,
       Gun.new,
       Engine::SpriteRenderer.new(
          { x: -25, y: 25 },
          { x: 25, y: 25 },
          { x: 25, y: -25 },
          { x: -25, y: -25 },
          Engine::Texture.new(File.join(__dir__, "Player.png")).texture
        )]
  )
end