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
      va0_buf = ' ' * 4
      GL.GenVertexArrays(1, va0_buf)
      @vao = va0_buf.unpack('L')[0]

      vbo_buf = ' ' * 4
      GL.GenBuffers(1, vbo_buf)
      @vbo = vbo_buf.unpack('L')[0]

      @shader = Shader.new('./shaders/colour_vertex.glsl', './shaders/colour_frag.glsl')

      points = [
        v1[:x], v1[:y], 0,
        v2[:x], v2[:y], 0,
        v3[:x], v3[:y], 0
      ]

      GL.BindVertexArray(@vao)
      GL.BindBuffer(GL::ARRAY_BUFFER, @vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, 3 * 3 * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      ) # 3 vertices, 3 coordinates each

      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, 3 * Fiddle::SIZEOF_FLOAT, 0)
      GL.EnableVertexAttribArray(0)
    end

    def update(delta_time)
      GL.BindVertexArray(@vao)
      @shader.use
      @shader.set_vec3("colour", colour)
      @shader.set_mat4("camera", [
        2.0 / Engine.screen_width, 0, 0, 0,
        0, 2.0 / Engine.screen_height, 0, 0,
        0, 0, 1, 0,
        -1, -1, 0, 1
      ])
      @shader.set_mat4("model", game_object.model_matrix)
      GL.DrawArrays(GL::TRIANGLES, 0, 3)
      GL.BindVertexArray(0)
    end
  end
end