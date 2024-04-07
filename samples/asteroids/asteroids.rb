require_relative "../../src/engine/engine"

Engine.start(
  title: 'Asteroids',
  width: 1920, height: 1080,
  background: 'navy',
  fullscreen: true
) do
  GameObject.new(
    "Ship", x: 100, y: 100,
    components:
      [ShipEngine.new, Gun.new]
  )
end
