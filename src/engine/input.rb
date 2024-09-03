# frozen_string_literal: true

module Engine
  class Input
    def self.key_down?(key)
      keys[key]
    end

    def self._on_key_down(key)
      keys[key] = true
      if key == GLFW::KEY_ESCAPE
        Engine.close
      end

      if key == GLFW::KEY_BACKSPACE
        Engine.breakpoint { binding.pry }
        # Engine.breakpoint { debugger }
      end

      if key == GLFW::KEY_F
        Engine::Window.toggle_full_screen
      end
    end

    def self._on_key_up(key)
      keys[key] = false
    end

    def self.key_callback(key, action)
      if action == GLFW::PRESS
        _on_key_down(key)
      elsif action == GLFW::RELEASE
        _on_key_up(key)
      end
    end

    private

    def self.keys
      @keys ||= Hash.new(false)
    end
  end
end
