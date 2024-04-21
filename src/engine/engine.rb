require 'opengl'
require 'glfw'

require_relative 'input'
require_relative 'vector'
require_relative 'game_object'
require_relative 'texture'
require_relative 'shader'
require_relative 'component'
require_relative "triangle_renderer"
require_relative "sprite_renderer"
require_relative "rect_renderer"

GLFW.load_lib("libglfw.dylib") # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
GLFW.Init()

module Engine
  def self.load(base_dir)
    Dir[File.join(base_dir, "components", "**/*.rb")].each { |file| require file }
  end

  def self.start(**args, &block)
    @width = args[:width] || 640
    @height = args[:height] || 480

    open_widow(&block)
  end

  def self.close
    GLFW.SetWindowShouldClose(@window, 1)
  end

  def self.screenshot(file)
    raise "not implemented"
  end

  private

  def self.update
    @old_time = @time || Time.now
    @time = Time.now
    delta_time = @time - @old_time
    fps = 1 / delta_time
    # puts "FPS: #{fps}"
    GameObject.update_all(delta_time)
  end

  def self.open_widow(&first_frame_block)
    key_callback = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
      Input.key_callback(key, action)
    end

    GLFW.WindowHint(GLFW::CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW::CONTEXT_VERSION_MINOR, 3)
    GLFW.WindowHint(GLFW::OPENGL_PROFILE, GLFW::OPENGL_CORE_PROFILE)
    GLFW.WindowHint(GLFW::OPENGL_FORWARD_COMPAT, GLFW::TRUE)
    GLFW.WindowHint(GLFW::DECORATED, 0)

    @window = GLFW.CreateWindow(@width, @height, "Simple example", nil, nil)
    GLFW.MakeContextCurrent(@window)
    GLFW.SetKeyCallback(@window, key_callback)
    GL.load_lib()

    width_buf = ' ' * 8
    height_buf = ' ' * 8
    puts "OpenGL Version: #{GL.GetString(GL::VERSION)}"
    puts "GLSL Version: #{GL.GetString(GL::SHADING_LANGUAGE_VERSION)}"

    GL.Enable(GL::BLEND)
    GL.BlendFunc(GL::SRC_ALPHA, GL::ONE_MINUS_SRC_ALPHA)

    until GLFW.WindowShouldClose(@window) == GLFW::TRUE
      GLFW.GetFramebufferSize(@window, width_buf, height_buf)
      @screen_width = width_buf.unpack('L')[0]
      @screen_height = height_buf.unpack('L')[0]

      GL.Clear(GL::COLOR_BUFFER_BIT) # Clear the screen

      first_frame_block.call if first_frame_block && !@first_frame_block_called
      @first_frame_block_called = true
      update

      GLFW.SwapBuffers(@window)
      GLFW.PollEvents
    end

    GLFW.DestroyWindow(@window)
    GLFW.Terminate
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
      puts "OpenGL Error: #{error}" unless error == 0
    end
  end
end
