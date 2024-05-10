# frozen_string_literal: true

describe Engine do
  describe ".start" do
    it "starts the game engine" do
      expect(Engine).to receive(:load).with("base_dir")
      expect(Engine).to receive(:open_window).with(600, 800)
      expect(Engine).to receive(:main_game_loop)
      expect(Engine).to receive(:terminate)

      Engine.start(width: 600, height: 800, base_dir: "base_dir")
    end
  end
end