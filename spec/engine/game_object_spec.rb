# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe GameObject do
  describe ".new" do
    it 'creates the object' do
      expect(GameObject.new).to be_a(GameObject)
    end
  end

  describe ".update_all" do
    let(:object) { GameObject.new }

    it 'calls update on all objects' do
      expect(object).to receive(:update)

      GameObject.update_all
    end
  end

  describe "#update for a subclass of GameObject" do
    class TestObject < GameObject
      attr_reader :updated
      def update
        @updated = true
      end
    end
    let!(:object) { TestObject.new }

    it 'calls update on the object' do
      GameObject.update_all

      expect(object.updated).to be true
    end
  end
end
