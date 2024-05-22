# frozen_string_literal: true

module Engine
  class ObjFile
    def initialize(file_path)
      @file_path = file_path
      @file_data = File.readlines(file_path)
    end

    def vertices
      @vertices ||=
        @file_data.select { |line| line.start_with?("v ") }.map do |line|
          _, x, y, z = line.split(" ")
          Vector[x.to_f, y.to_f, z.to_f]
        end
    end

    def normals
      @normals ||=
        @file_data.select { |line| line.start_with?("vn ") }.map do |line|
          _, x, y, z = line.split(" ")
          Vector[x.to_f, y.to_f, z.to_f]
        end
    end

    def tangents
      @tangents ||=
        (0...vertex_indices.length).each_slice(3).map do |i1, i2, i3|
          vertex1 = vertices[vertex_indices[i1]]
          normal1 = normals[normal_indices[i1]]
          texture_coord1 = texture_coords[texture_indices[i1]]

          vertex2 = vertices[vertex_indices[i2]]
          normal2 = normals[normal_indices[i2]]
          texture_coord2 = texture_coords[texture_indices[i2]]

          vertex3 = vertices[vertex_indices[i3]]
          normal3 = normals[normal_indices[i3]]
          texture_coord3 = texture_coords[texture_indices[i3]]

          triangle_vertices = [vertex1, vertex2, vertex3]
          triangle_normals = [normal1, normal2, normal3]
          triangle_texture_coords = [texture_coord1, texture_coord2, texture_coord3]

          Engine::TangentCalculator.new(triangle_vertices, triangle_normals, triangle_texture_coords).calculate_tangents
        end.flatten(1)
    end

    def texture_coords
      @texture_coords ||=
        @file_data.select { |line| line.start_with?("vt ") }.map do |line|
          _, x, y = line.split(" ")
          Vector[x.to_f, y.to_f]
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
            texture_coord: texture_coords[texture_indices[i]],
            tangent: tangents[i]
          }
        end.map do |data|
          [
            data[:vertex][0], data[:vertex][1], data[:vertex][2],
            data[:texture_coord][0], data[:texture_coord][1],
            data[:normal][0], data[:normal][1], data[:normal][2],
            data[:tangent][0].to_f, data[:tangent][1].to_f, data[:tangent][2].to_f
          ]
        end.flatten
    end

    def index_data
      @index_data ||= (0...vertex_indices.length).map(&:to_i)
    end
  end
end