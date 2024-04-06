class Gun < Component
  def start
    Window.on(:mouse_down) { |event| fire if event.button == :left }
  end

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