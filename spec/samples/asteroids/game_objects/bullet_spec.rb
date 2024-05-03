# frozen_string_literal: true

require_relative "../../../../samples/asteroids/game_objects/bullet"

include TestDriver

describe Asteroids::Bullet do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "..", "samples", "asteroids", "assets")))
  end

  describe "When placed in the scene" do
    it "renders the moving bullet" do
      within_game_context(load_path: "./samples/asteroids") do
        at(0) { Asteroids::Bullet.new(Vector[100, 100], 45) }
        at(1) { check_screenshot(File.join(__dir__, "bullet_1.png")) }
        at(5) { check_screenshot(File.join(__dir__, "bullet_2.png")) }
        at(30) do
          check_screenshot(File.join(__dir__, "bullet_3.png"))
          Engine.stop_game
        end
      end
    end
  end
end
