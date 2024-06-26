require_relative "../../src/engine/engine"
require "pry"

ROOT = File.expand_path(File.join(__dir__))
ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))
WINDOW_WIDTH = 1440
WINDOW_HEIGHT = 900

Engine.start(width: WINDOW_WIDTH, height: WINDOW_HEIGHT, base_dir: File.dirname(__FILE__)) do
  include Asteroids
  Ship.create(Vector[WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2, 0], 20)

  # Create a camera for rendering text to the Onscreen UI
  Engine::GameObject.new(
    "Onscreen UI Camera",
    pos: Vector[WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 1],
    rotation: Vector[0, 0, 0],
    components: [
      Engine::Components::OrthographicCamera.new(width: WINDOW_WIDTH, height: WINDOW_HEIGHT, far: 2)
    ]
  )

  DEBUG_UI = OnscreenUI.create

  10.times do
    Asteroid.create(
      Vector[rand(Engine.screen_width), rand(Engine.screen_height), 0],
      rand(360),
      rand(50..100)
    )
  end
end
