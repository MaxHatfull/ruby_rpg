# frozen_string_literal: true

describe Engine::Physics::PhysicsResolver do
  describe '.resolve' do
    it 'calls calculate_collision_impulses on each rigidbody' do
      rigidbody = Engine::Physics::Components::Rigidbody.new
      rigidbody_object = Engine::GameObject.new(
        "rigidbody_object",
        components: [rigidbody]
      )

      expect(rigidbody).to receive(:calculate_collision_impulses)
      Engine::Physics::PhysicsResolver.resolve
    end
  end
end
