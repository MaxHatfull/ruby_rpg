# frozen_string_literal: true

module ShrinkRacer
  module RoadTile
    def self.create(tile_number, pos, rotation, size)
      Engine::GameObject.new(
        "Road Tile",
        pos: pos,
        rotation: rotation,
        scale: Vector[size, size, size],
        components: [
          Engine::Components::MeshRenderer.new(Engine::Mesh.for(
            "assets/road_tiles/roadTile_" + tile_number), material),
        ]
      )
    end


    private

    def self.material
      @material ||=
        begin
          material = Engine::Material.new(Engine::Shader.new('./shaders/mesh_vertex.glsl', './shaders/mesh_frag.glsl'))
          material.set_texture("image", nil)
          material.set_texture("normalMap", nil)
          material.set_float("diffuseStrength", 0.5)
          material.set_float("specularStrength", 0.7)
          material.set_float("specularPower", 32.0)
          material.set_vec3("ambientLight", Vector[0.5, 0.5, 0.5])
          material
        end
    end
  end
end
