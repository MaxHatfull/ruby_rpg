require 'ruby2d'
require_relative 'game_object'
require_relative 'component'
Dir[File.join(Dir.pwd, File.dirname(caller[0]), "components", "**/*.rb")].each { |file| require file }

class Engine
  def self.update
    GameObject.update_all
  end
end

update do
  Engine.update
end
