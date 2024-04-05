class Ship < GameObject
  def initialize
    @image = Triangle.new
  end

  def update
    @x = Window.mouse_x
    @y = Window.mouse_y
    @image.x1 = x
    @image.y1 = y - 40
    @image.x2 = x - 20
    @image.y2 = y + 40
    @image.x3 = x + 20
    @image.y3 = y + 40
  end
end