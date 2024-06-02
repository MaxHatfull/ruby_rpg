# frozen_string_literal: true

module Cubes
  module Teapot
    def self.create(pos, rotation, size)
      Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Cubes::Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/teapot"),
            Engine::Texture.for(File.join(ROOT, "assets/chessboard.png")).texture,
            normal_texture: Engine::Texture.for(File.join(ROOT, "assets/brick_normal.png")).texture
          ),
        ]
      )
    end
  end
end
