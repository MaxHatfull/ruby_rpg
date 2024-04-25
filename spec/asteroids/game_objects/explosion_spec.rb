# frozen_string_literal: true

require_relative "../../../samples/asteroids/game_objects/explosion"

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
    it "renders the explosion" do
      within_game_context(frame_duration: 0.05) do
        at(0) { Explosion.new(Vector.new(100, 100)) }
        till(5) { check_screenshot("spec/asteroids/game_objects/explosion_#{current_tick}.png") }
        at(6) { Engine.stop_game }
      end
    end
  end
end
