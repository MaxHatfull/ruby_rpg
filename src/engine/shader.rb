module Engine
  class Shader
    def initialize(vertex_shader, fragment_shader)
      @vertex_shader = compile_shader(vertex_shader, GL::VERTEX_SHADER)
      @fragment_shader = compile_shader(fragment_shader, GL::FRAGMENT_SHADER)
      @program = GL.CreateProgram
      GL.AttachShader(@program, @vertex_shader)
      GL.AttachShader(@program, @fragment_shader)
      GL.LinkProgram(@program)

      linked_buf = ' ' * 4
      GL.GetProgramiv(@program, GL::LINK_STATUS, linked_buf)
      linked = linked_buf.unpack('L')[0]
      if linked == 0
        compile_log = ' ' * 1024
        GL.GetProgramInfoLog(@program, 1023, nil, compile_log)
        vertex_log = ' ' * 1024
        GL.GetShaderInfoLog(@vertex_shader, 1023, nil, vertex_log)
        fragment_log = ' ' * 1024
        GL.GetShaderInfoLog(@fragment_shader, 1023, nil, fragment_log)
        puts "Shader program failed to link"
        puts compile_log.strip
        puts vertex_log.strip
        puts fragment_log.strip
      end
    end

    def compile_shader(shader, type)
      handle = GL.CreateShader(type)
      path = File.join(File.dirname(__FILE__), shader)
      s_srcs = [File.read(path)].pack('p')
      s_lens = [File.size(path)].pack('I')
      GL.ShaderSource(handle, 1, s_srcs, s_lens)
      GL.CompileShader(handle)
      handle
    end

    def use
      GL.UseProgram(@program)
    end
  end
end