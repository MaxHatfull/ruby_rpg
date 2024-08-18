# frozen_string_literal: true

module ShrinkRacer
  module Sphere
    def self.create(pos, size)
      Engine::GameObject.new(
        "Sphere",
        pos: pos,
        rotation: Vector[0, 0, 0],
        scale: Vector[1, 1, 1] * size,
        components: [
          Engine::Components::MeshRenderer.new(Engine::Mesh.for("assets/sphere"), material),
          Spinner.new
        ]
      )
    end

    private

    def self.material
      @material ||=
        begin
          material = Engine::Material.new(Engine::Shader.new('./shaders/mesh_vertex.glsl', './shaders/mesh_frag.glsl'))
          material.set_texture("image", Engine::Texture.for(ASSETS_DIR + "/chessboard.png").texture)
          material.set_texture("normalMap", nil)
          material.set_float("diffuseStrength", 0.5)
          material.set_float("specularStrength", 0.7)
          material.set_float("specularPower", 32.0)
          material.set_vec3("ambientLight", Vector[0.1, 0.1, 0.1])
          material
        end
    end
  end
end
