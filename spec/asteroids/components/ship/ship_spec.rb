# frozen_string_literal: true

require_relative "../../../../src/engine/engine"

describe "Ship" do
  describe "When placed in the scene" do
    it "renders the ship" do
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
  end
end

class TestDriver < Component
  include RSpec::Matchers

  def initialize(&block)
    @instructions = block
    @timed_instructions = {}
    @tick = 0
    instance_eval(&block)
  end

  def update
    if @timed_instructions[@tick]
      @timed_instructions[@tick].call
    end

    @tick += 1
  end

  def at(tick, &block)
    @timed_instructions[tick] = block
  end
end

def within_game_context(&block)
  Engine.start(base_dir: "./samples/asteroids", title: 'Ruby RPG', width: 1920, height: 1080, background: 'navy') do
    GameObject.new("Test Driver", components: [TestDriver.new(&block)])
  end
end
