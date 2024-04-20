module Engine
  class SpriteRenderer < Component
    attr_accessor :image, :v1, :v2, :v3, :v4

    def initialize
      @image = nil
      @shader = Engine::Shader.new('./sprite_vertex.glsl', './sprite_frag.glsl')
      @v1 = { x: -10, y: -10 }
      @v2 = { x: -10, y: 10 }
      @v3 = { x: 10, y: 10 }
      @v4 = { x: 10, y: -10 }
    end

    def update(delta_time)
      world_v1 = game_object.local_to_world_coordinate(v1[:x], v1[:y])
      world_v2 = game_object.local_to_world_coordinate(v2[:x], v2[:y])
      world_v3 = game_object.local_to_world_coordinate(v3[:x], v3[:y])
      world_v4 = game_object.local_to_world_coordinate(v4[:x], v4[:y])
      points = [
        world_v1[:x], world_v1[:y], 0,
        world_v2[:x], world_v2[:y], 0,
        world_v3[:x], world_v3[:y], 0,

        world_v4[:x], world_v4[:y], 0,
        world_v1[:x], world_v1[:y], 0,
        world_v3[:x], world_v3[:y], 0,
      ]
      @shader.use

      vao_buff = ' ' * 4
      GL.GenVertexArrays(1, vao_buff)
      @vao = vao_buff.unpack('L')[0]
      GL.BindVertexArray(@vao)

      vbo_buf = ' ' * 4
      GL.GenBuffers(1, vbo_buf)
      @g_vbo = vbo_buf.unpack('L')[0]
      GL.BindBuffer(GL::ARRAY_BUFFER, @g_vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, points.count * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      )


      GL.VertexPointer(3, GL::FLOAT, 0, 0)
      GL.DrawArrays(GL::TRIANGLES, 0, 6)
    end
  end
end