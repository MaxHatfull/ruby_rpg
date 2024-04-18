module TestDriver
  class TestDriverComponent < Engine::Component
    include RSpec::Matchers

    def initialize(&block)
      @instructions = block
      @timed_instructions = {}
      @tick = 0
      instance_eval(&block)
    end

    def update
      if @timed_instructions[@tick]
        @timed_instructions[@tick].call
      end

      @tick += 1
    end

    def at(tick, &block)
      @timed_instructions[tick] = block
    end
  end

  def within_game_context(&block)
    Engine.start(base_dir: "./samples/asteroids", title: 'Ruby RPG', width: 1920, height: 1080, background: 'navy') do
      GameObject.new("Test Driver", components: [TestDriverComponent.new(&block)])
    end
  end
end