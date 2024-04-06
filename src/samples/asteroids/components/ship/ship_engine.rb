class Ship < Component
  def start
    @image = Triangle.new
  end

  def update
    game_object.x = Window.mouse_x
    game_object.y = Window.mouse_y

    x, y = game_object.x, game_object.y
    @image.x1 = x
    @image.y1 = y - 40
    @image.x2 = x - 20
    @image.y2 = y + 40
    @image.x3 = x + 20
    @image.y3 = y + 40
  end
end