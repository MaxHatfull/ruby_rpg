# frozen_string_literal: true

module ShrinkRacer
  class TreeCollider < Engine::Component
    attr_reader :radius

    def initialize(radius)
      @radius = radius

      TreeCollider.colliders << self
    end

    def destroy
      self.class.colliders.delete(self)
    end

    def self.colliders
      @colliders ||= []
    end
  end
end
