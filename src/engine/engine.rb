require 'ruby2d'
require_relative 'game_object'
Dir[File.join(__dir__, "..", "objects", "**/*.rb")].each { |file| require file }

update do
  GameObject.update_all
end
