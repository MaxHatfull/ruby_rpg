# frozen_string_literal: true

module ShrinkRacer
  module RoadTile
    def self.create(tile_number, pos, rotation)
      parent = Engine::GameObject.new(
        "Road Tile",
        pos: pos,
        rotation: rotation,
        scale: Vector[1, 1, 1],
      )

      Engine::GameObject.new(
        "Road Tile",
        pos: Vector[-1.5, 0, 1.5],
        rotation: Vector[0, 0, 0],
        scale: Vector[1, 1, 1],
        components: [
          Engine::Components::MeshRenderer.new(Engine::Mesh.for(
            "assets/road_tiles/roadTile_" + tile_number), material),
        ],
        parent: parent
      )
      parent
    end

    def self.create_straight_road(pos, rotation)
      create("162", pos, rotation)
    end

    def self.create_corner_road(pos, rotation)
      create("153", pos, rotation)
    end

    def self.create_t_junction_road(pos, rotation)
      create("150", pos, rotation)
    end

    def self.create_cross_road(pos, rotation)
      create("141", pos, rotation)
    end

    def create_bridge_road(pos, rotation)
      create("188", pos, rotation)
    end

    def self.create_grass(pos, rotation)
      tree_offset = Vector[rand(-1.5..1.5), 0, rand(-1.5..1.5)]
      place_tree(pos + tree_offset, rotation)
      create("163", pos, rotation)
    end

    def self.place_tree(pos, rotation)
      file_number = ["019", "020"].sample

      Engine::GameObject.new(
        "Tree",
        pos: pos + Vector[0, 0.6, 0],
        rotation: rotation,
        scale: Vector[1, 1, 1] * rand(0.5..1.0),
        components: [
          Engine::Components::MeshRenderer.new(Engine::Mesh.for(
            "assets/road_tiles/roadTile_" + file_number), material),
        ]
      )
    end

    private

    def self.material
      @material ||=
        begin
          material = Engine::Material.new(Engine::Shader.new('./shaders/vertex_lit_vertex.glsl', './shaders/vertex_lit_frag.glsl'))
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
