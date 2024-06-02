# frozen_string_literal: true

module Asteroids
  class Gun < Engine::Component
    COOLDOWN = 0.3

    def update(delta_time)
      fire if Engine::Input.key_down?(GLFW::KEY_SPACE)
    end

    def fire
      return if @last_fire && Time.now - @last_fire < COOLDOWN
      @last_fire = Time.now

      Bullet.create(game_object.local_to_world_coordinate(Vector[0, 20, 0]), game_object.rotation)
    end
  end
end
