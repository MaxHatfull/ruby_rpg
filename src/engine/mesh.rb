# frozen_string_literal: true

module Engine
  class Mesh
    attr_reader :vertex_data, :index_data

    def initialize(mesh_file)
      vertex_file = File.join(ROOT, "_imported", mesh_file + ".vertex_data")
      index_file = File.join(ROOT, "_imported", mesh_file + ".index_data")
      @vertex_data = File.readlines(vertex_file).reject{|l| l == ""}.map(&:to_f)
      @index_data = File.readlines(index_file).reject{|l| l == ""}.map(&:to_i)
    end
  end
end
