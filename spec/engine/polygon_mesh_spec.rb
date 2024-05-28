# frozen_string_literal: true

describe Engine::PolygonMesh do
  describe "#vertex_data" do
    it "returns the vertex data" do
      points = [Vector[0.0, 0.0], Vector[0.0, 1.0], Vector[1.0, 1.0], Vector[1.0, 0.0]]
      uvs = [[0, 0], [0, 1], [1, 1], [1, 0]]
      mesh = described_class.new(points, uvs)
      expect(mesh.vertex_data)
        .to eq(
              [
                1.0, 1.0, 0.0, 1, 1,
                0.0, 1.0, 0.0, 0, 1,
                0.0, 0.0, 0.0, 0, 0,

                1.0, 0.0, 0.0, 1, 0,
                1.0, 1.0, 0.0, 1, 1,
                0.0, 0.0, 0.0, 0, 0
              ]
            )
    end
  end
end