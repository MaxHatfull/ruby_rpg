# frozen_string_literal: true

module Presentation
  module Slide8
    def self.create
      parent = Engine::GameObject.new("Slide 8")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "What's next?")
      parent.add_child Text.create(
        Vector[-400, 100, 0], Vector[0, 0, 0], 20,
        [
          "Editor",
          "Becoming a real Gem",
          "Physics",
          "Particles",
          "Networking",
          "Sound",
          "...and so much more!"
        ].join("\n")
      )

      parent
    end
  end
end
