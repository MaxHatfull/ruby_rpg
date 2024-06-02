module Engine::Components
  class MeshRenderer < Engine::Component
    attr_reader :mesh, :texture, :normal_texture, :specular_strength, :diffuse_strength, :specular_power, :ambient_light

    def renderer?
      true
    end

    def initialize(mesh, texture, normal_texture: nil, specular_strength: 1, diffuse_strength: 0.5, specular_power: 32.0, ambient_light: Vector[0.1, 0.1, 0.1])
      @mesh = mesh
      @texture = texture
      @normal_texture = normal_texture
      @specular_strength = specular_strength
      @diffuse_strength = diffuse_strength
      @specular_power = specular_power
      @ambient_light = ambient_light
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

      GL.DrawElements(GL::TRIANGLES, mesh.index_data.length, GL::UNSIGNED_INT, 0)
      GL.BindVertexArray(0)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, 0)
    end

    private

    def shader
      @shader ||= Engine::Shader.new('./shaders/mesh_vertex.glsl', './shaders/mesh_frag.glsl')
    end

    def set_shader_per_frame_data
      set_shader_camera_matrix
      set_shader_camera_pos
      set_shader_model_matrix
      set_shader_texture
      set_shader_lights
    end

    def set_shader_lights
      Engine::Components::PointLight.point_lights.each_with_index do |light, i|
        shader.set_float("pointLights[#{i}].sqrRange", light.range * light.range)
        shader.set_vec3("pointLights[#{i}].position", light.game_object.pos)
        shader.set_vec3("pointLights[#{i}].colour", light.colour)
      end
      Engine::Components::DirectionLight.direction_lights.each_with_index do |light, i|
        shader.set_vec3("directionalLights[#{i}].direction", light.game_object.forward)
        shader.set_vec3("directionalLights[#{i}].colour", light.colour)
      end
      shader.set_float("diffuseStrength", diffuse_strength)
      shader.set_float("specularStrength", specular_strength)
      shader.set_float("specularPower", specular_power)
      shader.set_vec3("ambientLight", ambient_light)
    end

    def set_shader_texture
      GL.ActiveTexture(GL::TEXTURE0)
      GL.BindTexture(GL::TEXTURE_2D, texture)
      shader.set_int("image", 0)
      GL.ActiveTexture(GL::TEXTURE1)
      GL.BindTexture(GL::TEXTURE_2D, normal_texture)
      shader.set_int("normalMap", 1)
    end

    def set_shader_model_matrix
      shader.set_mat4("model", game_object.model_matrix)
    end

    def set_shader_camera_matrix
      shader.set_mat4("camera", Engine::Camera.instance.matrix)
    end

    def set_shader_camera_pos
      shader.set_vec3("cameraPos", Engine::Camera.instance.game_object.pos)
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
