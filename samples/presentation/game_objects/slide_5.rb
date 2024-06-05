# frozen_string_literal: true

module Presentation
  module Slide5
    def self.create
      parent = Engine::GameObject.new("Slide4")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "Lighting")
      parent.add_child Sphere.create(Vector[200, 0, 0], Vector[0, 0, 0], 50)

      parent.add_child Text.create(
        Vector[-400, 100, 0], Vector[0, 0, 0], 20,
        [
          "Mesh data contains normals",
          "- Normals are vectors perpendicular to the surface",
          "In the fragment shader, the normal is used to calculate the lighting",
          "Basic lighting uses the Blinn-Phong model",
          "- Ambient light",
          "- Diffuse light",
          "- Specular light",
          "",
          "Normal maps are textures used to fake more detail",
          "- during import we calculate tangent data",
          "- in the fragment shader, we modify the normal",
          "- this modification comes from a normal map, normal, tangent and bitangent",
        ].join("\n")
      )

      parent
    end
  end
end
