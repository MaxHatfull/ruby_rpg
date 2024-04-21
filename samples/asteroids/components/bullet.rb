class Bullet < Engine::Component
  SPEED = 500
  LIFE_SPAN = 2

  def update(delta_time)
    game_object.pos = game_object.local_to_world_coordinate(0, SPEED * delta_time)
    clamp_to_screen

    if Time.now - game_object.created_at > LIFE_SPAN
      game_object.destroy!
      return
    end

    Asteroid.asteroids.each do |asteroid|
      if (game_object.pos - asteroid.game_object.pos).magnitude < asteroid.size
        game_object.destroy!
        asteroid.destroy!
        Engine::GameObject.new(
          "Explosion",
          pos: game_object.pos,
          components: [
            Engine::SpriteRenderer.new(
              Engine::Vector.new(-100, 100),
              Engine::Vector.new(100, 100),
              Engine::Vector.new(100, -100),
              Engine::Vector.new(-100, -100),
              Engine::Texture.new(File.join(__dir__, "..", "assets", "boom.png")).texture,
              [
                { tl: Engine::Vector.new(1.0 / 6, 0), width: 1.0 / 6, height: 1 },
                { tl: Engine::Vector.new(2.0 / 6, 0), width: 1.0 / 6, height: 1 },
                { tl: Engine::Vector.new(3.0 / 6, 0), width: 1.0 / 6, height: 1 },
                { tl: Engine::Vector.new(4.0 / 6, 0), width: 1.0 / 6, height: 1 },
                { tl: Engine::Vector.new(5.0 / 6, 0), width: 1.0 / 6, height: 1 },
                { tl: Engine::Vector.new(0, 0), width: 1.0 / 6, height: 1 },
              ],
              20,
              false
            )
          ]
        )
        break
      end
    end
  end

  private

  def clamp_to_screen
    if game_object.x > Engine.screen_width
      game_object.x = 0
    elsif game_object.x < 0
      game_object.x = Engine.screen_width
    end
    if game_object.y > Engine.screen_height
      game_object.y = 0
    elsif game_object.y < 0
      game_object.y = Engine.screen_height
    end
  end
end
