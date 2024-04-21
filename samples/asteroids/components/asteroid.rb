class Asteroid < Engine::Component
  SPEED = 100

  attr_reader :size

  def initialize(size)
    @size = size
    @speed = Engine::Vector.new(SPEED, 0).rotate(rand * 360)
  end

  def self.asteroids
    @asteroids ||= []
  end

  def start
    Asteroid.asteroids << self
  end

  def destroy!
    Asteroid.asteroids.delete(self)
    game_object.destroy!
  end

  def update(delta_time)
    game_object.pos += @speed * delta_time
    clamp_to_screen
  end

  private

  def clamp_to_screen
    if game_object.x > Engine.screen_width
      game_object.x = 0
    elsif game_object.x < 0
      game_object.x = Engine.screen_width
    end
    if game_object.y > Engine.screen_height
      game_object.y = 0
    elsif game_object.y < 0
      game_object.y = Engine.screen_height
    end
  end
end