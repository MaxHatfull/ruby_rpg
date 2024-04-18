class Gun < Component
  def update(delta_time)
    fire if Engine.key_down?(GLFW::KEY_SPACE)
  end

  def fire
    pos = game_object.local_to_world_coordinate(0, -40)
    GameObject.new("Bullet",
                   x: pos[:x],
                   y: pos[:y],
                   rotation: game_object.rotation,
                   components: [Bullet.new]
    )
  end
end