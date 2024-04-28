require "matrix"

module Engine
  class GameObject
    attr_accessor :name, :pos, :rotation, :scale, :components, :created_at

    def initialize(name = "Game Object", pos: Vector[0, 0, 0], rotation: 0, scale: Vector[1, 1, 1], components: [])
      GameObject.object_spawned(self)
      @pos = Vector[pos[0], pos[1], pos[2] || 0]
      if rotation.is_a?(Numeric)
        @rotation = Vector[0, 0, rotation]
      else
        @rotation = rotation
      end
      @scale = scale
      @name = name
      @components = components
      @created_at = Time.now

      components.each { |component| component.set_game_object(self) }
      components.each(&:start)
    end

    def x
      @pos[0]
    end

    def x=(value)
      @pos = Vector[value, y, z]
    end

    def y
      @pos[1]
    end

    def y=(value)
      @pos = Vector[x, value, z]
    end

    def z
      @pos[2]
    end

    def z=(value)
      @pos = Vector[x, y, value]
    end

    def local_to_world_coordinate(local)
      local_x4 = Vector[local[0], local[1], local[2], 1.0]
      world = model_matrix.transpose * local_x4
      world = world.to_a.flatten
      Vector[world[0], world[1], world[2]]
    end

    def local_to_world_direction(local)
      local_to_world_coordinate(local) - pos
    end

    def model_matrix
      rot = rotation * Math::PI / 180

      # Apply translation
      translation_matrix = Matrix[
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [x, y, z, 1]
      ]

      # Apply rotation
      rot_x = Matrix[[1, 0, 0, 0], [0, Math.cos(rot[0]), -Math.sin(rot[0]), 0], [0, Math.sin(rot[0]), Math.cos(rot[0]), 0], [0, 0, 0, 1]]
      rot_y = Matrix[[Math.cos(rot[1]), 0, Math.sin(rot[1]), 0], [0, 1, 0, 0], [-Math.sin(rot[1]), 0, Math.cos(rot[1]), 0], [0, 0, 0, 1]]
      rot_z = Matrix[[Math.cos(rot[2]), -Math.sin(rot[2]), 0, 0], [Math.sin(rot[2]), Math.cos(rot[2]), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]

      # Apply scale
      scale_matrix = Matrix[[scale[0], 0, 0, 0], [0, scale[1], 0, 0], [0, 0, scale[2], 0], [0, 0, 0, 1]]

      rot_x * rot_y * rot_z * scale_matrix * translation_matrix
    end

    def destroy!
      GameObject.objects.delete(self)
    end

    def self.destroy_all
      GameObject.objects.dup.each(&:destroy!)
    end

    def self.update_all(delta_time)
      GameObject.objects.each do |object|
        object.components.each { |component| component.update(delta_time) }
      end
    end

    def self.object_spawned(object)
      objects << object
    end

    def self.objects
      @objects ||= []
    end
  end
end