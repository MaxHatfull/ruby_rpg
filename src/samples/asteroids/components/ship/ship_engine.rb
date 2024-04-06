class ShipEngine < Component
  def start
    @image = Triangle.new
    @acceleration = 0
    @torque = 0
    @speed = 0

    Window.on(:key_down) do |event|
      case event.key
      when "left"
        @torque = -10
      when "right"
        @torque = 10
      when "up"
        @acceleration = 0.1
      end
    end

    Window.on(:key_up) do |event|
      case event.key
      when "left"
        @torque = 0
      when "right"
        @torque = 0
      when "up"
        @acceleration = -0.1
      end
    end
  end

  def update
    @speed += @acceleration
    @speed = 0 if @speed < 0
    @speed = 100 if @speed > 100
    game_object.rotation += @torque

    rotation = game_object.rotation * Math::PI / 180
    game_object.x += Math.sin(rotation) * @speed
    game_object.y -= Math.cos(rotation) * @speed
    game_object.x %= Window.width
    game_object.y %= Window.height

    @image.x1, @image.y1 = game_object.local_to_world_coordinate(0, - 40)
    @image.x2, @image.y2 = game_object.local_to_world_coordinate(-20, 40)
    @image.x3, @image.y3 = game_object.local_to_world_coordinate(20, 40)
  end
end