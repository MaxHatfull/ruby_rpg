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
end
