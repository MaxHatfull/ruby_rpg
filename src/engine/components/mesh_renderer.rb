# frozen_string_literal: true

module Engine::Components
  class MeshRenderer < Engine::Component
    attr_reader :mesh, :material

    def initialize(mesh, material)
      @mesh = mesh
      @material = material
    end

    def renderer?
      true
    end
  end
end
