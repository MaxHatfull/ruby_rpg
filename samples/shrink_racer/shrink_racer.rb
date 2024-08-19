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
  track = RoadTrack::TRACKS[:track_3]
  RoadTrack.create(track)

  car = Car.create_suv(track[:start_pos], track[:start_rot])
  CameraObject.create(car)
  #CameraObject.debug_camera
end
