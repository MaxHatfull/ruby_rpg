# frozen_string_literal: true

describe Engine::ObjFile do
  context "without an mtl file" do
    let(:cube_obj) { File.expand_path(File.join(__dir__, "/cube")) }
    let(:obj_file) { Engine::ObjFile.new(cube_obj) }

    let(:cube_vertices) do
      [
        Vector[1.0, -1.0, -1.0],
        Vector[1.0, -1.0, 1.0],
        Vector[-1.0, -1.0, 1.0],
        Vector[-1.0, -1.0, -1.0],
        Vector[1.0, 1.0, -1.0],
        Vector[1.0, 1.0, 1.0],
        Vector[-1.0, 1.0, 1.0],
        Vector[-1.0, 1.0, -1.0]
      ]
    end

    let(:cube_normals) do
      [
        Vector[0.0, -1.0, 0.0],
        Vector[0.0, 1.0, 0.0],
        Vector[1.0, 0.0, 0.0],
        Vector[0.0, 0.0, 1.0],
        Vector[-1.0, 0.0, 0.0],
        Vector[0.0, 0.0, -1.0],
      ]
    end

    let(:cube_texture_coords) do
      [
        Vector[1, 0.333333],
        Vector[1, 0.666667],
        Vector[0.666667, 0.666667],
        Vector[0.666667, 0.333333],
        Vector[0.666667, 0.000000],
        Vector[0, 0.333333],
        Vector[0, 0],
        Vector[0.333333, 0.000000],
        Vector[0.333333, 1.000000],
        Vector[0, 1],
        Vector[0, 0.666667],
        Vector[0.333333, 0.333333],
        Vector[0.333333, 0.666667],
        Vector[1, 0],
      ]
    end

    let(:cube_vertex_indices) do
      [
        1, 2, 3,
        7, 6, 5,
        4, 5, 1,
        5, 6, 2,
        2, 6, 7,
        0, 3, 7,
        0, 1, 3,
        4, 7, 5,
        0, 4, 1,
        1, 5, 2,
        3, 2, 7,
        4, 0, 7
      ]
    end

    let(:cube_texture_indices) do
      [
        0, 1, 2,
        0, 3, 4,
        5, 6, 7,
        7, 4, 3,
        8, 9, 10,
        11, 12, 10,
        3, 0, 2,
        13, 0, 4,
        11, 5, 7,
        11, 7, 3,
        12, 8, 10,
        5, 11, 10
      ]
    end

    let(:cube_normal_indices) do
      [
        0, 0, 0,
        1, 1, 1,
        2, 2, 2,
        3, 3, 3,
        4, 4, 4,
        5, 5, 5,
        0, 0, 0,
        1, 1, 1,
        2, 2, 2,
        3, 3, 3,
        4, 4, 4,
        5, 5, 5
      ]
    end

    let(:cube_tangents) do
      [
        Vector[0, 0, 1], Vector[0, 0, 1], Vector[0, 0, 1],
        Vector[0, 0, -1], Vector[0, 0, -1], Vector[0, 0, -1],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[-1, 0, 0], Vector[-1, 0, 0], Vector[-1, 0, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[0, 0, 1], Vector[0, 0, 1], Vector[0, 0, 1],
        Vector[0, 0, -1], Vector[0, 0, -1], Vector[0, 0, -1],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[-1, 0, 0], Vector[-1, 0, 0], Vector[-1, 0, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
      ]
    end

    let(:vertex_data) do
      (0..35).map do |i|
        {
          vertex: cube_vertices[cube_vertex_indices[i]],
          texture_coord: cube_texture_coords[cube_texture_indices[i]],
          normal: cube_normals[cube_normal_indices[i]],
          tangent: cube_tangents[i],
          diffuse: Vector[1, 1, 1],
          specular: Vector[1, 1, 1],
          albedo: Vector[1, 1, 1],
        }
      end.map do |data|
        [
          data[:vertex][0], data[:vertex][1], data[:vertex][2],
          data[:texture_coord][0], data[:texture_coord][1],
          data[:normal][0], data[:normal][1], data[:normal][2],
          data[:tangent][0].to_f, data[:tangent][1].to_f, data[:tangent][2].to_f,
          data[:diffuse][0], data[:diffuse][1], data[:diffuse][2],
          data[:specular][0], data[:specular][1], data[:specular][2],
          data[:albedo][0], data[:albedo][1], data[:albedo][2],
        ]
      end.flatten
    end

    describe ".new" do
      it "creates an instance of ObjFile" do
        expect(Engine::ObjFile.new(cube_obj)).to be_an_instance_of(Engine::ObjFile)
      end
    end

    describe "#vertices" do
      it "returns an array of vertices" do
        obj_file.vertices.each_with_index do |v, i|
          expect(v).to eq(cube_vertices[i])
        end
        expect(obj_file.vertices.size).to eq(8)
      end
    end

    describe "#normals" do
      it "returns an array of normals" do
        obj_file.normals.each_with_index do |n, i|
          expect(n).to eq(cube_normals[i])
        end

        expect(obj_file.normals.size).to eq(6)
      end
    end

    describe "#texture_coords" do
      it "returns an array of texture_coords" do
        obj_file.texture_coords.each_with_index do |t, i|
          expect(t).to eq(cube_texture_coords[i])
        end

        expect(obj_file.texture_coords.size).to eq(14)
      end
    end

    describe "#vertex_indices" do
      it "returns an array of vertex_indices" do
        cube_vertex_indices.each_with_index do |i, j|
          expect(obj_file.vertex_indices[j]).to eq(i)
        end

        expect(obj_file.vertex_indices.size).to eq(36)
      end
    end

    describe "#texture_indices" do
      it "returns an array of texture_indices" do
        expect(obj_file.texture_indices).to eq(cube_texture_indices)
      end
    end

    describe "#normal_indices" do
      it "returns an array of normal_indices" do
        expect(obj_file.normal_indices).to eq(cube_normal_indices)
      end
    end

    describe "#vertex_data" do
      it "returns an array of vertex data" do
        obj_file.vertex_data.each_with_index do |v, i|
          expect(v).to be_within(0.0001).of(vertex_data[i])
        end

        expect(obj_file.vertex_data.size).to eq(
                                               36 * 3 +
                                                 36 * 2 +
                                                 36 * 3 +
                                                 36 * 3 +
                                                 36 * 3 +
                                                 36 * 3 +
                                                 36 * 3
                                             )
      end
    end

    describe "#index_data" do
      it "returns an array of indices" do
        expect(obj_file.index_data).to eq((0...36).to_a)
      end
    end
  end

  context "with an mtl file" do
    let(:cube_obj) { File.expand_path(File.join(__dir__, "/obj_with_mtl")) }
    let(:obj_file) { Engine::ObjFile.new(cube_obj) }

    let(:cube_vertices) do
      [
        Vector[1.0, -1.0, -1.0],
        Vector[1.0, -1.0, 1.0],
        Vector[-1.0, -1.0, 1.0],
        Vector[-1.0, -1.0, -1.0],
        Vector[1.0, 1.0, -1.0],
        Vector[1.0, 1.0, 1.0],
        Vector[-1.0, 1.0, 1.0],
        Vector[-1.0, 1.0, -1.0]
      ]
    end

    let(:cube_normals) do
      [
        Vector[0.0, -1.0, 0.0],
        Vector[0.0, 1.0, 0.0],
        Vector[1.0, 0.0, 0.0],
        Vector[0.0, 0.0, 1.0],
        Vector[-1.0, 0.0, 0.0],
        Vector[0.0, 0.0, -1.0],
      ]
    end

    let(:cube_texture_coords) do
      [
        Vector[1, 0.333333],
        Vector[1, 0.666667],
        Vector[0.666667, 0.666667],
        Vector[0.666667, 0.333333],
        Vector[0.666667, 0.000000],
        Vector[0, 0.333333],
        Vector[0, 0],
        Vector[0.333333, 0.000000],
        Vector[0.333333, 1.000000],
        Vector[0, 1],
        Vector[0, 0.666667],
        Vector[0.333333, 0.333333],
        Vector[0.333333, 0.666667],
        Vector[1, 0],
      ]
    end

    let(:cube_vertex_indices) do
      [
        1, 2, 3,
        7, 6, 5,
        4, 5, 1,
        5, 6, 2,
        2, 6, 7,
        0, 3, 7,
        0, 1, 3,
        4, 7, 5,
        0, 4, 1,
        1, 5, 2,
        3, 2, 7,
        4, 0, 7
      ]
    end

    let(:cube_texture_indices) do
      [
        0, 1, 2,
        0, 3, 4,
        5, 6, 7,
        7, 4, 3,
        8, 9, 10,
        11, 12, 10,
        3, 0, 2,
        13, 0, 4,
        11, 5, 7,
        11, 7, 3,
        12, 8, 10,
        5, 11, 10
      ]
    end

    let(:cube_normal_indices) do
      [
        0, 0, 0,
        1, 1, 1,
        2, 2, 2,
        3, 3, 3,
        4, 4, 4,
        5, 5, 5,
        0, 0, 0,
        1, 1, 1,
        2, 2, 2,
        3, 3, 3,
        4, 4, 4,
        5, 5, 5
      ]
    end

    let(:cube_tangents) do
      [
        Vector[0, 0, 1], Vector[0, 0, 1], Vector[0, 0, 1],
        Vector[0, 0, -1], Vector[0, 0, -1], Vector[0, 0, -1],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[-1, 0, 0], Vector[-1, 0, 0], Vector[-1, 0, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[0, 0, 1], Vector[0, 0, 1], Vector[0, 0, 1],
        Vector[0, 0, -1], Vector[0, 0, -1], Vector[0, 0, -1],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[-1, 0, 0], Vector[-1, 0, 0], Vector[-1, 0, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
        Vector[0, -1, 0], Vector[0, -1, 0], Vector[0, -1, 0],
      ]
    end

    let(:vertex_data) do
      vert_data = (0..35).map do |i|
        {
          vertex: cube_vertices[cube_vertex_indices[i]],
          texture_coord: cube_texture_coords[cube_texture_indices[i]],
          normal: cube_normals[cube_normal_indices[i]],
          tangent: cube_tangents[i],
          diffuse: Vector[1, 1, 1],
          specular: Vector[1, 1, 1],
          albedo: Vector[1, 1, 1],
        }
      end.map do |data|
        [
          data[:vertex][0], data[:vertex][1], data[:vertex][2],
          data[:texture_coord][0], data[:texture_coord][1],
          data[:normal][0], data[:normal][1], data[:normal][2],
          data[:tangent][0].to_f, data[:tangent][1].to_f, data[:tangent][2].to_f,
          data[:diffuse][0], data[:diffuse][1], data[:diffuse][2],
          data[:specular][0], data[:specular][1], data[:specular][2],
          data[:albedo][0], data[:albedo][1], data[:albedo][2],
        ]
      end.flatten

      vert_data[672] = 0.0
      vert_data[673] = 0.0
      vert_data[675] = 0.0
      vert_data[676] = 0.0
      vert_data[678] = 0.0
      vert_data[679] = 0.0

      vert_data[692] = 0.0
      vert_data[693] = 0.0
      vert_data[695] = 0.0
      vert_data[696] = 0.0
      vert_data[698] = 0.0
      vert_data[699] = 0.0

      vert_data[712] = 0.0
      vert_data[713] = 0.0
      vert_data[715] = 0.0
      vert_data[716] = 0.0
      vert_data[718] = 0.0
      vert_data[719] = 0.0

      vert_data
    end

    describe ".new" do
      it "creates an instance of ObjFile" do
        expect(Engine::ObjFile.new(cube_obj)).to be_an_instance_of(Engine::ObjFile)
      end
    end

    describe "#vertices" do
      it "returns an array of vertices" do
        obj_file.vertices.each_with_index do |v, i|
          expect(v).to eq(cube_vertices[i])
        end
        expect(obj_file.vertices.size).to eq(8)
      end
    end

    describe "#normals" do
      it "returns an array of normals" do
        obj_file.normals.each_with_index do |n, i|
          expect(n).to eq(cube_normals[i])
        end

        expect(obj_file.normals.size).to eq(6)
      end
    end

    describe "#texture_coords" do
      it "returns an array of texture_coords" do
        obj_file.texture_coords.each_with_index do |t, i|
          expect(t).to eq(cube_texture_coords[i])
        end

        expect(obj_file.texture_coords.size).to eq(14)
      end
    end

    describe "#vertex_indices" do
      it "returns an array of vertex_indices" do
        cube_vertex_indices.each_with_index do |i, j|
          expect(obj_file.vertex_indices[j]).to eq(i)
        end

        expect(obj_file.vertex_indices.size).to eq(36)
      end
    end

    describe "#texture_indices" do
      it "returns an array of texture_indices" do
        expect(obj_file.texture_indices).to eq(cube_texture_indices)
      end
    end

    describe "#normal_indices" do
      it "returns an array of normal_indices" do
        expect(obj_file.normal_indices).to eq(cube_normal_indices)
      end
    end

    describe "#vertex_data" do
      it "returns an array of vertex data" do
        obj_file.vertex_data.each_with_index do |v, i|
          expect(v).to be_within(0.0001).of(vertex_data[i])
        end

        expect(obj_file.vertex_data.size).to eq(
                                               36 * 3 +
                                                 36 * 2 +
                                                 36 * 3 +
                                                 36 * 3 +
                                                 36 * 3 +
                                                 36 * 3 +
                                                 36 * 3
                                             )
      end
    end

    describe "#index_data" do
      it "returns an array of indices" do
        expect(obj_file.index_data).to eq((0...36).to_a)
      end
    end
  end
end
