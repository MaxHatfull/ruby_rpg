# frozen_string_literal: true

module Engine::Physics::Components
  class Rigidbody < Engine::Component
    attr_accessor :velocity, :forces, :impulses, :mass

    def initialize(velocity: Vector[0, 0, 0], mass: 1, gravity: Vector[0, -9.81, 0])
      @velocity = velocity
      @forces = [gravity * mass]
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

    def calculate_collision_impulses
      @impulses += collision_impulses
    end

    def energy
      kinetic = 0.5 * @mass * @velocity.magnitude**2
      potential = -@mass * @gravity[1] * @game_object.pos[1]
      kinetic + potential
    end

    private

    def acceleration
      @forces.reduce(Vector[0, 0, 0]) do |acc, force|
        acc + force / @mass
      end
    end

    def collision_impulses
      own_colliders.map do |collider|
        other_colliders.map do |other_collider|
          collision_for(collider, other_collider)
        end.compact
      end.flatten.map(&:impulse)
    end

    def collision_for(collider, other_collider)
      collider.collision_for(other_collider)
    end

    def own_colliders
      @game_object.components.select { |c| c.is_a?(SphereCollider) }
    end

    def all_colliders
      Engine::GameObject.objects.map do |go|
        go.components.select { |c| c.is_a?(SphereCollider) }
      end.flatten
    end

    def other_colliders
      all_colliders.reject { |c| own_colliders.include?(c) }
    end
  end
end
