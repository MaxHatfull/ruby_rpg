# frozen_string_literal: true

module Engine::Physics::Components
  class Rigidbody < Engine::Component
    attr_accessor :velocity, :force, :impulses, :mass

    def initialize(velocity: Vector[0, 0, 0], mass: 1, gravity: Vector[0, -9.81, 0])
      @velocity = velocity
      @force = gravity * mass
      @gravity = gravity
      @impulses = []
      @mass = mass
    end

    def update(delta_time)
      @velocity += acceleration * delta_time
      @velocity += @impulses.reduce(Vector[0, 0, 0]) { |acc, impulse| acc + impulse } / @mass
      @impulses = []
      @game_object.pos += @velocity * delta_time
    end

    def apply_impulse(impulse)
      @impulses << impulse
    end

    def colliders
      @game_object.components.select { |c| c.is_a?(SphereCollider) }
    end

    private

    def acceleration
      @force / @mass
    end
  end
end
