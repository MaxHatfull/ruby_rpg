class Ship < GameObject
  def initialize
    super

    @image = Triangle.new
    Window.on(:mouse_down) { |event| fire if event.button == :left }
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

  private

  def fire
    Bullet.new(x, y - 40)
    Sprite.new(
      __dir__ + "/boom.png",
      clip_width: 127,
      time: 75,
      x: x - 10,
      y: y - 40 - 10,
      width: 20,
      height: 20
    ).play
  end
end