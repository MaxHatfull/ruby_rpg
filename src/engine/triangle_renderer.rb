module Engine
  class TriangleRenderer < Component
    attr_reader :v1, :v2, :v3, :colour

    def initialize(v1, v2, v3, colour)
      @v1 = v1
      @v2 = v2
      @v3 = v3
      @colour = colour
    end

    def start
      setup_vertex_attribute_buffer
      setup_vertex_buffer
    end

    def update(delta_time)
      shader.use
      GL.BindVertexArray(@vao)

      set_shader_per_frame_data
      draw_array_data
    end

    private

    def shader
      @shader ||= Shader.new('./shaders/colour_vertex.glsl', './shaders/colour_frag.glsl')
    end

    def draw_array_data
      GL.DrawArrays(GL::TRIANGLES, 0, 3)
      GL.BindVertexArray(0)
    end

    def set_shader_per_frame_data
      shader.set_vec3("colour", colour)
      set_shader_camera_matrix
      set_shader_model_matrix
    end

    def set_shader_model_matrix
      shader.set_mat4("model", game_object.model_matrix)
    end

    def set_shader_camera_matrix
      shader.set_mat4("camera", [
        2.0 / Engine.screen_width, 0, 0, 0,
        0, 2.0 / Engine.screen_height, 0, 0,
        0, 0, 1, 0,
        -1, -1, 0, 1
      ])
    end

    def setup_vertex_attribute_buffer
      va0_buf = ' ' * 4
      GL.GenVertexArrays(1, va0_buf)
      @vao = va0_buf.unpack('L')[0]
      GL.BindVertexArray(@vao)
    end

    def setup_vertex_buffer
      vbo_buf = ' ' * 4
      GL.GenBuffers(1, vbo_buf)
      vbo = vbo_buf.unpack('L')[0]
      points = [
        v1.x, v1.y, 0,
        v2.x, v2.y, 0,
        v3.x, v3.y, 0
      ]

      GL.BindBuffer(GL::ARRAY_BUFFER, vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, 3 * 3 * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      )

      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, 3 * Fiddle::SIZEOF_FLOAT, 0)
      GL.EnableVertexAttribArray(0)
    end
  end
end