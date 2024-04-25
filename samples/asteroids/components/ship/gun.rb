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

      Bullet.new(game_object.local_to_world_coordinate(0, 20), game_object.rotation)
    end
  end
end
