require 'opengl'
require 'glfw'
require_relative 'input'
require_relative 'renderer'
require_relative 'game_object'
require_relative 'component'

GLFW.load_lib("libglfw.dylib") # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
GLFW.Init()

module Engine
  def self.load(base_dir)
    Dir[File.join(base_dir, "components", "**/*.rb")].each { |file| require file }
  end

  def self.start(**args)
    @width = args[:width] || 640
    @height = args[:height] || 480

    open_widow
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

  def self.open_widow
    key_callback = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
      Input.key_callback(key, action)
    end

    @window = GLFW.CreateWindow(@width, @height, "Simple example", nil, nil)
    GLFW.MakeContextCurrent(@window)
    GLFW.SetKeyCallback(@window, key_callback)
    GL.load_lib()

    width_buf = ' ' * 8
    height_buf = ' ' * 8
    until GLFW.WindowShouldClose(@window) == GLFW::TRUE
      GLFW.GetFramebufferSize(@window, width_buf, height_buf)
      width = width_buf.unpack1('L')
      height = height_buf.unpack1('L')

      GL.Viewport(0, 0, width, height)
      GL.Clear(GL::COLOR_BUFFER_BIT)
      GL.MatrixMode(GL::PROJECTION)
      GL.LoadIdentity()
      GL.Ortho(0, width, 0, height, 1.0, -1.0)
      GL.MatrixMode(GL::MODELVIEW)

      GL.LoadIdentity()

      update

      GLFW.SwapBuffers(@window)
      GLFW.PollEvents()
    end

    GLFW.DestroyWindow(@window)
    GLFW.Terminate()
  end
end
