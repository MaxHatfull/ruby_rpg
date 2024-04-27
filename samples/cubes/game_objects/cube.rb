# frozen_string_literal: true

module Cubes
  class Cube
    include Engine::Types

    def initialize(pos, rotation, size)
      Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector.new(size, size, size),
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(ASSETS_DIR + "/cube.obj"),
        ]
      )
    end
  end
end