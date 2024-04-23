# frozen_string_literal: true

class DestroyAfter < Engine::Component
  def initialize(time)
    @time = time
  end

  def update(delta_time)
    @time -= delta_time
    game_object.destroy! if @time <= 0
  end
end
