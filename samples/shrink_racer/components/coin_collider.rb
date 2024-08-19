# frozen_string_literal: true

module ShrinkRacer
  class CoinCollider < Engine::Component
    attr_reader :radius

    def initialize(radius)
      @radius = radius

      CoinCollider.colliders << self
    end

    def destroy
      self.class.colliders.delete(self)
    end

    def self.colliders
      @colliders ||= []
    end
  end
end
