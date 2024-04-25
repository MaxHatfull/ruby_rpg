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
      frames = (1..5)

      within_game_context(frame_duration: 0.05) do
        at(0) do
          Explosion.new(Vector.new(100, 100))
        end
        frames.each do |frame|
          at(frame) do
            Engine::Screenshoter.screenshot do |screenshot|
              expect(screenshot).to match_screenshot_on_disk("spec/asteroids/game_objects/explosion_#{frame}.png")
            end
          end
        end
        at(frames.last + 1) do
          Engine.stop_game
        end
      end
    end
  end
end
