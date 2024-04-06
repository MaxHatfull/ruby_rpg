# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe Engine do
  describe ".update" do
    it 'calls update on all objects' do
      expect(GameObject).to receive(:update_all)

      Engine.update
    end
  end
end