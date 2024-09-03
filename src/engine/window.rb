# frozen_string_literal: true

module Engine
  class Window

    FULL_SCREEN       = true
    MAX_WIDTH         = 1920
    MAX_HEIGHT        = 1080
    WINDOWED_WIDTH    = 1200
    WINDOWED_HEIGHT   = 800

    class << self
      attr_accessor :full_screen, :window, :window_title
      attr_reader :framebuffer_height, :framebuffer_width

      def create_window(window_title: 'Ruby RPG')
        @full_screen = FULL_SCREEN
        set_opengl_version
        enable_decorations
        disable_auto_iconify
        @window = GLFW.CreateWindow(width, height, window_title, monitor, nil)
      end

      alias full_screen? full_screen

      def width
        @width = full_screen? ? MAX_WIDTH : WINDOWED_WIDTH
      end

      def height
        @height = full_screen? ? MAX_HEIGHT : WINDOWED_HEIGHT
      end

      def monitor
        full_screen? ? primary_monitor : nil
      end

      def primary_monitor
        # The primary monitor is returned by glfwGetPrimaryMonitor.
        # It is the user's preferred monitor and is usually the one with global UI elements like task bar or menu bar.
        # https://www.glfw.org/docs/latest/monitor_guide.html#monitor_monitors
        GLFW.GetPrimaryMonitor
      end

      def refresh_rate
        # GLFW_REFRESH_RATE specifies the desired refresh rate for full screen windows.
        # A value of GLFW_DONT_CARE means the highest available refresh rate will be used.
        # This hint is ignored for windowed mode windows.
        # https://www.glfw.org/docs/latest/window_guide.html#GLFW_REFRESH_RATE
        GLFW::DONT_CARE
      end

      # GLFW_DECORATED specifies whether the windowed mode window will have window decorations such as a border,
      # a close widget, etc.
      # An undecorated window will not be resizable by the user but will still allow the user to generate close events
      # on some platforms.
      # Possible values are GLFW_TRUE and GLFW_FALSE.
      # This hint is ignored for full screen windows.
      # https://www.glfw.org/docs/latest/window_guide.html#GLFW_DECORATED_attrib
      def enable_decorations
        GLFW.WindowHint(GLFW::DECORATED, GLFW::TRUE)
        GLFW.SetWindowAttrib(window, GLFW::DECORATED, GLFW::TRUE) if window
      end

      def disable_decorations
        GLFW.WindowHint(GLFW::DECORATED, GLFW::FALSE)
        GLFW.SetWindowAttrib(window, GLFW::DECORATED, GLFW::FALSE) if window
      end

      # GLFW_AUTO_ICONIFY specifies whether the full screen window will automatically iconify and restore the previous
      # video mode on input focus loss.
      # Possible values are GLFW_TRUE and GLFW_FALSE.
      # This hint is ignored for windowed mode windows.
      # https://www.glfw.org/docs/latest/window_guide.html#GLFW_AUTO_ICONIFY_hint
      def disable_auto_iconify
        GLFW.WindowHint(GLFW::AUTO_ICONIFY, GLFW::FALSE)
        GLFW.SetWindowAttrib(window, GLFW::AUTO_ICONIFY, GLFW::FALSE) if window
      end

      def set_to_windowed
        @full_screen = false
        GLFW.SetWindowMonitor(window, nil, 0, 0, width, height, refresh_rate)
      end

      def set_to_full_screen
        @full_screen = true
        GLFW.SetWindowMonitor(window, primary_monitor, 0, 0, width, height, refresh_rate)
      end

      def toggle_full_screen
        full_screen? ? set_to_windowed : set_to_full_screen
      end

      def focus_window
        GLFW.FocusWindow(window)
      end

      def update_screen_size
        width_buf = ' ' * 8
        height_buf = ' ' * 8

        GLFW.GetFramebufferSize(window, width_buf, height_buf)
        @framebuffer_width = width_buf.unpack1('L')
        @framebuffer_height = height_buf.unpack1('L')
      end

      def set_opengl_version
        GLFW.WindowHint(GLFW::CONTEXT_VERSION_MAJOR, 3)
        GLFW.WindowHint(GLFW::CONTEXT_VERSION_MINOR, 3)
        GLFW.WindowHint(GLFW::OPENGL_PROFILE, GLFW::OPENGL_CORE_PROFILE)
        GLFW.WindowHint(GLFW::OPENGL_FORWARD_COMPAT, GLFW::TRUE)
      end
    end
  end
end
