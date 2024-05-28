# frozen_string_literal: true

module Engine
  class PolygonMesh
    attr_reader :points

    def initialize(points)
      @points = points
    end

    def vertex_data
      @vertex_data ||= generate_vertex_data
    end

    def index_data
      @index_data ||= (0..vertices.length - 1).to_a
    end

    private

    def generate_vertex_data
      vertices.map do |point|
        [point[0], point[1], 0.0]
      end.flatten
    end

    def vertices
      @vertices ||=
        begin
          path = Path.new(@points)
          vertices = []
          until path.length == 3
            ear, new_path = path.find_ear
            vertices << ear
            path = new_path
          end
          vertices += path.points
          vertices.flatten(1)
        end
    end
  end
end