class Gun < Engine::Component
  COOLDOWN = 0.1
  def update(delta_time)
    fire if Engine::Input.key_down?(GLFW::KEY_SPACE)
  end

  def fire
    return if @last_fire && Time.now - @last_fire < COOLDOWN
    @last_fire = Time.now
    pos = game_object.local_to_world_coordinate(0, -40)
    Engine::GameObject.new("Bullet",
                   x: pos[:x],
                   y: pos[:y],
                   rotation: game_object.rotation,
                   components: [Bullet.new]
    )
  end
end