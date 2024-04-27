require_relative "../../src/engine/engine"

include Engine::Types

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Cubes
  Cube.new(Vector.new(1920 / 2, 1080 / 2), 90, 100)
end