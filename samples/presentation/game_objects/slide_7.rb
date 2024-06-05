# frozen_string_literal: true

module Presentation
  module Slide7
    def self.create
      parent = Engine::GameObject.new("Slide 7")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "UI")
      parent.add_child UIImage.create
      parent.add_child Text.create(
        Vector[-400, 100, 0], Vector[0, 0, 0], 20,
        [
          "UI rendering happens in screen space",
          "UI elements are rendered with no depth testing",
          "UI elements are rendered after the 3D scene",
          "UI elements are rendered with a different shader",
          "UI elements are rendered with a different camera",
        ].join("\n")
      )

      parent
    end
  end
end
