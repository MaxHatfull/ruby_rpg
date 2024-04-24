# frozen_string_literal: true

require_relative "../../../samples/asteroids/game_objects/ship"

include TestDriver
include Engine::Types

describe Ship do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "samples", "asteroids", "assets")))
  end

  describe "When placed in the scene" do
    it "renders the ship" do
      file_name = "spec/asteroids/game_objects/ship.png"

      within_game_context do
        at(0) do
          Ship.new(Vector.new(100, 100), 90)
        end
        at(10) do
          Engine::Screenshoter.screenshot do |screenshot|
            expect(screenshot).to match_screenshot_on_disk(file_name)
          end
          Engine.stop_game
        end
      end
    end

    it "renders the ship again" do
      file_name = "spec/asteroids/game_objects/ship2.png"

      within_game_context do
        at(0) do
          Ship.new(Vector.new(100, 200), 45)
        end
        at(5) do
          Engine::Screenshoter.screenshot do |screenshot|
            expect(screenshot).to match_screenshot_on_disk(file_name)
          end
          Engine.stop_game
        end
      end
    end
  end
end
