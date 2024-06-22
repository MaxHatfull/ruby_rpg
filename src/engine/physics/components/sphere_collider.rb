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

      overlap = min_distance - distance
      direction = (other_collider.game_object.pos - game_object.pos).normalize
      collision_point = game_object.pos +
        direction * (radius - overlap / 2)

      if distance < min_distance && !current_collisions.include?(other_collider)
        current_collisions << other_collider
        direction = (game_object.pos - other_collider.game_object.pos).normalize
        magnitude =
          if other_collider.static?
            v_r = velocity
            -(v_r.dot(direction) * 2) / inverse_mass
          else
            v_r = velocity - other_collider.velocity
            -(v_r.dot(direction) * 2) / (inverse_mass + other_collider.inverse_mass)
          end
        return nil if magnitude < 0
        Engine::Physics::Collision.new(direction * magnitude, collision_point)
      else
        current_collisions.delete(other_collider) if current_collisions.include?(other_collider) && distance > min_distance
        nil
      end
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

    def momentum
      rigidbody.velocity * rigidbody.mass
    end

    def rigidbody
      game_object.components.find { |c| c.is_a?(Rigidbody) }
    end

    def current_collisions
      @current_collisions ||= []
    end
  end
end
