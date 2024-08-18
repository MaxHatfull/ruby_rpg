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
        colour: Vector[1, 1, 1],
      ),
    ])

  #RoadTrack.create_gallery
  RoadTrack.create

  car = Car.create_suv(Vector[1.5, 0.75, 0], Vector[0, 180, 0])
  Engine::GameObject.new(
    "Camera",
    pos: Vector[0, 0, 0],
    rotation: Vector[20, 180, 0],
    components: [
      CarFollower.new(car),
      Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: 1920.0 / 1080.0, near: 0.1, far: 1000.0)
    ])
end
