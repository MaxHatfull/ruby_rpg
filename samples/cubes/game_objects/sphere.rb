# frozen_string_literal: true

module Cubes
  class Sphere
    def initialize(pos, rotation, size)
      parent = Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            ASSETS_DIR + "/sphere.obj",
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture
            ),
        ]
      )
      child = Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            ASSETS_DIR + "/sphere.obj",
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture
          ),
        ]
      )
      second_child = Engine::GameObject.new(
        "Cube",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(
            ASSETS_DIR + "/sphere.obj",
            Engine::Texture.new(ASSETS_DIR + "/chessboard.png").texture
          ),
        ]
      )
      child.parent = parent
      second_child.parent = child

      child.pos = Vector[3, 0, 0]
      second_child.pos = Vector[3, 0, 0]
    end
  end
end