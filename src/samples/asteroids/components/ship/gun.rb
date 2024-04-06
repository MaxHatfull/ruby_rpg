class Ship < Component
  def initialize
    super

    @image = Triangle.new
    Window.on(:mouse_down) { |event| fire if event.button == :left }
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

  private

  def fire
    GameObject.new("Bullet",
                   x: game_object.x,
                   y: game_object.y - 40,
                   components: [Bullet.new]
    )
    Sprite.new(
      __dir__ + "/boom.png",
      clip_width: 127,
      time: 75,
      x: game_object.x - 10,
      y: game_object.y - 40 - 10,
      width: 20,
      height: 20
    ).play
  end
end