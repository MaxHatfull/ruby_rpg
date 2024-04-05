class GameObject
  attr_accessor :x, :y

  def self.update_all
    ObjectSpace.each_object(self) do |object|
      object.update
    end
  end

  def update
  end
end