# frozen_string_literal: true

module Presentation
  module Slide1
    def self.create
      parent = Engine::GameObject.new("Slide2")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "What is Ruby RPG?")
      parent.add_child Text.create(Vector[-350, 100, 0], Vector[0, 0, 0], 30, "- A game engine\n- An entity component system\n- Testable game development\n- Rednered using OpenGL")
      parent.add_child Text.create(
        Vector[-350, -50, 0], Vector[0, 0, 0], 30,
        [
          "The world is built of GameObjects",
          "- Components are added to GameObjects",
          "- Components are updated every frame",
          "- Repeat",
          "GameObjects hold the position, rotation, and scale of the object",
          "- GameObjects can have children, which are relative to the parent",
        ].join("\n"))
      parent
    end
  end
end
