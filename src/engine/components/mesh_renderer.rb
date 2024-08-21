# frozen_string_literal: true

module Engine::Components
  class MeshRenderer < Engine::Component
    attr_reader :mesh, :material

    def initialize(mesh, material)
      @mesh = mesh
      @material = material
      Rendering::RenderPipeline.add_instance(self)
    end

    def renderer?
      true
    end
  end
end
