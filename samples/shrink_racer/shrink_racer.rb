require_relative "../../src/engine/engine"

ROOT = File.expand_path(File.join(__dir__))
ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include ShrinkRacer

  Engine::GameObject.new(
    "Direction Light",
    rotation: Vector[-60, 180, 30],
    components: [
      Engine::Components::DirectionLight.new(
        colour: Vector[2, 2, 2],
        )
    ])

  1.upto(302) do |i|
    RoadTile.create("%03d" % i, Vector[i * 5, 0, 0], Vector[0, 0, 0], 1)
    Text.create(Vector[i * 5 + 1.5, -1, 0], Vector[0, 0, 0], 1, "%03d" % i)
  end

  RoadTile.create("018", Vector[0, 0, 0], Vector[0, 0, 0], 1)

  Engine::GameObject.new(
    "Camera",
    pos: Vector[0, 5, 7],
    rotation: Vector[20, 0, 0],
    components: [
      CameraRotator.new,
      Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 1000.0)
    ])
end
