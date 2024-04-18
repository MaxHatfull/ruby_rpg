# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe Engine::GameObject do
  describe ".new" do
    it 'creates the object' do
      expect(Engine::GameObject.new).to be_a(Engine::GameObject)
    end

    it "sets the position of the object" do
      object = Engine::GameObject.new(x: 10, y: 20)

      expect(object.x).to eq(10)
      expect(object.y).to eq(20)
    end

    it "sets the rotation of the object" do
      object = Engine::GameObject.new(rotation: 90)

      expect(object.rotation).to eq(90)
    end

    it "sets the name of the object" do
      object = Engine::GameObject.new("Test Object")

      expect(object.name).to eq("Test Object")
    end

    it "sets the components of the object" do
      component = Engine::Component.new
      object = Engine::GameObject.new(components: [component])

      expect(object.components).to eq([component])
    end

    it "calls start on all components" do
      component = Engine::Component.new
      expect(component).to receive(:start)
      Engine::GameObject.new(components: [component])
    end

    it "sets the game object on all components" do
      component = Engine::Component.new
      object = Engine::GameObject.new(components: [component])

      expect(component.game_object).to eq(object)
    end

    it "adds the object to the list of objects" do
      object = Engine::GameObject.new

      expect(Engine::GameObject.objects).to include(object)
    end
  end

  describe ".update_all" do
    let(:component) { Engine::Component.new }
    let!(:object) { Engine::GameObject.new(components: [component]) }

    it 'calls update on all components' do
      expect(component).to receive(:update)

      Engine::GameObject.update_all(0.1)
    end
  end
end
