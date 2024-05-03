# frozen_string_literal: true

require_relative "../../../../samples/asteroids/game_objects/explosion"

include TestDriver

describe Asteroids::Explosion do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "..", "samples", "asteroids", "assets")))
  end

  describe "When placed in the scene" do
    it "renders the explosion" do
      within_game_context(frame_duration: 0.05, load_path: "./samples/asteroids") do
        at(0) { Asteroids::Explosion.new(Vector[100, 100]) }
        till(5) { check_screenshot(File.join(__dir__, "explosion_#{current_tick}.png")) }
        at(6) { Engine.stop_game }
      end
    end
  end
end