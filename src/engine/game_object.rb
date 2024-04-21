module Engine
  class GameObject
    attr_accessor :name, :pos, :rotation, :components

    def initialize(name = "Game Object", pos: Vector.new(0, 0), rotation: 0, components: [])
      GameObject.object_spawned(self)

      @pos = pos
      @rotation = rotation
      @name = name
      @components = components

      components.each { |component| component.set_game_object(self) }
      components.each(&:start)
    end

    def x
      @pos.x
    end

    def x=(value)
      @pos = Vector.new(value, @pos.y)
    end

    def y
      @pos.y
    end

    def y=(value)
      @pos = Vector.new(@pos.x, value)
    end

    def local_to_world_coordinate(local_x, local_y)
      angle = Math::PI * @rotation / 180.0
      world_x = x + local_x * Math.cos(angle) - local_y * Math.sin(angle)
      world_y = y + local_x * Math.sin(angle) + local_y * Math.cos(angle)
      Vector.new(world_x, world_y)
    end

    def model_matrix
      theta = rotation * Math::PI / 180
      cos_theta = Math.cos(theta)
      sin_theta = Math.sin(theta)
      [
        cos_theta, sin_theta, 0, 0,
        -sin_theta, cos_theta, 0, 0,
        0, 0, 1, 0,
        x, y, 0, 1
      ]
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