# frozen_string_literal: true

module Asteroids
  module OnscreenUI
    TEXT_SIZE = 50
    UI_Z_ORDER = 0

    def self.create
      parent = Engine::GameObject.new("UI Corners")
      parent.add_child Text.create(Vector[TEXT_SIZE / 2, WINDOW_HEIGHT - TEXT_SIZE / 2, UI_Z_ORDER], 0, TEXT_SIZE, "TL" )
      parent.add_child Text.create(Vector[TEXT_SIZE / 2, TEXT_SIZE / 2, UI_Z_ORDER], 0, TEXT_SIZE, "BL" )
      parent.add_child Text.create(Vector[WINDOW_WIDTH - TEXT_SIZE, WINDOW_HEIGHT - TEXT_SIZE / 2, UI_Z_ORDER], 0, TEXT_SIZE, "TR" )
      parent.add_child Text.create(Vector[WINDOW_WIDTH - TEXT_SIZE, TEXT_SIZE / 2, UI_Z_ORDER], 0, TEXT_SIZE, "BR" )

      ship_text = Text.create(Vector[340, 180, UI_Z_ORDER], 0, TEXT_SIZE, "SHIP" )
      ship_text.ui_renderers.first.update_string("Use space to fire, and arrows to fly!")

      parent
    end
  end
end
