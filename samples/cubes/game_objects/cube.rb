# frozen_string_literal: true

module Cubes
  class Cube
    def initialize(pos, rotation, size)
      Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.new("assets/cube"),
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture,
            normal_texture: Engine::Texture.new(ASSETS_DIR + "/brick_normal.png").texture
          ),
        ]
      )
    end
  end
end
