# frozen_string_literal: true

describe Engine do
  describe ".update" do
    it 'calls update on gameobjects' do
      expect(Engine::GameObject).to receive(:update_all)

      @old_time = @time || Time.now
      @time = Time.now
      delta_time = @time - @old_time
      Engine.print_fps(delta_time)
      GameObject.update_all(delta_time)
      GameObject.cache_matrices
      @swap_buffers_promise.wait! if @swap_buffers_promise
      GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
      GameObject.render_all(delta_time)
    end
  end
end