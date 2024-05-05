# frozen_string_literal: true

module Engine::Components
  class PointLight < Engine::Component
    attr_accessor :range, :ambient, :diffuse, :specular

    def initialize(range: 300, ambient: Vector[0.01, 0.01, 0.01], diffuse: Vector[1, 1, 1], specular: Vector[1, 1, 1])
      @range = range
      @ambient = ambient
      @diffuse = diffuse
      @specular = specular
    end

    def start
      PointLight.point_lights << self
    end

    def destroy!
      PointLight.point_lights.delete(self)
    end

    def self.point_lights
      @point_lights ||= []
    end
  end
end