class GameObject
  attr_accessor :name, :x, :y, :components

  def initialize(name = "Game Object", x: 0, y: 0, components: [])
    GameObject.object_spawned(self)
    @x = x
    @y = y
    @name = name
    @components = components
    components.each { |component| component.set_game_object(self) }
    components.each(&:start)
  end

  def self.update_all
    GameObject.objects.each do |object|
      object.components.each(&:update)
    end
  end

  def self.object_spawned(object)
    @objects ||= []
    @objects << object
  end

  def self.objects
    @objects
  end
end