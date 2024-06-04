require_relative "../../src/engine/engine"

ROOT = File.expand_path(File.join(__dir__))
ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Presentation

  Engine::GameObject.new(
    "Camera",
    pos: Vector[0, 0, 700],
    rotation: Vector[0, 0, 0],
    components: [
      Presentation::CameraRotator.new,
      Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 10000.0)
    ])

  DirectionalLight.create

  Engine::GameObject.new("Slide manager",
    components: [SlideManager.new]
  )
end
