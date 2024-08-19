# frozen_string_literal: true

module ShrinkRacer
  class CarCollider < Engine::Component
    def initialize(radius)
      @radius = radius
    end

    def start
      @car_controller = game_object.components.find { |c| c.is_a?(CarController) }
    end

    def update(delta_time)
      flat_pos = Vector[game_object.pos[0], game_object.pos[2]]

      TreeCollider.colliders.each do |tree|
        flat_tree_pos = Vector[tree.game_object.pos[0], tree.game_object.pos[2]]
        dist = (flat_tree_pos - flat_pos).magnitude
        if dist < (@radius * game_object.scale[0]) + tree.radius
          @car_controller.collide(tree.game_object.pos)
        end
      end

      CoinCollider.colliders.each do |coin|
        flat_coin_pos = Vector[coin.game_object.pos[0], coin.game_object.pos[2]]
        dist = (flat_coin_pos - flat_pos).magnitude
        if dist < (@radius * game_object.scale[0]) + coin.radius
          coin.game_object.destroy!
          GameController.instance.coin_collected
          @car_controller.collect_coin
        end
      end
    end
  end
end
