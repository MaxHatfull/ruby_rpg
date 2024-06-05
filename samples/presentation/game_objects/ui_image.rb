# frozen_string_literal: true

module Presentation
  module UIImage
    def self.create
      Engine::GameObject.new(
        "UI image",
        pos: Vector[0, 0, 0], rotation: Vector[0, 0, 0], scale: Vector[1, 1, 1],
        components: [
          Engine::Components::UISpriteRenderer.new(
            Vector[1500, 700], Vector[1900, 700], Vector[1900, 300], Vector[1500, 300],
            Engine::Texture.for(ASSETS_DIR + "/rainbow.png").texture
          )
        ])
    end
  end
end
