# frozen_string_literal: true

describe Engine::TangentCalculator do
  describe "#calculate_tangents" do
    subject(:tangents) { Engine::TangentCalculator.new(vertices, normals, texture_coords).calculate_tangents }

    context "with simple vertices, normals and texture coordinates" do
      let(:vertices) { [Vector[0, 0, 0], Vector[1, 0, 0], Vector[0, 0, 1]] }
      let(:normals) { [Vector[0, 1, 0], Vector[0, 1, 0], Vector[0, 1, 0]] }
      let(:texture_coords) { [Vector[0, 0], Vector[1, 0], Vector[0, 1]] }

      it { is_expected.to eq [Vector[1, 0, 0], Vector[1, 0, 0], Vector[1, 0, 0]] }
    end

    context "with vertices that are not centered around the origin" do
      let(:vertices) { [Vector[1, 0, 0], Vector[2, 0, 0], Vector[1, 0, 1]] }
      let(:normals) { [Vector[0, 1, 0], Vector[0, 1, 0], Vector[0, 1, 0]] }
      let(:texture_coords) { [Vector[0, 0], Vector[1, 0], Vector[0, 1]] }

      it { is_expected.to eq [Vector[1, 0, 0], Vector[1, 0, 0], Vector[1, 0, 0]] }
    end

    context "with vertices in the xy plane" do
      let(:vertices) { [Vector[0, 0, 0], Vector[1, 0, 0], Vector[0, 1, 0]] }
      let(:normals) { [Vector[0, 0, 1], Vector[0, 0, 1], Vector[0, 0, 1]] }
      let(:texture_coords) { [Vector[0, 0], Vector[1, 0], Vector[0, 1]] }

      it { is_expected.to eq [Vector[1, 0, 0], Vector[1, 0, 0], Vector[1, 0, 0]] }
    end

    context "with vertices in the yz plane" do
      let(:vertices) { [Vector[0, 0, 0], Vector[0, 1, 0], Vector[0, 0, 1]] }
      let(:normals) { [Vector[1, 0, 0], Vector[1, 0, 0], Vector[1, 0, 0]] }
      let(:texture_coords) { [Vector[0, 0], Vector[1, 0], Vector[0, 1]] }

      it { is_expected.to eq [Vector[0, 1, 0], Vector[0, 1, 0], Vector[0, 1, 0]] }
    end

    context "when the normals are not perpendicular to the triangle" do
      let(:vertices) { [Vector[0, 0, 0], Vector[1, 0, 0], Vector[0, 0, 1]] }
      let(:normals) { [Vector[-1, 1, 0].normalize, Vector[0, 1, 0], Vector[0, 1, 0]] }
      let(:texture_coords) { [Vector[0, 0], Vector[1, 0], Vector[0, 1]] }

      it "gives the correct tangents" do
        expect(tangents[0]).to be_vector(Vector[1, 1, 0].normalize)
        expect(tangents[1]).to be_vector(Vector[1, 0, 0])
        expect(tangents[2]).to be_vector(Vector[1, 0, 0])
      end
    end
  end
end