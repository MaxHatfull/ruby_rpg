# frozen_string_literal: true

module Rendering
  module RenderPipeline
    def self.draw
      Engine::GameObject.mesh_renderers.each do |mr|
        instance_renderers[mr].draw(mr.game_object.model_matrix)
      end
    end

    private

    def self.instance_renderers
      @instance_renderers ||= Hash.new do |hash, key|
        hash[key] = InstanceRenderer.new(key.mesh, key.material)
      end
    end
  end
end
