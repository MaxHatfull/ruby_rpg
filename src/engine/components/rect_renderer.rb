module Engine::Components
  class RectRenderer < Engine::Component
    attr_reader :v1, :v2, :v3, :v4

    def initialize(v1, v2, v3, v4)
      @v1 = v1
      @v2 = v2
      @v3 = v3
      @v4 = v4
      @colour = { r: 1, g: 1, b: 0.5 }
    end

    def start
      setup_vertex_attribute_buffer
      setup_vertex_buffer
      setup_index_buffer
    end

    def update(delta_time)
      shader.use
      GL.BindVertexArray(@vao)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)

      set_shader_per_frame_data

      GL.DrawElements(GL::TRIANGLES, 6, GL::UNSIGNED_INT, 0)
      GL.BindVertexArray(0)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, 0)
    end

    private

    def shader
      @shader ||= Shader.new('./shaders/colour_vertex.glsl', './shaders/colour_frag.glsl')
    end

    def set_shader_per_frame_data
      shader.set_vec3("colour", @colour)
      set_shader_camera_matrix
      set_shader_model_matrix
    end

    def set_shader_model_matrix
      shader.set_mat4("model", game_object.model_matrix)
    end

    def set_shader_camera_matrix
      shader.set_mat4("camera", [
        2.0 / Engine::Window.framebuffer_width, 0, 0, 0,
        0, 2.0 / Engine::Window.framebuffer_height, 0, 0,
        0, 0, 1, 0,
        -1, -1, 0, 1
      ])
    end

    def setup_index_buffer
      indices = [
        0, 1, 2,
        2, 3, 0
      ]

      ebo_buf = ' ' * 4
      GL.GenBuffers(1, ebo_buf)
      @ebo = ebo_buf.unpack('L')[0]
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)
      GL.BufferData(
        GL::ELEMENT_ARRAY_BUFFER, 6 * Fiddle::SIZEOF_INT,
        indices.pack('I*'), GL::STATIC_DRAW
      )
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
        v3.x, v3.y, 0,
        v4.x, v4.y, 0
      ]

      GL.BindBuffer(GL::ARRAY_BUFFER, vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, 4 * 3 * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      )

      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, 3 * Fiddle::SIZEOF_FLOAT, 0)
      GL.EnableVertexAttribArray(0)
    end
  end
end
