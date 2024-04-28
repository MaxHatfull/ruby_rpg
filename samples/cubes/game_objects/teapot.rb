# frozen_string_literal: true

module Cubes
  class Teapot
    def initialize(pos, rotation, size)
      Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            ASSETS_DIR + "/teapot.obj",
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture
            ),
        ]
      )
    end
  end
end