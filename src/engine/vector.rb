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
  end
end