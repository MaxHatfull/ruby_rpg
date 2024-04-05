require 'ruby2d'
require_relative 'objects/game_object'
require_relative 'objects/bullet'
require_relative "objects/ship"

set title: 'Ruby RPG'
set width: 1920, height: 1080, background: 'navy', fullscreen: true

ship = Ship.new

on :mouse_down do |e|
  if e.button == :left
    Bullet.new(e.x, e.y) if e.button == :left
  end
end

on :key do |e|
  if e.key == 'escape'
    close
  end
end

update do
  GameObject.update_all
end

show
