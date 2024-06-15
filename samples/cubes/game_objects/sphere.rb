# frozen_string_literal: true

module Cubes
  module Sphere
    def self.create(pos, rotation, size)
      parent = Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(Engine::Mesh.for("assets/sphere"), material),
        ]
      )
      child = Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(Engine::Mesh.for("assets/sphere"), material),
        ]
      )
      second_child = Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
        components: [
          Spinner.new(90),
          Engine::Components::MeshRenderer.new(Engine::Mesh.for("assets/sphere"), material),
        ]
      )
      child.parent = parent
      second_child.parent = child

      child.pos = Vector[3, 0, 0]
      second_child.pos = Vector[3, 0, 0]
    end

    private

    def self.material
      @material ||=
        begin
          material = Engine::Material.new(Engine::Shader.new('./shaders/mesh_vertex.glsl', './shaders/mesh_frag.glsl'))
          material.set_texture("image", Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture)
          material.set_texture("normalMap", Engine::Texture.for(ASSETS_DIR + "/brick_normal.png").texture)
          material.set_float("diffuseStrength", 0.5)
          material.set_float("specularStrength", 0.7)
          material.set_float("specularPower", 32.0)
          material.set_vec3("ambientLight", Vector[0.1, 0.1, 0.1])
          material
        end
    end

  end
end
