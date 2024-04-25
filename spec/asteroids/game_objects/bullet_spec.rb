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
      within_game_context(frame_duration: 0.1) do
        at(0) do
          Bullet.new(Vector.new(100, 100), 45)
        end
        at(1) do
          Engine::Screenshoter.screenshot do |screenshot|
            expect(screenshot).to match_screenshot_on_disk("spec/asteroids/game_objects/bullet_1.png")
          end
        end
        at(5) do
          Engine::Screenshoter.screenshot do |screenshot|
            expect(screenshot).to match_screenshot_on_disk("spec/asteroids/game_objects/bullet_2.png")
          end
        end
        at(30) do
          Engine::Screenshoter.screenshot do |screenshot|
            expect(screenshot).to match_screenshot_on_disk("spec/asteroids/game_objects/bullet_3.png")
          end
          Engine.stop_game
        end
      end
    end
  end
end
