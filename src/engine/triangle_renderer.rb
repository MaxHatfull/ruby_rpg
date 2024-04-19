module Engine
  class TriangleRenderer
    def initialize
      vbo_buf = ' ' * 4
      GL.GenBuffers(1, vbo_buf)
      @g_vbo = vbo_buf.unpack('L')[0] # get the buffer id
    end

    def draw(v1, v2, v3, colour)
      GL.Color3f(colour[:r], colour[:g], colour[:b])

      points = [v1[:x], v1[:y], v1[:z] || 0.0,
                v2[:x], v2[:y], v2[:z] || 0.0,
                v3[:x], v3[:y], v3[:z] || 0.0]

      GL.BindBuffer(GL::ARRAY_BUFFER, @g_vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, 3 * 3 * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      ) # 3 vertices, 3 coordinates each

      GL.EnableClientState(GL::VERTEX_ARRAY)
      GL.VertexPointer(3, GL::FLOAT, 0, 0)
      GL.DrawArrays(GL::TRIANGLES, 0, 3)
    end
  end
end