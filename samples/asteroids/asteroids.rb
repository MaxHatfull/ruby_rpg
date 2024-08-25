require_relative "../../src/engine/engine"
require "pry"

ROOT = File.expand_path(File.join(__dir__))
ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(base_dir: File.dirname(__FILE__)) do
  include Asteroids
  Ship.create(Vector[Engine::Window.width / 2, Engine::Window.height / 2, 0], 20)
  OnscreenUI.create

  Engine::GameObject.new(
    "Camera",
    pos: Vector[Engine.screen_width / 2, Engine.screen_height / 2, 0],
    components: [
      Engine::Components::OrthographicCamera.new(
        width: Engine.screen_width, height: Engine.screen_height, far: 1000
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
