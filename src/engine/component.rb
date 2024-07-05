module Engine
  class Component
    def self.method_added(name)
      @methods ||= []
      return if name == :initialize
      @methods << name
    end

    attr_reader :game_object

    def renderer?
      false
    end

    def ui_renderer?
      false
    end

    def set_game_object(game_object)
      @game_object = game_object
    end

    def start
    end

    def update(delta_time) end

    def destroy!
      destroy
      game_object.components.delete(self)
      self.class.instance_variable_get(:@methods).each do |method|
        singleton_class.send(:undef_method, method)
      end
    end

    def destroy
    end
  end
end
