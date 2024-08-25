# frozen_string_literal: true

module Engine
  class Cursor
    class << self

      def disable
        GLFW.SetInputMode(Window.window, GLFW::CURSOR, GLFW::CURSOR_DISABLED)
      end

      def hide
        GLFW.SetInputMode(Window.window, GLFW::CURSOR, GLFW::CURSOR_HIDDEN)
      end

      def enable
        GLFW.SetInputMode(Window.window, GLFW::CURSOR, GLFW::CURSOR_NORMAL)
      end

      def get_input_mode
        GLFW.GetInputMode(Window.window, GLFW::CURSOR)
      end

      def restore_input_mode(original_mode)
        case original_mode
        when GLFW::CURSOR_NORMAL then enable
        when GLFW::CURSOR_HIDDEN then hide
        when GLFW::CURSOR_DISABLED then disable
        end
      end
    end
  end
end
