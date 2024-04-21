class Gun < Engine::Component
  COOLDOWN = 0.1
  BULLET_SIZE = 5

  def start
    @bullet_texture = Engine::Texture.new(File.join(__dir__, "..", "..", "assets", "square.png")).texture
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
          Engine::Vector.new(-BULLET_SIZE / 2, BULLET_SIZE / 2),
          Engine::Vector.new(BULLET_SIZE / 2, BULLET_SIZE / 2),
          Engine::Vector.new(BULLET_SIZE / 2, -BULLET_SIZE / 2),
          Engine::Vector.new(-BULLET_SIZE / 2, -BULLET_SIZE / 2),
          @bullet_texture,
        )
      ]
    )
  end
end