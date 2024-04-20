class Gun < Engine::Component
  COOLDOWN = 0.1

  def update(delta_time)
    fire if Engine::Input.key_down?(GLFW::KEY_SPACE)
  end

  def fire
    return if @last_fire && Time.now - @last_fire < COOLDOWN
    @last_fire = Time.now

    Engine::GameObject.new(
      "Bullet",
      pos: game_object.local_to_world_coordinate(0, 20),
      rotation: game_object.rotation,
      components: [
        Bullet.new,
        Engine::SpriteRenderer.new(
          { x: -5, y: -5 },
          { x: 5, y: -5 },
          { x: 5, y: 5 },
          { x: -5, y: 5 }
        )
      ]
    )
  end
end