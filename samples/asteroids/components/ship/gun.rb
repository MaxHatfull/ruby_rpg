class Gun < Engine::Component
  COOLDOWN = 0.1

  def start
    @bullet_texture = Engine::Texture.new(File.join(__dir__, "boom.png")).texture
  end

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
          { x: -50, y: -50 },
          { x: 50, y: -50 },
          { x: 50, y: 50 },
          { x: -50, y: 50 },
          @bullet_texture,
          [
            { tl: { x: 1.0 / 6, y: 0 }, width: 1.0 / 6, height: 1 },
            { tl: { x: 2.0 / 6, y: 0 }, width: 1.0 / 6, height: 1 },
            { tl: { x: 3.0 / 6, y: 0 }, width: 1.0 / 6, height: 1 },
            { tl: { x: 4.0 / 6, y: 0 }, width: 1.0 / 6, height: 1 },
            { tl: { x: 5.0 / 6, y: 0 }, width: 1.0 / 6, height: 1 },
            { tl: { x: 0, y: 0 }, width: 1.0 / 6, height: 1 }
          ],
          10,
          false
        )
      ]
    )
  end
end