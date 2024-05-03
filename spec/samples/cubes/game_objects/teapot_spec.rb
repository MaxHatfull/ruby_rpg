# frozen_string_literal: true

require_relative "../../../../samples/cubes/game_objects/teapot"

include TestDriver

describe Cubes::Teapot do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "..", "samples", "cubes", "assets")))
  end

  describe "When placed in the scene" do
    it "renders the teapot" do
      within_game_context(load_path: "./samples/cubes") do
        at(0) { Cubes::Teapot.new(Vector[100, 100], Vector[43, 68, 38], 100) }
        at(1) { check_screenshot(__dir__ + "/teapot.png") }
        at(20) { Engine.stop_game }
      end
    end
  end
end
