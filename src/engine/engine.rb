require 'opengl'
require 'glfw'
require 'concurrent'
require 'os'
require "freetype"
require "rmagick"

require_relative 'screenshoter'
require_relative 'input'
require_relative "quaternion"
require_relative 'game_object'
require_relative 'texture'
require_relative 'material'
require_relative 'mesh'
require_relative "font"
require_relative 'path'
require_relative 'polygon_mesh'
require_relative 'importers/obj_file'
require_relative 'tangent_calculator'
require_relative 'shader'
require_relative 'component'
require_relative "camera"

require_relative "components/orthographic_camera"
require_relative "components/perspective_camera"
require_relative "components/triangle_renderer"
require_relative "components/sprite_renderer"
require_relative "components/ui_sprite_renderer"
require_relative "components/rect_renderer"
require_relative "components/mesh_renderer"
require_relative "components/font_renderer"
require_relative "components/ui_font_renderer"
require_relative "components/point_light"
require_relative "components/direction_light"

require_relative "physics/physics_resolver"
require_relative 'physics/collision'
require_relative "physics/components/sphere_collider"
require_relative "physics/components/cube_collider"
require_relative "physics/components/rigidbody"

if OS.windows?
  GLFW.load_lib(File.expand_path(File.join(__dir__, "..", "..", "glfw-3.4.bin.WIN64", "lib-static-ucrt", "glfw3.dll")))
elsif OS.mac?
  GLFW.load_lib("libglfw.dylib") # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
end
GLFW.Init

module Engine
  def self.start(width: 600, height: 800, base_dir:, &first_frame_block)
    load(base_dir)
    return if ENV["BUILDING"] == "true"
    open_window(width, height)
    main_game_loop(&first_frame_block)
    terminate
  end

  def self.engine_started?
    @engine_started
  end

  def self.load(base_dir)
    base_dir = File.expand_path(base_dir)
    Dir[File.join(base_dir, "components", "**/*.rb")].each { |file| require file }
    Dir[File.join(base_dir, "game_objects", "**/*.rb")].each { |file| require file }
  end

  def self.open_window(width, height)
    set_opengl_version
    @old_time = Time.now
    @time = Time.now
    GLFW.WindowHint(GLFW::DECORATED, 0)
    @key_callback = create_key_callbacks # This must be an instance variable to prevent garbage collection
    primary_monitor = GLFW.GetPrimaryMonitor

    @window = GLFW.CreateWindow(width, height, "Ruby RPG", primary_monitor, nil)
    GLFW.MakeContextCurrent(@window)
    GLFW.SetKeyCallback(@window, @key_callback)
    GL.load_lib

    set_opengl_blend_mode
    @engine_started = true
    GL.ClearColor(0.0, 0.0, 0.0, 1.0)

    GL.Enable(GL::CULL_FACE)
    GL.CullFace(GL::BACK)

    GLFW.SwapInterval(0)

    # lock cursor
    GLFW.SetInputMode(@window, GLFW::CURSOR, GLFW::CURSOR_DISABLED)
  end

  def self.main_game_loop(&first_frame_block)
    @game_stopped = false
    @old_time = Time.now
    @time = Time.now
    @fps = 0
    update_screen_size
    GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)

    until GLFW.WindowShouldClose(@window) == GLFW::TRUE || @game_stopped
      if first_frame_block
        first_frame_block.call
        first_frame_block = nil
      end

      @old_time = @time || Time.now
      @time = Time.now
      delta_time = @time - @old_time

      print_fps(delta_time)
      Physics::PhysicsResolver.resolve
      GameObject.update_all(delta_time)

      @swap_buffers_promise.wait! if @swap_buffers_promise
      GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
      GL.Enable(GL::DEPTH_TEST)
      GL.DepthFunc(GL::LESS)

      GameObject.render_all(delta_time)

      GL.Disable(GL::DEPTH_TEST)
      GameObject.render_ui(delta_time)

      if Screenshoter.scheduled_screenshot
        Screenshoter.take_screenshot
      end
      update_screen_size

      if OS.windows?
        GLFW.SwapBuffers(@window)
      else
        @swap_buffers_promise = Concurrent::Promise.new do
          GLFW.SwapBuffers(@window)
        end
        @swap_buffers_promise.execute
      end

      GLFW.PollEvents
    end
  end

  def self.fps
    @fps
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
    @swap_buffers_promise.wait! if @swap_buffers_promise && !@swap_buffers_promise.complete?
    GameObject.destroy_all
  end

  private

  def self.print_fps(delta_time)
    @time_since_last_fps_print = (@time_since_last_fps_print || 0) + delta_time
    @frame = (@frame || 0) + 1
    if @time_since_last_fps_print > 1
      @fps = @frame / @time_since_last_fps_print
      puts "FPS: #{@fps}"
      @time_since_last_fps_print = 0
      @frame = 0
    end
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
    errors = []
    until GL.GetError == 0; end
    yield
    until (error = GL.GetError) == 0
      errors += error.to_s(16)
    end
  end

  def self.print_opengl_version
    puts "OpenGL Version: #{GL.GetString(GL::VERSION)}"
    puts "GLSL Version: #{GL.GetString(GL::SHADING_LANGUAGE_VERSION)}"
  end
end
