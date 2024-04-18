require 'opengl'
require 'glfw'
require_relative 'game_object'
require_relative 'component'

GLFW.load_lib("libglfw.dylib") # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
GLFW.Init()

class Engine
  def self.load(base_dir)
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

  def self.draw_triangle(v1, c1, v2, c2, v3, c3)
    GL.Begin(GL::TRIANGLES)
    GL.Color3f(c1[:r], c1[:g], c1[:b])
    GL.Vertex3f(v1[:x], v1[:y], v1[:z] || 0.0)
    GL.Color3f(c2[:r], c2[:g], c2[:b])
    GL.Vertex3f(v2[:x], v2[:y], v2[:z] || 0.0)
    GL.Color3f(c3[:r], c3[:g], c3[:b])
    GL.Vertex3f(v3[:x], v3[:y], v3[:z] || 0.0)
    GL.End()
  end

  def self.draw_circle(x, y, radius, r: 1, g: 1, b: 1)
    GL.Begin(GL::TRIANGLE_FAN)
    GL.Color3f(r, g, b)
    GL.Vertex2f(x, y)
    0.step(to: 360, by: 30) do |i|
      angle = i * Math::PI / 180
      GL.Vertex2f(x + Math.cos(angle) * radius, y + Math.sin(angle) * radius)
    end
    GL.End()
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
