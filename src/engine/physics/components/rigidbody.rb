# frozen_string_literal: true

module Engine::Physics::Components
  class Rigidbody < Engine::Component
    attr_accessor :velocity, :angular_velocity, :force, :impulses, :mass

    def initialize(velocity: Vector[0, 0, 0], angular_velocity: Vector[0, 0, 0], mass: 1, inertia_tensor: nil, gravity: Vector[0, -9.81, 0])
      @velocity = velocity
      @angular_velocity = angular_velocity
      @force = gravity * mass
      @gravity = gravity
      @impulses = []
      @mass = mass
      @inertia_tensor = inertia_tensor || Matrix[
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1]
      ] * mass
    end

    def update(delta_time)
      @velocity += acceleration * delta_time
      @velocity += @impulses.reduce(Vector[0, 0, 0]) { |acc, impulse| acc + impulse } / @mass
      @impulses = []
      @game_object.pos += @velocity * delta_time
      @game_object.rotate_around(angular_velocity, delta_time * angular_velocity.magnitude) if angular_velocity.magnitude > 0
    end

    def apply_impulse(impulse)
      @impulses << impulse
    end

    def colliders
      @game_object.components.select { |c| c.is_a?(SphereCollider) }
    end

    def kinetic_energy
      0.5 * @mass * @velocity.magnitude ** 2 +
        0.5 * moment_of_inertia * @angular_velocity.magnitude ** 2
    end

    def momentum
      @mass * @velocity
    end

    def angular_momentum(origin = Vector[0, 0, 0])
      moment_of_inertia * @angular_velocity +
        (game_object.pos - origin).cross(momentum)
    end

    private

    def acceleration
      @force / @mass
    end

    def moment_of_inertia
      return 0 if @angular_velocity.magnitude == 0

      angular_velocity_direction = @angular_velocity.normalize
      angular_velocity_direction.dot(@inertia_tensor * angular_velocity_direction)
    end
  end
end
