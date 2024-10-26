# frozen_string_literal: true

describe Engine do
  describe ".start" do
    it "starts the game engine" do
      expect(Engine).to receive(:load).with("base_dir")
      expect(Engine).to receive(:open_window)
      expect(Engine).to receive(:main_game_loop)
      expect(Engine).to receive(:terminate)

      Engine.start(base_dir: "base_dir")
    end
  end
end
