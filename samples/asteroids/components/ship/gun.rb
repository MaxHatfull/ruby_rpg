class Gun < Component
  def start
    Window.on(:key_down) { |event| fire if event.key == "space" }
  end

  def fire
    x, y = game_object.local_to_world_coordinate(0, -40)
    GameObject.new("Bullet",
                   x: x,
                   y: y,
                   rotation: game_object.rotation,
                   components: [Bullet.new]
    )
    Sprite.new(
      __dir__ + "/boom.png",
      clip_width: 127,
      time: 75,
      x: x - 10,
      y: y - 10,
      width: 20,
      height: 20
    ).play
  end
end