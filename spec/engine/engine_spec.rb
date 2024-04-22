# frozen_string_literal: true

describe Engine do
  describe ".update" do
    it 'calls update on gameobjects' do
      expect(Engine::GameObject).to receive(:update_all)

      Engine.update
    end
  end
end