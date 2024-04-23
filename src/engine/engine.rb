require 'opengl'
require 'glfw'

require_relative 'screenshoter'
require_relative 'input'
require_relative 'types/vector'
require_relative 'game_object'
require_relative 'texture'
require_relative 'shader'
require_relative 'component'
require_relative "components/triangle_renderer"
require_relative "components/sprite_renderer"
require_relative "components/rect_renderer"

GLFW.load_lib("libglfw.dylib") # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
GLFW.Init()

module Engine
  def self.start(width: 600, height: 800, base_dir:, &first_frame_block)
    load(base_dir)
    open_window(width, height)
    main_game_loop(&first_frame_block)
    terminate
  end

  def self.engine_started?
    @engine_started
  end

  def self.load(base_dir)
    base_dir = File.expand_path(base_dir)
    Dir[File.join(base_dir, "components", "**/*.rb")].each do |file|
      require file
    end
    GL.load_lib
    set_opengl_version
  end

  def self.open_window(width, height)
    GLFW.WindowHint(GLFW::DECORATED, 0)
    @key_callback = create_key_callbacks # This must be an instance variable to prevent garbage collection
    @window = GLFW.CreateWindow(width, height, "Simple example", nil, nil)
    GLFW.MakeContextCurrent(@window)
    GLFW.SetKeyCallback(@window, @key_callback)
    set_opengl_blend_mode
    @engine_started = true
    GL.ClearColor(0.0, 0.0, 0.0, 1.0)
  end

  def self.main_game_loop(&first_frame_block)
    @game_stopped = false
    until GLFW.WindowShouldClose(@window) == GLFW::TRUE || @game_stopped
      GL.Clear(GL::COLOR_BUFFER_BIT) # Clear the screen

      update_screen_size
      if first_frame_block
        first_frame_block.call
        first_frame_block = nil
      end
      update

      GLFW.SwapBuffers(@window)

      if Screenshoter.scheduled_screenshot
        Screenshoter.take_screenshot
      end

      GLFW.PollEvents
    end
  end

  def self.terminate
    GLFW.DestroyWindow(@window)
    GLFW.Terminate
  end

  def self.close
    GameObject.destroy_all
    GLFW.SetWindowShouldClose(@window, 1)
  end

  def self.stop_game
    @game_stopped = true
    GameObject.destroy_all
  end

  private

  def self.update
    @old_time = @time || Time.now
    @time = Time.now
    delta_time = @time - @old_time
    GameObject.update_all(delta_time)
  end

  def self.set_opengl_blend_mode
    GL.Enable(GL::BLEND)
    GL.BlendFunc(GL::SRC_ALPHA, GL::ONE_MINUS_SRC_ALPHA)
  end

  def self.update_screen_size
    width_buf = ' ' * 8
    height_buf = ' ' * 8

    GLFW.GetFramebufferSize(@window, width_buf, height_buf)
    @screen_width = width_buf.unpack('L')[0]
    @screen_height = height_buf.unpack('L')[0]
  end

  def self.create_key_callbacks
    GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
       Input.key_callback(key, action)
    end
  end

  def self.set_opengl_version
    GLFW.WindowHint(GLFW::CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW::CONTEXT_VERSION_MINOR, 3)
    GLFW.WindowHint(GLFW::OPENGL_PROFILE, GLFW::OPENGL_CORE_PROFILE)
    GLFW.WindowHint(GLFW::OPENGL_FORWARD_COMPAT, GLFW::TRUE)
  end

  def self.screen_width
    @screen_width
  end

  def self.screen_height
    @screen_height
  end

  def self.debug_opengl_call
    until (error = GL.GetError) == 0
    end
    yield
    until (error = GL.GetError) == 0
      error = error.to_s(16)
    end
  end

  def self.print_opengl_version
    puts "OpenGL Version: #{GL.GetString(GL::VERSION)}"
    puts "GLSL Version: #{GL.GetString(GL::SHADING_LANGUAGE_VERSION)}"
  end
end
