require 'ruby2d'
require_relative "game_object"
Dir[File.join(__dir__, 'objects', '*.rb')].each { |file| require file }

set title: 'Ruby RPG'
set width: 1920, height: 1080, background: 'navy', fullscreen: true

Ship.new

on :key do |e|
  if e.key == 'escape'
    close
  end
end

update do
  GameObject.update_all
end

show
