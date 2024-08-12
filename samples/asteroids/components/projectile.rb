# frozen_string_literal: true

module Asteroids
  class Projectile < Engine::Component
    def update(delta_time)
      AsteroidComponent.asteroids.each do |asteroid|
        next if asteroid.destroyed?
        if (game_object.pos - asteroid.game_object.pos).magnitude < asteroid.size
          asteroid.blow_up
          Explosion.create(game_object.pos)
          game_object.destroy!
          break
        end
      end
    end
  end
end
