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

  1.upto(100) do |i|
    RoadTile.create("%03d" % i, Vector[i * 50, 20, 0], 0, 10)
  end

  Engine::GameObject.new(
    "Camera",
    pos: Vector[0, 50, 70],
    rotation: Vector[20, 0, 0],
    components: [
      CameraRotator.new,
      Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 1000.0)
    ])
end
