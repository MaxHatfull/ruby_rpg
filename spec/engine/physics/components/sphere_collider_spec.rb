# frozen_string_literal: true

describe Engine::Physics::Components::SphereCollider do
  describe '#collision_for' do
    context 'when colliding with another sphere' do
      let(:collider) { described_class.new(radius) }
      let!(:collider_object) do
        Engine::GameObject.new(
          "collider_object",
          pos: position,
          components: [
            collider,
            Engine::Physics::Components::Rigidbody.new(velocity: velocity)
          ]
        )
      end
      let(:velocity) { Vector[0, 0, 0] }

      let(:other_collider) { described_class.new(other_radius) }
      let!(:other_collider_object) do
        Engine::GameObject.new(
          "other_collider_object",
          pos: other_position,
          components: [
            other_collider,
            Engine::Physics::Components::Rigidbody.new(velocity: other_velocity)
          ]
        )
      end
      let(:other_velocity) { Vector[0, 0, 0] }

      context "when the spheres are touching" do
        let(:position) { Vector[0, 0, 0] }
        let(:other_position) { Vector[2, 0, 0] }
        let(:radius) { 1.51 }
        let(:other_radius) { 0.51 }

        it 'returns a collision' do
          collision = collider.collision_for(other_collider)

          expect(collision.point).to eq(Vector[1.5, 0, 0])
          expect(collision.impulse).to eq(Vector[0, 0, 0])
        end
      end

      context "when the spheres are moving towards each other" do
        let(:position) { Vector[0, 0, 0] }
        let(:other_position) { Vector[2, 0, 0] }
        let(:radius) { 1.51 }
        let(:other_radius) { 0.51 }
        let(:velocity) { Vector[1, 0, 0] }

        it 'returns a collision' do
          collision = collider.collision_for(other_collider)

          expect(collision.point).to eq(Vector[1.5, 0, 0])
          expect(collision.impulse).to eq(Vector[-1, 0, 0])
        end
      end

      context "when the spheres are moving away from each other" do
        let(:position) { Vector[0, 0, 0] }
        let(:other_position) { Vector[2, 0, 0] }
        let(:radius) { 1.51 }
        let(:other_radius) { 0.51 }
        let(:velocity) { Vector[-1, 0, 0] }

        it 'returns nil' do
          collision = collider.collision_for(other_collider)

          expect(collision).to be_nil
        end
      end

      context "when the spheres are not touching" do
        let(:position) { Vector[0, 0, 0] }
        let(:other_position) { Vector[2, 0, 0] }
        let(:radius) { 0.5 }
        let(:other_radius) { 0.5 }

        it 'returns nil' do
          collision = collider.collision_for(other_collider)

          expect(collision).to be_nil
        end
      end
    end
  end

  describe "two spheres colliding" do
    context "when one sphere runs into a stationary sphere" do
      let(:object_1) do
        Engine::GameObject.new(
          "object_1",
          pos: Vector[0, 0, 0],
          components: [
            described_class.new(1.01),
            Engine::Physics::Components::Rigidbody.new(
              velocity: Vector[10, 0, 0],
              gravity: Vector[0, 0, 0],
              mass: mass_1
            )
          ]
        )
      end
      let(:mass_1) { 1 }
      let(:rigidbody_1) { object_1.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) } }
      let(:object_2) do
        Engine::GameObject.new(
          "object_2",
          pos: Vector[2, 0, 0],
          components: [
            described_class.new(1.01),
            Engine::Physics::Components::Rigidbody.new(
              velocity: Vector[0, 0, 0],
              gravity: Vector[0, 0, 0],
              mass: mass_2
            )
          ]
        )
      end
      let(:mass_2) { 1 }
      let(:rigidbody_2) { object_2.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) } }

      it "conserves momentum and energy" do
        starting_kinetic_energy = rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy
        starting_momentum = rigidbody_1.momentum + rigidbody_2.momentum

        Engine::Physics::PhysicsResolver.resolve
        object_1.components.each { |c| c.update(0.1) }
        object_2.components.each { |c| c.update(0.1) }

        expect(rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy).to eq(starting_kinetic_energy)
        expect(rigidbody_1.momentum + rigidbody_2.momentum).to eq(starting_momentum)
        expect(rigidbody_1.velocity).to eq(Vector[0, 0, 0])
        expect(rigidbody_2.velocity).to eq(Vector[10, 0, 0])
      end

      context "with different masses" do
        let(:mass_1) { 2 }
        let(:mass_2) { 1 }

        it "conserves momentum and energy" do
          starting_kinetic_energy = rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy
          starting_momentum = rigidbody_1.momentum + rigidbody_2.momentum

          Engine::Physics::PhysicsResolver.resolve
          object_1.components.each { |c| c.update(0.1) }
          object_2.components.each { |c| c.update(0.1) }

          puts rigidbody_1.velocity
          puts rigidbody_2.velocity
          expect(rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy).to be_within(0.00001).of(starting_kinetic_energy)
          expect(rigidbody_1.momentum + rigidbody_2.momentum).to eq(starting_momentum)
          expect(rigidbody_1.velocity).to be_vector(Vector[3.3333333, 0, 0])
          expect(rigidbody_2.velocity).to be_vector(Vector[13.3333333, 0, 0])
        end
      end
    end

    context "when two spheres collide head-on" do
      let(:object_1) do
        Engine::GameObject.new(
          "object_1",
          pos: Vector[0, 0, 0],
          components: [
            described_class.new(1.01),
            Engine::Physics::Components::Rigidbody.new(
              velocity: Vector[10, 0, 0],
              gravity: Vector[0, 0, 0]
            )
          ]
        )
      end
      let(:rigidbody_1) { object_1.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) } }
      let(:object_2) do
        Engine::GameObject.new(
          "object_2",
          pos: Vector[2, 0, 0],
          components: [
            described_class.new(1.01),
            Engine::Physics::Components::Rigidbody.new(
              velocity: Vector[-10, 0, 0],
              gravity: Vector[0, 0, 0]
            )
          ]
        )
      end
      let(:rigidbody_2) { object_2.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) } }

      it "conserves momentum and energy" do
        starting_kinetic_energy = rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy
        starting_momentum = rigidbody_1.momentum + rigidbody_2.momentum

        Engine::Physics::PhysicsResolver.resolve
        object_1.components.each { |c| c.update(0.1) }
        object_2.components.each { |c| c.update(0.1) }

        expect(rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy).to eq(starting_kinetic_energy)
        expect(rigidbody_1.momentum + rigidbody_2.momentum).to eq(starting_momentum)
        expect(rigidbody_1.velocity).to eq(Vector[-10, 0, 0])
        expect(rigidbody_2.velocity).to eq(Vector[10, 0, 0])
      end
    end

    context "when two spheres collide at an angle" do
      let(:object_1) do
        Engine::GameObject.new(
          "object_1",
          pos: Vector[0, 0, 0],
          components: [
            described_class.new(1.01),
            Engine::Physics::Components::Rigidbody.new(
              velocity: Vector[10, 10, 0],
              gravity: Vector[0, 0, 0]
            )
          ]
        )
      end
      let(:rigidbody_1) { object_1.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) } }
      let(:object_2) do
        Engine::GameObject.new(
          "object_2",
          pos: Vector[2, 0, 0],
          components: [
            described_class.new(1.01),
            Engine::Physics::Components::Rigidbody.new(
              velocity: Vector[-10, 10, 0],
              gravity: Vector[0, 0, 0]
            )
          ]
        )
      end
      let(:rigidbody_2) { object_2.components.find { |c| c.is_a?(Engine::Physics::Components::Rigidbody) } }

      it "conserves momentum and energy" do
        starting_kinetic_energy = rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy
        starting_momentum = rigidbody_1.momentum + rigidbody_2.momentum

        Engine::Physics::PhysicsResolver.resolve
        object_1.components.each { |c| c.update(0.1) }
        object_2.components.each { |c| c.update(0.1) }

        expect(rigidbody_1.kinetic_energy + rigidbody_2.kinetic_energy).to eq(starting_kinetic_energy)
        expect(rigidbody_1.momentum + rigidbody_2.momentum).to eq(starting_momentum)
        expect(rigidbody_1.velocity).to eq(Vector[-10, 10, 0])
        expect(rigidbody_2.velocity).to eq(Vector[10, 10, 0])
      end
    end
  end
end
