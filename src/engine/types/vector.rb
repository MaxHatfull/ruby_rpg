module Engine::Types
  class Vector
    attr_accessor :x, :y, :z

    def initialize(x, y, z = 0)
      @x = x
      @y = y
      @z = z
    end

    def +(other)
      Vector.new(@x + other.x, @y + other.y, @z + other.z)
    end

    def -(other)
      Vector.new(@x - other.x, @y - other.y, @z - other.z)
    end

    def *(scalar)
      Vector.new(@x * scalar, @y * scalar, @z * scalar)
    end

    def /(scalar)
      Vector.new(@x / scalar, @y / scalar, @z / scalar)
    end

    def rotate(angle)
      angle = Math::PI * angle / 180.0
      x = @x * Math.cos(angle) + @y * Math.sin(angle)
      y = - @x * Math.sin(angle) + @y * Math.cos(angle)
      Vector.new(x, y, z)
    end

    def magnitude
      @magnitude ||= Math.sqrt(@x * @x + @y * @y + @z * @z)
    end

    def to_s
      "(#{@x}, #{@y}, #{@z})"
    end

    def eql?(other)
      @x == other.x && @y == other.y && @z == other.z
    end

    def ==(other)
      eql?(other)
    end
  end
end