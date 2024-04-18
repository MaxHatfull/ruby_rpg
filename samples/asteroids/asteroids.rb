require_relative "../../src/engine/engine"

Engine.load(File.dirname(__FILE__))

GameObject.new(
  "Ship", x: 100, y: 100,
  components:
    [ShipEngine.new, Gun.new]
)

Engine.start(
  title: 'Asteroids',
  width: 1920, height: 1080,
  background: 'navy',
  fullscreen: true
)