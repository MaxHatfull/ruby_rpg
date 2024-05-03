require_relative "../../src/engine/engine"

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Cubes
  Cube.new(Vector[1920 / 4, 1080 / 2, 500], 90, 100)
  Sphere.new(Vector[1920 / 2, 1080 / 2, 500], 90, 100)
  Teapot.new(Vector[3 * 1920 / 4, 1080 / 2, 500], 90, 200)
  #Plane.new(Vector[1000, 0, 500], 0, 1000)

  Engine::GameObject.new(
    "light", pos: Vector[0, 1000, 1000], components: [
    Engine::Components::PointLight.new(
      constant: 0,
      linear: 0,
      quadratic: 0.000001,
      ambient: Vector[0, 0, 0],
      diffuse: Vector[0, 0, 1],
      specular: Vector[0, 0, 1]
    )
  ])

  Engine::GameObject.new(
    "light", pos: Vector[Engine.screen_width, 1000, 1000], components: [
    Engine::Components::PointLight.new(
      constant: 0,
      linear: 0,
      quadratic: 0.000001,
      ambient: Vector[0, 0, 0],
      diffuse: Vector[1, 0, 1],
      specular: Vector[1, 0, 1]
    )
  ])

  Engine::GameObject.new(
    "light", pos: Vector[Engine.screen_width / 2, 1500, 1000], components: [
    Engine::Components::PointLight.new(
      constant: 0,
      linear: 0,
      quadratic: 0.000001,
      ambient: Vector[0, 0, 0],
      diffuse: Vector[0, 1, 0],
      specular: Vector[0, 1, 0]
    )
  ])
end