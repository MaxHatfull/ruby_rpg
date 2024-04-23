# frozen_string_literal: true

include TestDriver
include Engine::Types

describe "Ship" do
  describe "When placed in the scene" do

    it "renders the ship" do
      file_name = "spec/asteroids/components/ship/ship.png"
      temp_file_name = "spec/asteroids/components/ship/temp/ship.png"

      within_game_context do
        at(0) do
          Engine::GameObject.new(
            "Ship",
            pos: Vector.new(100, 100),
            rotation: 90,
            components: [
              ShipEngine.new,
              Gun.new,
              Engine::Components::SpriteRenderer.new(
                Vector.new(-25, 25),
                Vector.new(25, 25),
                Vector.new(25, -25),
                Vector.new(-25, -25),
                Engine::Texture.new(File.join(__dir__, "../../../../samples/asteroids", "assets", "Player.png")).texture
              )
            ]
          )
        end
        at(10) do
          Engine::Screenshoter.screenshot(temp_file_name)
          expect(true).to eq(true)
          Engine.stop_game
        end
      end

      expect(temp_file_name).to match_screenshot(file_name)
      File.delete(temp_file_name) if File.exist?(temp_file_name)
    end

    it "renders the ship again" do
      file_name = "spec/asteroids/components/ship/ship2.png"
      temp_file_name = "spec/asteroids/components/ship/temp/ship2.png"

      within_game_context do
        at(0) do
          Engine::GameObject.new(
            "Ship",
            pos: Vector.new(100, 200),
            rotation: 45,
            components: [
              ShipEngine.new,
              Gun.new,
              Engine::Components::SpriteRenderer.new(
                Vector.new(-25, 25),
                Vector.new(25, 25),
                Vector.new(25, -25),
                Vector.new(-25, -25),
                Engine::Texture.new(File.join(__dir__, "../../../../samples/asteroids", "assets", "Player.png")).texture
              )
            ]
          )
        end
        at(5) do
          Engine::Screenshoter.screenshot(temp_file_name)
          expect(true).to eq(true)

          Engine.stop_game
        end
      end

      expect(temp_file_name).to match_screenshot(file_name)
      File.delete(temp_file_name) if File.exist?(temp_file_name)
    end
  end
end
