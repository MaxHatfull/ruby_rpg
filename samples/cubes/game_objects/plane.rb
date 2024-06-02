# frozen_string_literal: true

module Cubes
  class Plane
    def initialize(pos, rotation, size)
      Engine::GameObject.new(
        "Plane",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size / 2, size],
        components: [
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/cube"),
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture,
            normal_texture: Engine::Texture.new(ASSETS_DIR + "/brick_normal.png").texture
          ),
        ]
      )
    end
  end
end
