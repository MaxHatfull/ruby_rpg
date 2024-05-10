# frozen_string_literal: true

describe Engine::Components::OrthographicCamera do
  describe "#matrix" do
    it "returns the correct matrix with no position or rotation" do
      camera = Engine::Components::OrthographicCamera.new(width: 10, height: 10, far: 10)
      Engine::GameObject.new("Camera",
                             pos: Vector[0, 0, 0],
                             rotation: Vector[0, 0, 0],
                             scale: Vector[1, 1, 1],
                             components: [camera]
      )

      expect(camera.matrix).to eq(Matrix[
                                    [0.2, 0, 0, 0],
                                    [0, 0.2, 0, 0],
                                    [0, 0, -0.1, 0],
                                    [0, 0, -1, 1]
                                  ])
    end

    it "returns the correct matrix when the camera is at x = 5" do
      camera = Engine::Components::OrthographicCamera.new(width: 10, height: 10, far: 10)
      Engine::GameObject.new("Camera",
                             pos: Vector[5, 0, 0],
                             rotation: Vector[0, 0, 0],
                             scale: Vector[1, 1, 1],
                             components: [camera]
      )

      expect(camera.matrix).to eq(Matrix[
                                    [0.2, 0, 0, 0],
                                    [0, 0.2, 0, 0],
                                    [0, 0, -0.1, 0],
                                    [-1, 0, -1, 1]
                                  ])
    end

    it "returns the correct matrix when the camera is at y = 5" do
      camera = Engine::Components::OrthographicCamera.new(width: 10, height: 10, far: 10)
      Engine::GameObject.new("Camera",
                             pos: Vector[0, 5, 0],
                             rotation: Vector[0, 0, 0],
                             scale: Vector[1, 1, 1],
                             components: [camera]
      )

      expect(camera.matrix).to eq(Matrix[
                                    [0.2, 0, 0, 0],
                                    [0, 0.2, 0, 0],
                                    [0, 0, -0.1, 0],
                                    [0, -1, -1, 1]
                                  ])
    end

    it "returns the correct matrix when the camera is at z = 5" do
      camera = Engine::Components::OrthographicCamera.new(width: 10, height: 10, far: 10)
      Engine::GameObject.new("Camera",
                             pos: Vector[0, 0, 5],
                             rotation: Vector[0, 0, 0],
                             scale: Vector[1, 1, 1],
                             components: [camera]
      )

      expect(camera.matrix).to eq(Matrix[
                                    [0.2, 0, 0, 0],
                                    [0, 0.2, 0, 0],
                                    [0, 0, -0.1, 0],
                                    [0, 0, -0.5, 1]
                                  ])
    end

    it "returns the correct matrix when the camera is rotated 90 degrees around the x-axis" do
      camera = Engine::Components::OrthographicCamera.new(width: 10, height: 10, far: 10)
      Engine::GameObject.new("Camera",
                             pos: Vector[0, 0, 0],
                             rotation: Vector[90, 0, 0],
                             scale: Vector[1, 1, 1],
                             components: [camera]
      )
    end
  end
end