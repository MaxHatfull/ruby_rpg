# frozen_string_literal: true

describe Engine::Quaternion do
  describe '#initialize' do
    let(:quaternion) { described_class.new(1, 2, 3, 4) }

    it 'creates the quaternion' do
      expect(quaternion.w).to eq(1)
      expect(quaternion.x).to eq(2)
      expect(quaternion.y).to eq(3)
      expect(quaternion.z).to eq(4)
    end
  end

  describe '#*' do
    let(:quaternion) { described_class.new(1, 2, 3, 4) }
    let(:other) { described_class.new(5, 6, 7, 8) }

    it 'multiplies the quaternions' do
      result = quaternion * other

      expect(result.w).to eq(-60)
      expect(result.x).to eq(12)
      expect(result.y).to eq(30)
      expect(result.z).to eq(24)
    end
  end

  describe '#to_euler' do
    it 'converts the identity quaternion to euler' do
      quaternion = described_class.new(1, 0, 0, 0)
      expect(quaternion.to_euler).to eq(Vector[0, 0, 0])
    end

    it 'converts a 90 degree rotation around the x axis to euler' do
      quaternion = described_class.new(0.7071068, 0.7071068, 0, 0)
      expect(quaternion.to_euler).to be_vector(Vector[90, 0, 0])
    end

    it 'converts a 90 degree rotation around the y axis to euler' do
      quaternion = described_class.new(0.7071068, 0, 0.7071068, 0)

      expect(quaternion.to_euler).to be_vector(Vector[0, 90, 0])
    end

    it 'converts a 90 degree rotation around the z axis to euler' do
      quaternion = described_class.new(0.7071068, 0, 0, 0.7071068)
      expect(quaternion.to_euler).to be_vector(Vector[0, 0, 90])
    end

    it "converts a 45 degree rotation around the arbitrary axis [1, 1, 1] to euler" do
      quaternion = described_class.new(0.9238795, 0.2209424, 0.2209424, 0.2209424)
      expect(quaternion.to_euler).to be_vector(Vector[21.105870722312776, 30.38974606465104, 21.105870722312776])
    end
  end

  describe ".from_euler" do
    it "creates a quaternion for a rotation about the x axis" do
      quaternion = described_class.from_euler(Vector[90, 0, 0])

      expect(quaternion.w).to be_within(0.0001).of(0.7071068)
      expect(quaternion.x).to be_within(0.0001).of(0.7071068)
      expect(quaternion.y).to be_within(0.0001).of(0)
      expect(quaternion.z).to be_within(0.0001).of(0)
    end

    it "creates a quaternion for a rotation about the y axis" do
      quaternion = described_class.from_euler(Vector[0, 90, 0])

      expect(quaternion.w).to be_within(0.0001).of(0.7071068)
      expect(quaternion.x).to be_within(0.0001).of(0)
      expect(quaternion.y).to be_within(0.0001).of(0.7071068)
      expect(quaternion.z).to be_within(0.0001).of(0)
    end

    it "creates a quaternion for a rotation about the z axis" do
      quaternion = described_class.from_euler(Vector[0, 0, 90])

      expect(quaternion.w).to be_within(0.0001).of(0.7071068)
      expect(quaternion.x).to be_within(0.0001).of(0)
      expect(quaternion.y).to be_within(0.0001).of(0)
      expect(quaternion.z).to be_within(0.0001).of(0.7071068)
    end

    it "creates a quaternion for a rotation about an arbitrary axis" do
      quaternion = described_class.from_euler(Vector[10.0, 20.0, 30.0])

      expect(quaternion.w).to be_within(0.0001).of(0.9437144)
      expect(quaternion.x).to be_within(0.0001).of(0.1276794)
      expect(quaternion.y).to be_within(0.0001).of(0.1448781)
      expect(quaternion.z).to be_within(0.0001).of(0.2685358)
    end
  end

  describe ".from_angle_axis" do
    it "creates a quaternion for a rotation about the x axis" do
      quaternion = described_class.from_angle_axis(90, Vector[1, 0, 0])
      expect(quaternion.to_euler).to be_vector(Vector[90, 0, 0])
    end

    it "creates a quaternion for a rotation about the y axis" do
      quaternion = described_class.from_angle_axis(90, Vector[0, 1, 0])
      expect(quaternion.to_euler).to be_vector(Vector[0, 90, 0])
    end

    it "creates a quaternion for a rotation about the z axis" do
      quaternion = described_class.from_angle_axis(90, Vector[0, 0, 1])
      expect(quaternion.to_euler).to be_vector(Vector[0, 0, 90])
    end

    it "creates a rotation about an arbitrary axis" do
      quaternion = described_class.from_angle_axis(90, Vector[1, 1, 1])
      expect(quaternion.w).to be_within(0.0001).of(0.7071068)
      expect(quaternion.x).to be_within(0.0001).of(0.4082483)
      expect(quaternion.y).to be_within(0.0001).of(0.4082483)
      expect(quaternion.z).to be_within(0.0001).of(0.4082483)
    end
  end

  describe "when converting to and from euler angles" do
    it "keeps basis rotations the same" do
      expect(described_class.from_euler(Vector[0, 0, 0]).to_euler).to be_vector(Vector[0, 0, 0])
      expect(described_class.from_euler(Vector[40, 0, 0]).to_euler).to be_vector(Vector[40, 0, 0])
      expect(described_class.from_euler(Vector[0, 50, 0]).to_euler).to be_vector(Vector[0, 50, 0])
      expect(described_class.from_euler(Vector[0, 0, 60]).to_euler).to be_vector(Vector[0, 0, 60])
    end

    it "converts a rotation about the x and y axes" do
      expect(described_class.from_euler(Vector[10, 20, 0]).to_euler).to be_vector(Vector[10, 20, 0])
    end

    it "converts a rotation about the x and z axes" do
      expect(described_class.from_euler(Vector[10, 0, 30]).to_euler).to be_vector(Vector[10, 0, 30])
    end

    it "converts a rotation about the y and z axes" do
      expect(described_class.from_euler(Vector[0, 20, 30]).to_euler).to be_vector(Vector[0, 20, 30])
    end
  end
end
