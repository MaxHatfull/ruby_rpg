require_relative "../../engine/engine"

set title: 'Ruby RPG'
set width: 1920, height: 1080, background: 'navy', fullscreen: true

GameObject.new("Ship", x: 100, y: 100,
               components:
                 [ShipEngine.new, Gun.new]
)

on :key do |e|
  if e.key == 'escape'
    close
  end
end

show
