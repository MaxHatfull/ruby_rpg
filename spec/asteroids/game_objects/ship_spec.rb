# frozen_string_literal: true

require_relative "../../../samples/asteroids/game_objects/ship"

include TestDriver
include Engine::Types

describe Ship do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "samples", "asteroids", "assets")))
  end

  after do
    Engine.stop_game
  end

  describe "When placed in the scene" do
    it "renders the ship" do
      within_game_context do
        at(0) { Ship.new(Vector.new(100, 100), 90) }
        at(1) { check_screenshot(__dir__ + "/ship_1.png") }
        at(2) { check_screenshot(__dir__ + "/ship_2.png") }
        till(5) { press(GLFW::KEY_LEFT) }
        at(6) { check_screenshot(__dir__ + "/ship_3.png") }
        till(10) { press(GLFW::KEY_RIGHT) }
        at(11) { check_screenshot(__dir__ + "/ship_4.png") }
        till(15) { press(GLFW::KEY_UP) }
        at(16) { check_screenshot(__dir__ + "/ship_5.png") }
        at(20) do
          check_screenshot(__dir__ + "/ship_6.png")
          Engine.stop_game
        end
      end
    end
  end
end
