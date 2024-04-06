require 'ruby2d'
require_relative 'game_object'
Dir[File.join(__dir__, "..", "objects", "**/*.rb")].each { |file| require file }

class Engine
  def self.update
    GameObject.update_all
  end
end

update do
  Engine.update
end
