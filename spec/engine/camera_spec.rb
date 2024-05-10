# frozen_string_literal: true

describe Engine::Camera do
  describe ".instance" do
    it "returns the camera instance" do
      camera = Engine::Camera.new
      Engine::Camera.instance = camera
      expect(Engine::Camera.instance).to eq(camera)
    end
  end
end