# frozen_string_literal: true

module Presentation
  module Sphere
    def self.create(pos, rotation, size)
      parent = Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/sphere"),
            Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture,
            normal_texture: Engine::Texture.for(ASSETS_DIR + "/brick_normal.png").texture,
            ambient_light: Vector[0.5, 0.5, 0.4],
          ),
        ]
      )
      child = Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/sphere"),
            Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture,
            normal_texture: Engine::Texture.for(ASSETS_DIR + "/brick_normal.png").texture,
            ambient_light: Vector[0.5, 0.5, 0.4],
          ),
        ]
      )
      second_child = Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            Engine::Mesh.for("assets/sphere"),
            Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture,
            normal_texture: Engine::Texture.for(ASSETS_DIR + "/brick_normal.png").texture,
            ambient_light: Vector[0.5, 0.5, 0.4],
          ),
        ]
      )
      child.parent = parent
      second_child.parent = child

      child.pos = Vector[3, 0, 0]
      second_child.pos = Vector[3, 0, 0]
      parent
    end
  end
end
