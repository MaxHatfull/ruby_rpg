# frozen_string_literal: true

module Engine::Components
  class DirectionLight < Engine::Component
    attr_accessor :diffuse, :specular

    def initialize(diffuse: Vector[1, 1, 1], specular: Vector[1, 1, 1])
      @diffuse = diffuse
      @specular = specular
    end

    def start
      DirectionLight.direction_lights << self
    end

    def destroy!
      DirectionLight.direction_lights.delete(self)
    end

    def self.direction_lights
      @direction_lights ||= []
    end
  end
end