# frozen_string_literal: true

module Cubes
  class Plane
    def initialize(pos, rotation, size)
      Engine::GameObject.new(
        "Plane",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size/2, size],
        components: [
          Engine::Components::MeshRenderer.new(
            ASSETS_DIR + "/cube.obj",
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture
            ),
        ]
      )
    end
  end
end