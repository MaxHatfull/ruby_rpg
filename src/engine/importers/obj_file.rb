# frozen_string_literal: true

module Engine
  class ObjFile
    def initialize(file_path)
      @mesh_data = File.readlines(file_path + ".obj").map do |line|
        if line.start_with?("f ")
          vertices = line.split(" ")[1..-1]
          0.upto(vertices.length - 3).map do |i|
            ["f #{vertices[0]} #{vertices[i + 1]} #{vertices[i + 2]}"]
          end
        else
          line
        end
      end.flatten
      if File.exist?(file_path + ".mtl")
        @mtl_data = File.readlines(file_path + ".mtl").map(&:chomp)
      else
        @mtl_data = []
      end
    end

    def vertices
      @vertices ||=
        @mesh_data.select { |line| line.start_with?("v ") }.map do |line|
          _, x, y, z = line.split(" ")
          Vector[x.to_f, y.to_f, z.to_f]
        end
    end

    def normals
      @normals ||=
        @mesh_data.select { |line| line.start_with?("vn ") }.map do |line|
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
        @mesh_data.select { |line| line.start_with?("vt ") }.map do |line|
          _, x, y = line.split(" ")
          Vector[x.to_f, y.to_f]
        end
    end

    def vertex_indices
      @vertex_indices ||=
        @mesh_data.select { |line| line.start_with?("f ") }.map do |line|
          _, v1, v2, v3 = line.split(" ")
          v1, v2, v3 = [v1, v2, v3].map { |v| v.split("/").first.to_i }
          [v1 - 1, v2 - 1, v3 - 1]
        end.flatten
    end

    def texture_indices
      @texture_indices ||=
        @mesh_data.select { |line| line.start_with?("f ") }.map do |line|
          _, v1, v2, v3 = line.split(" ")
          v1, v2, v3 = [v1, v2, v3].map { |v| v.split("/")[1].to_i }
          [v1 - 1, v2 - 1, v3 - 1]
        end.flatten
    end

    def normal_indices
      @normal_indices ||=
        @mesh_data.select { |line| line.start_with?("f ") }.map do |line|
          _, v1, v2, v3 = line.split(" ")
          v1, v2, v3 = [v1, v2, v3].map { |v| v.split("/")[2].to_i }
          [v1 - 1, v2 - 1, v3 - 1]
        end.flatten
    end

    def material_names
      @material_names ||=
        begin
          current_material = nil
          names = []
          @mesh_data.each do |line|
            if line.start_with?("usemtl ")
              _, material_name = line.split(" ")
              current_material = material_name
            elsif line.start_with?("f ")
              names << current_material
              names << current_material
              names << current_material
            end
          end
          names
        end
    end

    def materials
      @materials ||=
        begin
          current_material = nil
          @mtl_data.each_with_object({}) do |line, materials|
            if line.start_with?("newmtl ")
              _, material_name = line.split(" ")
              current_material = material_name
              materials[material_name] = {}
            elsif line.start_with?("Kd ")
              _, r, g, b = line.split(" ")
              materials[current_material][:diffuse] = Vector[r.to_f, g.to_f, b.to_f]
            elsif line.start_with?("Ks ")
              _, r, g, b = line.split(" ")
              materials[current_material][:specular] = Vector[r.to_f, g.to_f, b.to_f]
            elsif line.start_with?("Ka ")
              _, r, g, b = line.split(" ")
              materials[current_material][:albedo] = Vector[r.to_f, g.to_f, b.to_f]
            end
          end
        end
    end

    def vertex_data
      @vertex_data ||=
        (0...vertex_indices.length).map do |i|
          {
            vertex: vertices[vertex_indices[i]],
            normal: normals[normal_indices[i]],
            texture_coord: texture_coords[texture_indices[i]],
            tangent: tangents[i],
            diffuse: materials.dig(material_names[i], :diffuse) || Vector[1, 1, 1],
            specular: materials.dig(material_names[i], :specular) || Vector[1, 1, 1],
            albedo: materials.dig(material_names[i], :albedo) || Vector[1, 1, 1],
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

    def index_data
      @index_data ||= (0...vertex_indices.length).map(&:to_i)
    end
  end
end
