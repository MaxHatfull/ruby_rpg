module TestDriver
  class TestDriverComponent < Engine::Component
    include RSpec::Matchers
    include RSpec::Mocks

    def initialize(&block)
      @instructions = block
      @timed_instructions = {}
      instance_eval(&block)
    end

    def update(delta_time)
      if @timed_instructions[current_tick]
        @timed_instructions[current_tick].call
      end
      set_tick(current_tick + 1)
    end

    def at(tick, &block)
      @timed_instructions[tick] = block
    end
  end

  def set_tick(tick)
    $current_tick = tick
  end

  def current_tick
    $current_tick ||= 0
  end

  def within_game_context(frame_duration: 0.1, &block)
    set_tick(0)
    allow(Time).to(receive(:now)) { current_tick * frame_duration }
    if !Engine.engine_started?
      Engine.load("./samples/asteroids")
      Engine.open_window(800, 600)
    end
    Engine.main_game_loop do
      Engine::GameObject.new("Test Driver", components: [TestDriverComponent.new(&block)])
    end
  end
end