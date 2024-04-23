module Engine
  class Vector
    attr_accessor :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def +(other)
      Vector.new(@x + other.x, @y + other.y)
    end

    def -(other)
      Vector.new(@x - other.x, @y - other.y)
    end

    def *(scalar)
      Vector.new(@x * scalar, @y * scalar)
    end

    def /(scalar)
      Vector.new(@x / scalar, @y / scalar)
    end

    def rotate(angle)
      angle = Math::PI * angle / 180.0
      x = @x * Math.cos(angle) + @y * Math.sin(angle)
      y = - @x * Math.sin(angle) + @y * Math.cos(angle)
      Vector.new(x, y)
    end

    def magnitude
      @magnitude ||= Math.sqrt(@x * @x + @y * @y)
    end

    def to_s
      "(#{@x}, #{@y})"
    end
  end
end