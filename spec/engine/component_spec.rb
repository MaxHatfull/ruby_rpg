# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe Component do
  describe ".new" do
    it 'creates the component' do
      expect(Component.new).to be_a(Component)
    end
  end

  describe ".set_game_object" do
    it 'sets the game object' do
      component = Component.new
      object = GameObject.new
      component.set_game_object(object)

      expect(component.game_object).to eq(object)
    end
  end
end