# frozen_string_literal: true

describe Engine::Path do
  describe "is_ear?" do
    context "when the path is a triangle" do
      let(:path) do
        Engine::Path.new([
          Vector[0, 0],
          Vector[0, 1],
          Vector[1, 0]
        ])
      end

      it "returns true" do
        triangle = path.points
        expect(path.is_ear?(triangle)).to eq(true)
      end
    end

    context "when the path contains a concave point" do
      let(:path) do
        Engine::Path.new([
          Vector[0, 0],
          Vector[0, 1],
          Vector[0.5, 0.5],
          Vector[1, 1],
          Vector[1, 0]
        ])
      end

      it "returns false for the concave point" do
        triangle = [path.points[1], path.points[2], path.points[3]]
        expect(path.is_ear?(triangle)).to eq(false)
      end

      it "returns true for the convex points" do
        triangle1 = [path.points[0], path.points[1], path.points[2]]
        triangle2 = [path.points[2], path.points[3], path.points[4]]
        expect(path.is_ear?(triangle1)).to eq(true)
        expect(path.is_ear?(triangle2)).to eq(true)
      end

      context "when the path intersects a convex triangle" do
        let(:path) do
          Engine::Path.new([
            Vector[0, 0],
            Vector[0, 1],
            Vector[1, 1],
            Vector[1, 0],
            Vector[0.1, 0.9]
          ])
        end

        it "returns false for the intersected triangle" do
          triangle = [path.points[0], path.points[1], path.points[2]]
          expect(path.is_ear?(triangle)).to eq(false)
        end
      end
    end
  end
end