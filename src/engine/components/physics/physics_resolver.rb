# frozen_string_literal: true

module Engine
  module PhysicsResolver
    def self.resolve
      rigidbodies.each do |rb|
        rb.calculate_collision_impulses
      end
    end

    private

    def self.rigidbodies
      Engine::GameObject.objects.map do |go|
        go.components.find { |c| c.is_a?(Engine::Components::Physics::Rigidbody) }
      end.compact
    end
  end
end
