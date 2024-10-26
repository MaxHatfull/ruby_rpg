# frozen_string_literal: true

module Cubes
  class Spinner < Engine::Component
    def initialize(speed)
      @speed = speed
      @old_state = false
    end

    def update(delta_time)
      input_state = Engine::Input.key?(GLFW::KEY_SPACE)

      if input_state && !@old_state
        rigid_body = game_object.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) }
        return unless rigid_body
        puts "rigid_body: #{rigid_body}"
        rigid_body.apply_impulse(Vector[10, 0, 0], game_object.pos + Vector[0, -5, 0])
      end

      @old_state = input_state
    end
  end
end
