require 'opengl'
require 'glfw'
require_relative 'game_object'
require_relative 'component'

GLFW.load_lib("libglfw.dylib") # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
GLFW.Init()

class Engine
  def self.load(**args)
    base_dir = args[:base_dir] || File.join(Dir.pwd, File.dirname(caller[0]))
    Dir[File.join(base_dir, "components", "**/*.rb")].each { |file| require file }
  end

  def self.start(**args)
    @width = args[:width] || 640
    @height = args[:height] || 480
    @keys = {}

    open_widow
  end

  def self.close
    GLFW.SetWindowShouldClose(@window, 1)
  end

  def self.key_down?(key)
    @keys[key]
  end

  def self.screenshot(file)
    raise "not implemented"
  end

  def self.draw_triangle(x1, y1, x2, y2, x3, y3)
    GL.Begin(GL::TRIANGLES)
    GL.Color3f(1.0, 0.0, 0.0)
    GL.Vertex3f(x1, y1, 0.0)
    GL.Color3f(0.0, 1.0, 0.0)
    GL.Vertex3f(x2, y2, 0.0)
    GL.Color3f(0.0, 0.0, 1.0)
    GL.Vertex3f(x3, y3, 0.0)
    GL.End()
  end

  private

  def self.update
    GameObject.update_all
  end

  def self.on_key_down(key)
    @keys[key] = true
    if key == GLFW::KEY_ESCAPE
      close
    end
  end

  def self.on_key_up(key)
    @keys[key] = false
  end

  def self.open_widow
    key_callback = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
      if action == GLFW::GLFW_PRESS
        on_key_down(key)
      end
      if action == GLFW::GLFW_RELEASE
        on_key_up(key)
      end
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
