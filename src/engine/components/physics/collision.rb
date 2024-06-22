# frozen_string_literal: true

module Engine::Components::Physics
  class Collision
    attr_accessor :impulse, :point

    def initialize(impulse, point)
      @impulse = impulse
      @point = point
    end
  end
end
