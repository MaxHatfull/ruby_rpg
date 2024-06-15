# frozen_string_literal: true

module Engine::Components
  class MeshRenderer < Engine::Component
    attr_reader :mesh, :material, :texture, :normal_texture

    def renderer?
      true
    end

    def initialize(mesh, material)
      @mesh = mesh
      @material = material
    end

    def start
      setup_vertex_attribute_buffer
      setup_vertex_buffer
      setup_index_buffer
    end

    def update(delta_time)
      set_shader_per_frame_data

      GL.BindVertexArray(@vao)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)

      GL.DrawElements(GL::TRIANGLES, mesh.index_data.length, GL::UNSIGNED_INT, 0)
      GL.BindVertexArray(0)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, 0)
    end

    private

    def shader
      @shader ||= Engine::Shader.new('./shaders/mesh_vertex.glsl', './shaders/mesh_frag.glsl')
    end

    def set_shader_per_frame_data
      material.set_mat4("camera", Engine::Camera.instance.matrix)
      material.set_mat4("model", game_object.model_matrix)
      material.set_vec3("cameraPos", Engine::Camera.instance.game_object.pos)

      material.update_shader
    end

    def setup_index_buffer
      indices = mesh.index_data

      ebo_buf = ' ' * 4
      GL.GenBuffers(1, ebo_buf)
      @ebo = ebo_buf.unpack('L')[0]
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)
      GL.BufferData(
        GL::ELEMENT_ARRAY_BUFFER, indices.length * Fiddle::SIZEOF_INT,
        indices.pack('I*'), GL::STATIC_DRAW
      )
    end

    def setup_vertex_attribute_buffer
      vao_buf = ' ' * 4
      GL.GenVertexArrays(1, vao_buf)
      @vao = vao_buf.unpack('L')[0]
      GL.BindVertexArray(@vao)
    end

    def setup_vertex_buffer
      vbo_buf = ' ' * 4
      GL.GenBuffers(1, vbo_buf)
      vbo = vbo_buf.unpack('L')[0]
      points = mesh.vertex_data

      GL.BindBuffer(GL::ARRAY_BUFFER, vbo)
      GL.BufferData(
        GL::ARRAY_BUFFER, @mesh.vertex_data.length * Fiddle::SIZEOF_FLOAT,
        points.pack('F*'), GL::STATIC_DRAW
      )

      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, 11 * Fiddle::SIZEOF_FLOAT, 0)
      GL.VertexAttribPointer(1, 2, GL::FLOAT, GL::FALSE, 11 * Fiddle::SIZEOF_FLOAT, 3 * Fiddle::SIZEOF_FLOAT)
      GL.VertexAttribPointer(2, 3, GL::FLOAT, GL::FALSE, 11 * Fiddle::SIZEOF_FLOAT, 5 * Fiddle::SIZEOF_FLOAT)
      GL.VertexAttribPointer(3, 3, GL::FLOAT, GL::FALSE, 11 * Fiddle::SIZEOF_FLOAT, 8 * Fiddle::SIZEOF_FLOAT)
      GL.EnableVertexAttribArray(0)
      GL.EnableVertexAttribArray(1)
      GL.EnableVertexAttribArray(2)
      GL.EnableVertexAttribArray(3)
    end
  end
end
