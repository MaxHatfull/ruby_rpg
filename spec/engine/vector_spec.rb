# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe Engine::Vector do
  describe "#+" do
    it "adds two vectors" do
      v1 = Engine::Vector.new(1, 2)
      v2 = Engine::Vector.new(3, 4)
      result = v1 + v2
      expect(result.x).to eq(4)
      expect(result.y).to eq(6)
    end
  end

  describe "#-" do
    it "subtracts two vectors" do
      v1 = Engine::Vector.new(1, 2)
      v2 = Engine::Vector.new(3, 4)
      result = v1 - v2
      expect(result.x).to eq(-2)
      expect(result.y).to eq(-2)
    end
  end

  describe "#*" do
    it "multiplies a vector by a scalar" do
      v = Engine::Vector.new(1, 2)
      result = v * 2
      expect(result.x).to eq(2)
      expect(result.y).to eq(4)
    end
  end
end