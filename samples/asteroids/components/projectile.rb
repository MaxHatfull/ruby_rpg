class Projectile < Engine::Component
  def update(delta_time)
    AsteroidComponent.asteroids.each do |asteroid|
      if (game_object.pos - asteroid.game_object.pos).magnitude < asteroid.size
        game_object.destroy!
        asteroid.destroy!
        play_explosion_effect
        spawn_asteroids(asteroid.size / 2) if asteroid.size > 50
        break
      end
    end
  end

  private

  def spawn_asteroids(size)
    3.times do
      Asteroid.new(
        game_object.pos + Vector.new(rand(-50..50), rand(-50..50)),
        rand(360),
        size
      )
    end
  end

  def play_explosion_effect
    Engine::GameObject.new(
      "Explosion",
      pos: game_object.pos,
      components: [
        Engine::Components::SpriteRenderer.new(
          Vector.new(-100, 100),
          Vector.new(100, 100),
          Vector.new(100, -100),
          Vector.new(-100, -100),
          explosion_texture.texture,
          [
            { tl: Vector.new(1.0 / 6, 0), width: 1.0 / 6, height: 1 },
            { tl: Vector.new(2.0 / 6, 0), width: 1.0 / 6, height: 1 },
            { tl: Vector.new(3.0 / 6, 0), width: 1.0 / 6, height: 1 },
            { tl: Vector.new(4.0 / 6, 0), width: 1.0 / 6, height: 1 },
            { tl: Vector.new(5.0 / 6, 0), width: 1.0 / 6, height: 1 },
            { tl: Vector.new(0, 0), width: 1.0 / 6, height: 1 },
          ],
          20,
          false
        )
      ]
    )
  end

  def explosion_texture
    @explosion_texture ||= Engine::Texture.new(File.join(__dir__, "..", "assets", "boom.png"))
  end

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
