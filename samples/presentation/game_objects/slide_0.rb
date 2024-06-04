# frozen_string_literal: true

module Presentation
  module Slide0
    def self.create
      parent = Engine::GameObject.new("Slide0")
      parent.add_child Text.create(Vector[-100, 100, 0], Vector[0, 0, 0], 100, "Ruby RPG")
      parent.add_child Text.create(Vector[0, 0, 0], Vector[0, 0, 0], 50, "A Ruby Game Engine")
      parent
    end
  end
end
