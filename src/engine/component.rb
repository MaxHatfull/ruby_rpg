module Engine
  class Component
    attr_reader :game_object

    def renderer?
      false
    end

    def set_game_object(game_object)
      @game_object = game_object
    end

    def start
    end

    def update(delta_time) end
  end
end