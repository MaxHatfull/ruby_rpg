class Bullet < Component
  def start
    @image = Circle.new(x: game_object.x, y: game_object.y, radius: 3, color: 'white')
  end

  def update
    @image.y -= 5
  end
end
