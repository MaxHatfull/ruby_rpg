# frozen_string_literal: true

module Asteroids
  class ShieldComponent < Engine::Component
    def initialize
      @shield_health = 100
      @shield_colour = { r: 1, g: 1, b: 1 }
    end

    def ship
      @ship ||= Engine::GameObject.objects.select{ |game_object| game_object.name == "Ship" }.first
    end

    def update(delta_time)
      track_the_ship
      detect_collision_with_asteroids
      set_shield_colour
      destroy_shield! if @shield_health <= 0
    end

    def track_the_ship
      game_object.pos = ship.pos
      game_object.rotation = ship.rotation
    end

    def detect_collision_with_asteroids
      AsteroidComponent.asteroids.each do |asteroid|
        if (game_object.pos - asteroid.game_object.pos).magnitude < asteroid.size
          inflict_shield_damage(asteroid.size)
          asteroid.destroy!

          Explosion.create(game_object.pos)
        end
      end
    end

    def inflict_shield_damage(asteroid_size)
      damage = ( asteroid_size / 5 )
      @shield_health -= damage
    end

    def destroy_shield!
      game_object.destroy!
      Explosion.create(game_object.pos, colour: { r: 0.5, g: 1, b: 1 })
    end

    def set_shield_colour
      case @shield_health
      when 25..49
        @shield_colour = {r: 0.5, g: 0.5, b: 0.5}
      when 0..24
        flickering_colour = rand(0.2..0.5)
        @shield_colour = {r: flickering_colour, g: flickering_colour, b: flickering_colour}
      end

      shield_sprite_renderer.colour = @shield_colour
    end

    private

    def shield_sprite_renderer
      game_object.components.first.game_object.renderers.first
    end
  end
end
