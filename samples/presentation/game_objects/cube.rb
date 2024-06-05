# frozen_string_literal: true

module Presentation
  module Cube
    def self.create(pos, rotation, size)
      Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/cube"),
            Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture,
            ambient_light: Vector[0.5, 0.5, 0.4],
          ),
        ]
      )
    end

    def self.create_bumped(pos, rotation, size)
      Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/cube"),
            Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture,
            normal_texture: Engine::Texture.for(ASSETS_DIR + "/brick_normal.png").texture
          ),
        ]
      )
    end
  end
end