# frozen_string_literal: true

require_relative "../../../../src/engine/engine"

include TestDriver

describe "Ship" do
  describe "When placed in the scene" do
    xit "renders the ship" do
      within_game_context do
        at(0) do
          GameObject.new("Ship", x: 100, y: 100,
                         components: [ShipEngine.new, Gun.new]
          )
        end
        at(1) do
          Engine.screenshot("spec/asteroids/components/ship/ship.png")
          expect(true).to eq(true)
          Engine.close
        end
      end
    end

    xit "renders the ship again" do
      within_game_context do
        at(0) do
          GameObject.new("Ship", x: 100, y: 100,
                         components: [ShipEngine.new, Gun.new]
          )
        end
        at(1) do
          Engine.screenshot("spec/asteroids/components/ship/ship2.png")
          expect(true).to eq(true)
          Engine.close
        end
      end
    end
  end
end
