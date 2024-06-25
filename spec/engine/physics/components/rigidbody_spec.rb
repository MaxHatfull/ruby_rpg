# frozen_string_literal: true

describe Engine::Physics::Components::Rigidbody do
  describe '#update' do
    let(:rigidbody) do
      described_class.new(
        velocity:,
        angular_velocity:,
        gravity:,
        mass:
      )
    end
    let(:angular_velocity) { Vector[0, 0, 0] }
    let!(:rigidbody_object) do
      Engine::GameObject.new(
        "rigidbody_object",
        components: [rigidbody]
      )
    end

    context "with no velocity or gravity" do
      let(:velocity) { Vector[0, 0, 0] }
      let(:gravity) { Vector[0, 0, 0] }
      let(:mass) { 1 }

      it 'is stationary' do
        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to eq(Vector[0, 0, 0])
        expect(rigidbody.velocity).to eq(Vector[0, 0, 0])
      end
    end

    context "with some velocity" do
      let(:velocity) { Vector[1, 0, 0] }
      let(:gravity) { Vector[0, 0, 0] }
      let(:mass) { 1 }

      it 'moves' do
        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to eq(Vector[0.1, 0, 0])
        expect(rigidbody.velocity).to eq(Vector[1, 0, 0])

        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to eq(Vector[0.2, 0, 0])
        expect(rigidbody.velocity).to eq(Vector[1, 0, 0])
      end
    end

    context "with some gravity" do
      let(:velocity) { Vector[0, 0, 0] }
      let(:gravity) { Vector[0, -9.81, 0] }
      let(:mass) { 1 }

      it 'falls' do
        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to be_vector(Vector[0, -0.0981, 0])
        expect(rigidbody.velocity).to be_vector(Vector[0, -0.981, 0])

        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to be_vector(Vector[0, -0.2943, 0])
        expect(rigidbody.velocity).to be_vector(Vector[0, -1.962, 0])
      end
    end

    context "with some angular velocity" do
      let(:angular_velocity) { Vector[1, 0, 0] }
      let(:velocity) { Vector[0, 0, 0] }
      let(:gravity) { Vector[0, 0, 0] }
      let(:mass) { 1 }

      it 'rotates' do
        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to eq(Vector[0, 0, 0])
        expect(rigidbody_object.rotation).to eq(Vector[0.1, 0, 0])
      end
    end

    context "when applying an impulse" do
      let(:velocity) { Vector[0, 5, 0] }
      let(:gravity) { Vector[0, -9.81, 0] }
      let(:mass) { 1 }
      let(:impulse) { Vector[1, 0, 0] }

      it 'instantly changes velocity' do
        rigidbody.apply_impulse(impulse)
        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to be_vector(Vector[0.1, 0.4019, 0])
        expect(rigidbody.velocity).to be_vector(Vector[1, 4.019, 0])

        rigidbody.update(0.1)

        expect(rigidbody_object.pos).to be_vector(Vector[0.2, 0.7057, 0])
        expect(rigidbody.velocity).to be_vector(Vector[1, 3.038, 0])
      end
    end
  end
end
