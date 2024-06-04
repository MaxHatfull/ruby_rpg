# frozen_string_literal: true

module Presentation
  module Slide5
    def self.create
      parent = Engine::GameObject.new("Slide5")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "Cameras")
      parent.add_child Teapot.create(Vector[200, 0, 0], Vector[0, 0, 0], 200)

      parent.add_child Text.create(
        Vector[-400, 100, 0], Vector[0, 0, 0], 20,
        [
          "During rendering, points need to be transformed",
          "Vertices are local to the model being rendered",
          "First, the vertices are transformed into world space",
          "Then, they are transformed into the camera's local space",
          "Next they are transformed into clip space for rendering",
          "", "", "",
          "Perspective cameras are a bit different",
          "The further from the camera, the smaller things are",
          "This is done by using a 4th coordinate, w, in the vertex",
          "The vertex is divided by w to get the final position",
        ].join("\n")
      )

      parent
    end
  end
end
