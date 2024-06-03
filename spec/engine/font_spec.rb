# frozen_string_literal: true

describe Engine::Font do
  describe "#string_indices" do
    it "returns the indices of the string" do
      font = Engine::Font.new("spec/fixtures/UbuntuMono-R.ttf")

      expect(font.string_indices("Hello")).to eq([71, 100, 107, 107, 110])
    end
  end

  describe "#string_offsets" do
    let(:widths) do
      { "H" => 100, "e" => 80, "l" => 30, "o" => 50, "w" => 100, "r" => 60, "d" => 60 }
    end
    before do
      stub_const("ROOT", "spec")
      allow(FreeType::API::Font).to receive(:open) do |&block|
        face = double("face")
        allow(face).to receive(:glyph) do |char|
          double("glyph", char_width: widths[char])
        end
        block.call(face)
      end
    end

    it "returns the offsets of the string" do
      font = Engine::Font.new("spec/fixtures/UbuntuMono-R.ttf")

      expect(font.string_offsets("Hello\nworld"))
        .to eq([
                 [0.0, 0.0], [0.048828125, 0.0], [0.087890625, 0.0], [0.1025390625, 0.0], [0.1171875, 0.0],
                 [0.0, -1.0], [0.048828125, -1.0], [0.0732421875, -1.0], [0.1025390625, -1.0], [0.1171875, -1.0]
               ]
            )
    end
  end
end
