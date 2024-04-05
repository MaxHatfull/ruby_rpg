class GameObject
  attr_accessor :x, :y

  def initialize(*args)
    GameObject.object_spawned(self)
  end

  def self.update_all
    GameObject.objects.each(&:update)
  end

  def update
  end

  private

  def self.object_spawned(object)
    @objects ||= []
    @objects << object
  end

  def self.objects
    @objects
  end
end