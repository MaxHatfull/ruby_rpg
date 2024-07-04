require_relative "../../src/engine/engine"
require "pry"

ROOT = File.expand_path(File.join(__dir__))
ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))
WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

Engine.start(width: WINDOW_WIDTH, height: WINDOW_HEIGHT, base_dir: File.dirname(__FILE__)) do
  include Asteroids
  Ship.create(Vector[WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 0], 20)
  OnscreenUI.create

  Engine::GameObject.new(
    "Camera",
    pos: Vector[WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 0],
    components: [
      Engine::Components::OrthographicCamera.new(
        width: WINDOW_WIDTH, height: WINDOW_HEIGHT, far: 1000
      )
    ]
  )

  10.times do
    Asteroid.create(
      Vector[rand(Engine.screen_width), rand(Engine.screen_height), 0],
      rand(360),
      rand(50..100)
    )
  end
end
