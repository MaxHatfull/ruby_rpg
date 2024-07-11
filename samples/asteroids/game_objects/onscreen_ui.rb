# frozen_string_literal: true

module Asteroids
  module OnscreenUI
    TEXT_SIZE = 30
    UI_Z_ORDER = 0

    def self.create
      parent = Engine::GameObject.new("FPS Counter Container")
      parent.add_child Text.create(Vector[TEXT_SIZE / 2, Engine::Window.height - TEXT_SIZE / 2, UI_Z_ORDER], 0, TEXT_SIZE, "FPS: ", components: [ Asteroids::FpsComponent.new ])
    end
  end
end
