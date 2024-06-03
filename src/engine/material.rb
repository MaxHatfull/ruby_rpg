# frozen_string_literal: true

module Engine
  class Material
    def initialize(shader)
      @shader = shader
    end

    def set_mat4(name, value)
      @mat4s ||= {}
      @mat4s[name] = value
    end

    def set_vec3(name, value)
      @vec3s ||= {}
      @vec3s[name] = value
    end

    def set_float(name, value)
      @floats ||= {}
      @floats[name] = value
    end

    def set_texture(name, value)
      @textures ||= {}
      @textures[name] = value
    end

    def update_shader
      shader.use
      update_light_data!

      @mat4s.each do |name, value|
        shader.set_mat4(name, value)
      end
      @vec3s.each do |name, value|
        shader.set_vec3(name, value)
      end
      @floats.each do |name, value|
        shader.set_float(name, value)
      end
      @textures.each.with_index do |(name, value), slot|
        GL.ActiveTexture(const_get("GL::TEXTURE#{slot}"))
        GL.BindTexture(GL::TEXTURE_2D, value)
        shader.set_int(name, slot)
      end
    end

    private

    def update_light_data!
      Engine::Components::PointLight.point_lights.each_with_index do |light, i|
        set_float("pointLights[#{i}].sqrRange", light.range * light.range)
        set_vec3("pointLights[#{i}].position", light.game_object.pos)
        set_vec3("pointLights[#{i}].colour", light.colour)
      end
      Engine::Components::DirectionLight.direction_lights.each_with_index do |light, i|
        set_vec3("directionalLights[#{i}].direction", light.game_object.forward)
        set_vec3("directionalLights[#{i}].colour", light.colour)
      end
    end
  end
end
