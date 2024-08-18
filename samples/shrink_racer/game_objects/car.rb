# frozen_string_literal: true

module ShrinkRacer
  module Car
    def self.create_suv(pos, rotation)
      Engine::GameObject.new(
        "SUV",
        pos: pos,
        rotation: rotation,
        scale: Vector[0.3, 0.3, 0.3],
        components: [
          CarController.new,
          Engine::Components::MeshRenderer.new(Engine::Mesh.for(
            "assets/cars/suv"), material),
        ]
      )
    end

    private

    def self.material
      @material ||=
        begin
          material = Engine::Material.new(Engine::Shader.new('./shaders/mesh_vertex.glsl', './shaders/mesh_frag.glsl'))
          material.set_texture("image", Engine::Texture.for(File.join(ASSETS_DIR, "cars/Textures/colormap.png"), flip: true).texture)
          material.set_texture("normalMap", nil)
          material.set_float("diffuseStrength", 0.5)
          material.set_float("specularStrength", 0.6)
          material.set_float("specularPower", 32.0)
          material.set_vec3("ambientLight", Vector[0.5, 0.5, 0.5])
          material
        end
    end
  end
end
