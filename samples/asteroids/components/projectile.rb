# frozen_string_literal: true

module Asteroids
  class Projectile < Engine::Component
    def update(delta_time)
      AsteroidComponent.asteroids.each do |asteroid|
        if (game_object.pos - asteroid.game_object.pos).magnitude < asteroid.size
          game_object.destroy!
          asteroid.blow_up

          Explosion.create(game_object.pos)
          break
        end
      end
    end
  end
end
