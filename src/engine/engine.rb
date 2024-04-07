require 'ruby2d'
require_relative 'game_object'
require_relative 'component'

class Engine
  def self.start(**args, &block)
    base_dir = args[:base_dir] || File.join(Dir.pwd, File.dirname(caller[0]))
    Dir[File.join(base_dir, "components", "**/*.rb")].each { |file| require file }

    Ruby2D::Window::set(**args)
    block.call
    Ruby2D::Window::show
  end

  def self.close
    Ruby2D::Window::close
  end

  def self.screenshot(file)
    Ruby2D::Window.screenshot(file)
  end

  Ruby2D::Window.update do
    GameObject.update_all
  end

  Ruby2D::Window.on :key do |e|
    if e.key == 'escape'
      close
    end
  end
end
