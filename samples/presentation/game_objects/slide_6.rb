# frozen_string_literal: true

module Presentation
  module Slide6
    def self.create
      parent = Engine::GameObject.new("Slide 6")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "Text")
      parent.add_child Plane.create(Vector[250, 0, 0], Vector[0, 0, 0], 200)
      parent.add_child Text.create(
        Vector[-400, 100, 0], Vector[0, 0, 0], 20,
        [
          "Text rendering is quite difficult",
          "There is a pre-processing step to generate a texture atlas",
          "Each character is rendered to the texture",
          "For each character in the text, a quad is rendered",
          "The quad is positioned based on the string and character",
          "The quad is textured with the character",
          "The texture coordinates are adjusted to show the correct character",
        ].join("\n")
      )

      parent
    end
  end
end
