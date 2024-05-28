# frozen_string_literal: true

module Engine
  class Path
    attr_reader :points

    def initialize(points)
      @points = points
    end

    def length
      points.length
    end

    def find_ear
      points.each_cons(3) do |triangle|
        return triangle, Path.new(points - [triangle[1]]) if is_ear?(triangle)
      end
    end

    def is_ear?(triangle)
      return false unless clockwise?(triangle)
      points.each do |point|
        next if triangle.include?(point)
        return false if point_in_triangle?(point, triangle)
      end
      true
    end

    private

    def anti_clockwise?(triangle)
      a, b, c = triangle
      (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0]) > 0
    end

    def clockwise?(triangle)
      !anti_clockwise?(triangle)
    end

    def point_in_triangle?(point, triangle)
      a, b, c = triangle
      pab = cross_product(point, a, b)
      pbc = cross_product(point, b, c)
      pca = cross_product(point, c, a)
      same_sign?(pab, pbc) && same_sign?(pbc, pca)
    end

    def cross_product(a, b, c)
      (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])
    end

    def same_sign?(a, b)
      a.negative? == b.negative?
    end
  end
end