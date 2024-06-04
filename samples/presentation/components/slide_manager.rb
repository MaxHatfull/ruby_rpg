# frozen_string_literal: true

module Presentation
  class SlideManager < Engine::Component
    def initialize
      @slide_modules = [
        Slide0,
        Slide1,
        Slide2,
        Slide3,
        Slide4,
        Slide5,
        Slide6
      ]

      @current_slide = 0
      @slide = @slide_modules[@current_slide].create
    end

    def update(delta_time)
      if Engine::Input.key_down?(GLFW::KEY_1)
        new_slide = 0
      elsif Engine::Input.key_down?(GLFW::KEY_2)
        new_slide = 1
      elsif Engine::Input.key_down?(GLFW::KEY_3)
        new_slide = 2
      elsif Engine::Input.key_down?(GLFW::KEY_4)
        new_slide = 3
      elsif Engine::Input.key_down?(GLFW::KEY_5)
        new_slide = 4
      elsif Engine::Input.key_down?(GLFW::KEY_6)
        new_slide = 5
      elsif Engine::Input.key_down?(GLFW::KEY_7)
        new_slide = 6
      end

      if !new_slide.nil? && new_slide != @current_slide
        @slide.destroy!
        @current_slide = new_slide
        @slide = @slide_modules[@current_slide].create
      end
    end
  end
end
