# frozen_string_literal: true

module ShrinkRacer
  class GameController < Engine::Component

    attr_reader :score

    def initialize(coin_counter)
      @score = 0
      @total_coins = CoinCollider.colliders.count
      @coin_counter = coin_counter
      GameController.instance = self
    end

    def self.instance
      @instance
    end

    def self.instance=(instance)
      @instance = instance
    end

    def start
      set_counter
    end

    def coin_collected
      @score += 1
      set_counter
    end

    private

    def set_counter
      @coin_counter.update_string("#{@score} / #{@total_coins}")
    end
  end
end
