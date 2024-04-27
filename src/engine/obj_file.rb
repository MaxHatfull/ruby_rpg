# frozen_string_literal: true

module Engine
  class ObjFile
    include Types

    def initialize(file_path)
      @file_path = file_path
      @file_data = File.readlines(file_path)
    end

    def vertices
      @vertices ||=
        @file_data.select { |line| line.start_with?("v ") }.map do |line|
          _, x, y, z = line.split(" ")
          Vector.new(x.to_f, y.to_f, z.to_f)
        end
    end

    def normals
      @normals ||=
        @file_data.select { |line| line.start_with?("vn ") }.map do |line|
          _, x, y, z = line.split(" ")
          Vector.new(x.to_f, y.to_f, z.to_f)
        end
    end

    def texture_coords
      @texture_coords ||=
        @file_data.select { |line| line.start_with?("vt ") }.map do |line|
          _, x, y = line.split(" ")
          Vector.new(x.to_f, y.to_f)
        end
    end

    def vertex_indices
      @vertex_indices ||=
        @file_data.select { |line| line.start_with?("f ") }.map do |line|
          _, v1, v2, v3 = line.split(" ")
          v1, v2, v3 = [v1, v2, v3].map { |v| v.split("/").first.to_i }
          [v1 - 1, v2 - 1, v3 - 1]
        end.flatten
    end

    def texture_indices
      @texture_indices ||=
        @file_data.select { |line| line.start_with?("f ") }.map do |line|
          _, v1, v2, v3 = line.split(" ")
          v1, v2, v3 = [v1, v2, v3].map { |v| v.split("/")[1].to_i }
          [v1 - 1, v2 - 1, v3 - 1]
        end.flatten
    end

    def normal_indices
      @normal_indices ||=
        @file_data.select { |line| line.start_with?("f ") }.map do |line|
          _, v1, v2, v3 = line.split(" ")
          v1, v2, v3 = [v1, v2, v3].map { |v| v.split("/")[2].to_i }
          [v1 - 1, v2 - 1, v3 - 1]
        end.flatten
    end

    def vertex_data
      @vertex_data ||=
        (0...vertex_indices.length).map do |i|
          {
            vertex: vertices[vertex_indices[i]],
            normal: normals[normal_indices[i]],
            texture_coord: texture_coords[texture_indices[i]]
          }
        end.map do |data|
          [
            data[:vertex].x, data[:vertex].y, data[:vertex].z,
            data[:texture_coord].x, data[:texture_coord].y,
            data[:normal].x, data[:normal].y, data[:normal].z
          ]
        end.flatten
    end

    def index_data
      @index_data ||= (0...vertex_indices.length).map(&:to_i)
    end
  end
end