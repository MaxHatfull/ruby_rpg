# frozen_string_literal: true

module ShrinkRacer
  module Text
    def self.create(pos, rotation, size, text)
      font_path = "assets/arial.ttf"
      Engine::GameObject.new(
        "Text",
        pos: pos,
        scale: Vector[1,1,1] * size,
        rotation: rotation,
        components: [
          Engine::Components::FontRenderer.new(Engine::Font.new(font_path), text)
        ])
    end
  end
end
