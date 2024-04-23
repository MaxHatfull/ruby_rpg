# frozen_string_literal: true

include Engine::Types

describe Vector do
  describe "#+" do
    it "adds two vectors" do
      v1 = Vector.new(1, 2)
      v2 = Vector.new(3, 4)
      result = v1 + v2
      expect(result.x).to eq(4)
      expect(result.y).to eq(6)
    end
  end

  describe "#-" do
    it "subtracts two vectors" do
      v1 = Vector.new(1, 2)
      v2 = Vector.new(3, 4)
      result = v1 - v2
      expect(result.x).to eq(-2)
      expect(result.y).to eq(-2)
    end
  end

  describe "#*" do
    it "multiplies a vector by a scalar" do
      v = Vector.new(1, 2)
      result = v * 2
      expect(result.x).to eq(2)
      expect(result.y).to eq(4)
    end
  end

  describe "#/" do
    it "divides a vector by a scalar" do
      v = Vector.new(2, 4)
      result = v / 2
      expect(result.x).to eq(1)
      expect(result.y).to eq(2)
    end
  end

  describe "#rotate" do
    it "rotates a vector by an angle" do
      v = Vector.new(1, 0)
      result = v.rotate(90)
      expect(result.x).to be_within(0.0001).of(0)
      expect(result.y).to be_within(0.0001).of(-1)
    end
  end

  describe "#magnitude" do
    it "calculates the magnitude of a vector" do
      v = Vector.new(3, 4)
      expect(v.magnitude).to eq(5)
    end
  end
end