require_relative "../../src/engine/engine"

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Cubes
  # Cube.new(Vector[1920 / 4, 1080 / 2, 0], 0, 100)
  Sphere.new(Vector[1920 / 2, 1080 / 2, 0], 0, 100)
  # Teapot.new(Vector[3 * 1920 / 4, 1080 / 2, 0], 0, 200)
  # Plane.new(Vector[1000, -100, 0], 0, 1000)
  Cubes::Light.new(Vector[0, 1500, 500], 1000, Vector[0, 0, 1])
  Cubes::Light.new(Vector[Engine.screen_width, 1500, 500], 1000, Vector[1, 0, 1])
  Cubes::Light.new(Vector[Engine.screen_width / 2, 1500, 500], 1000, Vector[0, 1, 0])
  Engine::GameObject.new(
    "Direction Light",
    rotation: Vector[-90, 0, 30],
    components: [
      Engine::Components::DirectionLight.new(
        colour: Vector[0.8, 0.8, 0.6],
        )
    ])

  Engine::GameObject.new(
    "Orthographic Camera",
    pos: Vector[1920 / 2, 1080 / 2, 500],
    components: [
      Cubes::CameraRotator.new,
      Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 5000.0)
    # Engine::Components::OrthographicCamera.new(width: 1920, height: 1080, far: 1000)
    ])
end