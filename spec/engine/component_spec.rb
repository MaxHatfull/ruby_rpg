# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe Engine::Component do
  describe ".new" do
    it 'creates the component' do
      expect(Engine::Component.new).to be_an(Engine::Component)
    end
  end

  describe ".set_game_object" do
    it 'sets the game object' do
      component = Engine::Component.new
      object = Engine::GameObject.new
      component.set_game_object(object)

      expect(component.game_object).to eq(object)
    end
  end
end