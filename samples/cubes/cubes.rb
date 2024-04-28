require_relative "../../src/engine/engine"

ASSETS_DIR = File.expand_path(File.join(__dir__, "assets"))

Engine.start(width: 1920, height: 1080, base_dir: File.dirname(__FILE__)) do
  include Cubes
  Cube.new(Vector[1920 / 4, 1080 / 2, 500], 90, 100)
  Sphere.new(Vector[1920 / 2, 1080 / 2, 500], 90, 100)
  Teapot.new(Vector[3 * 1920 / 4, 1080 / 2, 500], 90, 200)
end