module Engine
  class SpriteRenderer < Component
    attr_reader :v1, :v2, :v3, :v4, :texture, :frame_coords, :frame_rate, :loop

    def initialize(v1, v2, v3, v4, texture, frame_coords, frame_rate, loop = true)
      @v1 = v1
      @v2 = v2
      @v3 = v3
      @v4 = v4
      @texture = texture
      @colour = { r: 1, g: 1, b: 1.0 }
      @frame_coords = frame_coords
      @frame_rate = frame_rate
      @loop = loop
    end

    def start
      @start_time = Time.now

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
      @shader ||= Shader.new('./shaders/sprite_vertex.glsl', './shaders/sprite_frag.glsl')
    end

    def set_shader_per_frame_data
      set_shader_camera_matrix
      set_shader_model_matrix
      set_shader_texture
      set_shader_sprite_colour
      set_shader_frame_data
    end

    def set_shader_frame_data
      current_frame_index = (Time.now - @start_time) * @frame_rate
      current_frame_index = if @loop
                              current_frame_index.to_i % @frame_coords.length
                            else
                              [@frame_coords.length - 1, current_frame_index.to_i].min
                            end

      current_frame_coords =
        [
          @frame_coords[current_frame_index][:tl][:x],
          @frame_coords[current_frame_index][:tl][:y],
          @frame_coords[current_frame_index][:width],
          @frame_coords[current_frame_index][:height]
        ]
      pp current_frame_coords
      shader.set_vec4("frameCoords", current_frame_coords)
    end

    def set_shader_sprite_colour
      shader.set_vec3("spriteColor", @colour)
    end

    def set_shader_texture
      GL.ActiveTexture(GL::TEXTURE0)
      GL.BindTexture(GL::TEXTURE_2D, texture)
      shader.set_int("image", 0)
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
        v1[:x], v1[:y], 0, 0, 0,
        v2[:x], v2[:y], 0, 1, 0,
        v3[:x], v3[:y], 0, 1, 1,
        v4[:x], v4[:y], 0, 0, 1
      ]

      GL.BindBuffer(GL::ARRAY_BUFFER, vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, 4 * 5 * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      )

      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, 5 * Fiddle::SIZEOF_FLOAT, 0)
      GL.VertexAttribPointer(1, 2, GL::FLOAT, GL::FALSE, 5 * Fiddle::SIZEOF_FLOAT, 3 * Fiddle::SIZEOF_FLOAT)
      GL.EnableVertexAttribArray(0)
      GL.EnableVertexAttribArray(1)
    end
  end
end