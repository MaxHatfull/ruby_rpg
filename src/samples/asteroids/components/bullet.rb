class Bullet < Component
  def start
    @image = Circle.new(x: game_object.x, y: game_object.y, radius: 3, color: 'white')
  end

  def update
    game_object.x, game_object.y = game_object.local_to_world_coordinate(0, -10)
    @image.x, @image.y = game_object.x, game_object.y
  end
end
