# frozen_string_literal: true

require 'rspec'
require_relative "../../src/engine/engine"

describe Engine::Input do
  describe ".key_down?" do
    it "returns false when the key is not pressed" do
      expect(Engine::Input.key_down?(GLFW::KEY_A)).to eq(false)
    end

    it "returns true when the key is pressed" do
      Engine::Input._on_key_down(GLFW::KEY_A)
      expect(Engine::Input.key_down?(GLFW::KEY_A)).to eq(true)
    end
  end

  describe "._on_key_down" do
    it "sets the key to true" do
      Engine::Input._on_key_down(GLFW::KEY_A)
      expect(Engine::Input.key_down?(GLFW::KEY_A)).to eq(true)
    end

    it "closes the window when the escape key is pressed" do
      expect(Engine).to receive(:close)
      Engine::Input._on_key_down(GLFW::KEY_ESCAPE)
    end
  end

  describe "._on_key_up" do
    it "sets the key to false" do
      Engine::Input._on_key_down(GLFW::KEY_A)
      Engine::Input._on_key_up(GLFW::KEY_A)
      expect(Engine::Input.key_down?(GLFW::KEY_A)).to eq(false)
    end
  end
end