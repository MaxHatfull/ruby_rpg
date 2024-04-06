# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe GameObject do
  describe ".new" do
    it 'creates the object' do
      expect(GameObject.new).to be_a(GameObject)
    end

    it "sets the position of the object" do
      object = GameObject.new(x: 10, y: 20)

      expect(object.x).to eq(10)
      expect(object.y).to eq(20)
    end

    it "sets the name of the object" do
      object = GameObject.new("Test Object")

      expect(object.name).to eq("Test Object")
    end

    it "sets the components of the object" do
      component = Component.new
      object = GameObject.new(components: [component])

      expect(object.components).to eq([component])
    end

    it "calls start on all components" do
      component = Component.new
      expect(component).to receive(:start)
      GameObject.new(components: [component])
    end

    it "sets the game object on all components" do
      component = Component.new
      object = GameObject.new(components: [component])

      expect(component.game_object).to eq(object)
    end

    it "adds the object to the list of objects" do
      object = GameObject.new

      expect(GameObject.objects).to include(object)
    end
  end

  describe ".update_all" do
    let(:component) { Component.new }
    let!(:object) { GameObject.new(components: [component]) }

    it 'calls update on all components' do
      expect(component).to receive(:update)

      GameObject.update_all
    end
  end
end
