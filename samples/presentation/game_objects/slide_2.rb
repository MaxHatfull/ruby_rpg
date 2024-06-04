# frozen_string_literal: true

module Presentation
  module Slide2
    def self.create
      parent = Engine::GameObject.new("Slide1")
      parent.add_child Text.create(Vector[-350, 200, 0], Vector[0, 0, 0], 100, "What is OpenGL?")
      parent.add_child Text.create(Vector[-300, 100, 0], Vector[0, 0, 0], 50, "- A graphics API, not a library\n- A state machine\n- A render pipeline")
      parent
    end
  end
end
