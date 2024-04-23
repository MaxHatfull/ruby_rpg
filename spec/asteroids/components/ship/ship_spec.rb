# frozen_string_literal: true

include TestDriver

describe "Ship" do
  describe "When placed in the scene" do
    it "renders the ship" do
      within_game_context do
        at(0) do
          Engine::GameObject.new(
            "Ship",
            pos: Engine::Vector.new(100, 100),
            rotation:  90,
            components: [
              ShipEngine.new,
              Gun.new,
              Engine::SpriteRenderer.new(
                Engine::Vector.new(-25, 25),
                Engine::Vector.new(25, 25),
                Engine::Vector.new(25, -25),
                Engine::Vector.new(-25, -25),
                Engine::Texture.new(File.join(__dir__, "../../../../samples/asteroids", "assets", "Player.png")).texture
              )
            ]
          )
        end
        at(10) do
          Engine::Screenshoter.screenshot("spec/asteroids/components/ship/ship.png")
          expect(true).to eq(true)
          Engine.stop_game
        end
      end
    end

    it "renders the ship again" do
      within_game_context do
        at(0) do
          @ship = Engine::GameObject.new(
            "Ship",
            pos: Engine::Vector.new(100, 200),
            rotation:  45,
            components: [
              ShipEngine.new,
              Gun.new,
              Engine::SpriteRenderer.new(
                Engine::Vector.new(-25, 25),
                Engine::Vector.new(25, 25),
                Engine::Vector.new(25, -25),
                Engine::Vector.new(-25, -25),
                Engine::Texture.new(File.join(__dir__, "../../../../samples/asteroids", "assets", "Player.png")).texture
              )
            ]
          )
        end
        at(5) do
          Engine::Screenshoter.screenshot("spec/asteroids/components/ship/ship2.png")
          expect(true).to eq(true)

          Engine.stop_game
        end
      end
    end
  end
end
