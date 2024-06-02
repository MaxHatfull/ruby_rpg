require "matrix"

module Engine
  class GameObject
    attr_accessor :name, :pos, :rotation, :scale, :components, :renderers, :ui_renderers, :created_at, :parent

    def initialize(name = "Game Object", pos: Vector[0, 0, 0], rotation: 0, scale: Vector[1, 1, 1], components: [], parent: nil)
      GameObject.object_spawned(self)
      @pos = Vector[pos[0], pos[1], pos[2] || 0]
      if rotation.is_a?(Numeric)
        @rotation = Vector[0, 0, rotation]
      else
        @rotation = rotation
      end
      @scale = scale
      @name = name
      @components = components.select { |component| !component.renderer? && !component.ui_renderer? }
      @renderers = components.select { |component| component.renderer? }
      @ui_renderers = components.select { |component| component.ui_renderer? }
      @created_at = Time.now
      @parent = parent
      parent.add_child(self) if parent

      components.each { |component| component.set_game_object(self) }
      components.each(&:start)
    end

    def children
      @children ||= Set.new
    end

    def add_child(child)
      child.parent = self
      children << child
    end

    def parent=(parent)
      @parent.children.delete(self) if @parent
      @parent = parent
      parent.children << self if parent
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
      local_x4 = Matrix[[local[0], local[1], local[2], 1.0]]
      world = local_x4 * model_matrix
      Vector[world[0, 0], world[0, 1], world[0, 2]]
    end

    def local_to_world_direction(local)
      local_to_world_coordinate(local) - pos
    end

    def model_matrix
      cache_key = [@pos.dup, @rotation.dup, @scale.dup, @parent&.model_matrix&.to_a]
      @model_matrix = nil if @model_matrix_cache_key != cache_key
      @model_matrix_cache_key = cache_key
      @model_matrix ||=
        begin
          rot = rotation * Math::PI / 180

          cos_x = Math.cos(rot[0])
          cos_y = Math.cos(rot[1])
          cos_z = Math.cos(rot[2])

          sin_x = Math.sin(rot[0])
          sin_y = Math.sin(rot[1])
          sin_z = Math.sin(rot[2])

          Matrix[
            [scale[0] * (cos_y * cos_z), scale[0] * (-cos_y * sin_z), scale[0] * sin_y, 0],
            [scale[1] * (cos_x * sin_z + sin_x * sin_y * cos_z), scale[1] * (cos_x * cos_z - sin_x * sin_y * sin_z), scale[1] * -sin_x * cos_y, 0],
            [scale[2] * (sin_x * sin_z - cos_x * sin_y * cos_z), scale[2] * (sin_x * cos_z + cos_x * sin_y * sin_z), scale[2] * cos_x * cos_y, 0],
            [x, y, z, 1]
          ]
        end
      if parent
        @model_matrix * parent.model_matrix
      else
        @model_matrix
      end
    end

    def destroy!
      GameObject.objects.delete(self)
      parent.children.delete(self) if parent
      children.each(&:destroy!)
    end

    def up
      return @up if @cached_up_rotation == rotation
      @cached_up_rotation = rotation.dup
      @up = local_to_world_direction(Vector[0, 1, 0])
    end

    def right
      return @right if @cached_right_rotation == rotation
      @cached_right_rotation = rotation.dup
      @right = local_to_world_direction(Vector[1, 0, 0])
    end

    def forward
      return @forward if @cached_forward_rotation == rotation
      @cached_forward_rotation = rotation.dup
      @forward = local_to_world_direction(Vector[0, 0, 1])
    end

    def self.destroy_all
      GameObject.objects.dup.each(&:destroy!)
    end

    def self.update_all(delta_time)
      GameObject.objects.each do |object|
        object.components.each { |component| component.update(delta_time) }
      end
    end

    def self.render_all(delta_time)
      GameObject.objects.each do |object|
        object.renderers.each { |renderer| renderer.update(delta_time) }
      end
    end

    def self.render_ui(delta_time)
      GameObject.objects.each do |object|
        object.ui_renderers.each { |renderer| renderer.update(delta_time) }
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
