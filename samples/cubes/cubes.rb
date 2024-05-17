require_relative "../../src/engine/engine"

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Cubes
  Cube.new(Vector[1920 / 4, 1080 / 2, 0], 90, 100)
  Sphere.new(Vector[1920 / 2, 1080 / 2, 0], 90, 100)
  Teapot.new(Vector[3 * 1920 / 4, 1080 / 2, 0], 90, 200)
  Plane.new(Vector[1000, -100, 0], 0, 1000)

  Engine::GameObject.new(
    "Blue light", pos: Vector[0, 1500, 500],
    components: [
      Engine::Components::PointLight.new(
        range: 1000,
        ambient: Vector[0, 0, 0],
        diffuse: Vector[0, 0, 1],
        specular: Vector[0, 0, 1]
      )
    ])

  Engine::GameObject.new(
    "Pink light", pos: Vector[Engine.screen_width, 1500, 500],
    components: [
      Engine::Components::PointLight.new(
        range: 1000,
        ambient: Vector[0, 0, 0],
        diffuse: Vector[1, 0, 1],
        specular: Vector[1, 0, 1]
      )
    ])

  Engine::GameObject.new(
    "Green light", pos: Vector[Engine.screen_width / 2, 1500, 500],
    components: [
      Engine::Components::PointLight.new(
        range: 1000,
        ambient: Vector[0, 0, 0],
        diffuse: Vector[0, 1, 0],
        specular: Vector[0, 1, 0]
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

  Engine::GameObject.new(
    "Direction Light",
    rotation: Vector[-90, 0, 0],
    components: [
      Engine::Components::DirectionLight.new(
        diffuse: Vector[0.2, 0.2, 0],
        specular: Vector[0.2, 0.2, 0]
      )
    ])
end