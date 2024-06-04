# frozen_string_literal: true

module Presentation
  module Slide3
    def self.create
      parent = Engine::GameObject.new("Slide3")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "Rendering")
      parent.add_child Cube.create(Vector[200, 0, 0], Vector[0, 0, 0], 50)

      parent.add_child Text.create(
        Vector[-350, 100, 0], Vector[0, 0, 0], 20,
        [
          "Mesh data is uploaded to the GPU",
          "- Vertices, normals, UVs, etc",
          "- The GPU is told how to interpret the data",
          "Shaders are written in GLSL",
          "- Vertex shader",
          "- Fragment shader",
          "The shaders are compiled and linked",
          "Per frame, extra data is sent to the shaders (uniforms)",
          "The shaders are executed for each vertex and fragment",
        ].join("\n")
      )

      parent
    end
  end
end
