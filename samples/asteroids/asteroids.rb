require_relative "../../src/engine/engine"

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Asteroids
  Ship.new(Vector[1920.0 / 2, 1080.0 / 2], 10)

  10.times do
    Asteroid.new(
      Vector[rand(Engine.screen_width), rand(Engine.screen_height), 0],
      rand(360),
      rand(50..100)
    )
  end
end