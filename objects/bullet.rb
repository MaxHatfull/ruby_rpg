class Bullet < GameObject
  attr_reader :x, :y, :radius
  def initialize(x, y)
    @x = x
    @y = y
    @radius = 3
    @image = Circle.new(x: @x, y: @y, radius: @radius, color: 'white')
    @speed = 5
  end

  def update
    @y -= @speed
    @image.y = @y
  end
end