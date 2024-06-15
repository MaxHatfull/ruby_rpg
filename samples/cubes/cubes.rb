require_relative "../../src/engine/engine"

ROOT = File.expand_path(File.join(__dir__))
ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Cubes
  (-3..3).each do |x|
    Plane.create(Vector[x * 1000, 1000, -1000], Vector[0,0,0], 1000)
    (0..3).each do |y|
      Plane.create(Vector[x * 1000, 0, y * 1000], Vector[90,0,0], 1000)
    end
  end

  Cube.create(Vector[0, 200, 0], 0, 100)
  Cube.create_bumped(Vector[500, 200, 0], 0, 100)
  Teapot.create(Vector[1000, 200, 0], 0, 200)
  Sphere.create(Vector[2000, 500, 0], 0, 100)

  Cubes::Light.create(Vector[2500, 500, 0], 500, Vector[0, 0, 1])
  Cubes::Light.create(Vector[1500, 600, 200], 500, Vector[1, 0, 1])
  Cubes::Light.create(Vector[2000, 1000, 500], 500, Vector[0, 1, 0])

  Engine::GameObject.new(
    "Camera",
    pos: Vector[0, 500, 700],
    rotation: Vector[20, 0, 0],
    components: [
      Cubes::CameraRotator.new,
      Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 10000.0)
    # Engine::Components::OrthographicCamera.new(width: 1920, height: 1080, far: 1000)
    ])

  Engine::GameObject.new(
    "Direction Light",
    rotation: Vector[-60, 180, 30],
    components: [
      Engine::Components::DirectionLight.new(
        colour: Vector[1.4, 1.4, 1.2],
        )
    ])

  Text.create(Vector[-200, 600, 0], Vector[0, 0, 0], 100, "Hello World\nNew Line")

  ui_material = Engine::Material.new(Engine::Shader.new('./shaders/ui_sprite_vertex.glsl', './shaders/ui_sprite_frag.glsl'))
  ui_material.set_texture("image", Engine::Texture.for(ASSETS_DIR + "/cube.png").texture)
  ui_material.set_vec4("spriteColor", Vector[1, 1, 1, 1])

  Engine::GameObject.new(
    "UI image",
    pos: Vector[100, 100, 0], rotation: Vector[0, 0, 0], scale: Vector[1, 1, 1],
    components: [
      Engine::Components::UISpriteRenderer.new(
        Vector[100, 100], Vector[200, 100], Vector[200, 0], Vector[100, 0],
        ui_material
        )
    ])
end
