# frozen_string_literal: true

module Engine::Physics::Components
  class SphereCollider < Engine::Component
    attr_accessor :radius

    def initialize(radius)
      @radius = radius
    end

    def collision_for(other_collider)
      distance = (game_object.pos - other_collider.game_object.pos).magnitude
      min_distance = radius + other_collider.radius

      return nil if distance >= min_distance

      direction = (other_collider.game_object.pos - game_object.pos).normalize
      collision_point = collision_point(direction, min_distance - distance)
      magnitude = impulse_magnitude(direction, other_collider)

      return nil if magnitude < 0

      Engine::Physics::Collision.new(-direction * magnitude, collision_point)
    end

    def static?
      rigidbody.nil?
    end

    def inverse_mass
      1 / rigidbody.mass
    end

    def velocity
      rigidbody&.velocity
    end

    def rigidbody
      game_object.components.find { |c| c.is_a?(Rigidbody) }
    end

    private

    def collision_point(direction, overlap)
      game_object.pos + direction * (radius - overlap / 2)
    end

    def impulse_magnitude(direction, other_collider)
      if other_collider.static?
        v_r = velocity
        (v_r.dot(direction) * 2) / inverse_mass
      else
        v_r = velocity - other_collider.velocity
        (v_r.dot(direction) * 2) / (inverse_mass + other_collider.inverse_mass)
      end
    end
  end
end
