# frozen_string_literal: true

require_relative "../../../samples/asteroids/game_objects/bullet"

include TestDriver
include Engine::Types

describe Exception do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "samples", "asteroids", "assets")))
  end

  after do
    Engine.stop_game
  end

  describe "When placed in the scene" do
    it "renders the moving bullet" do
      within_game_context do
        at(0) { Bullet.new(Vector.new(100, 100), 45) }
        at(1) { check_screenshot("spec/asteroids/game_objects/bullet_1.png") }
        at(5) { check_screenshot("spec/asteroids/game_objects/bullet_2.png") }
        at(30) do
          check_screenshot("spec/asteroids/game_objects/bullet_3.png")
          Engine.stop_game
        end
      end
    end
  end
end
