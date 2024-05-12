# frozen_string_literal: true

# spec/support/screenshot_matcher.rb

RSpec::Matchers.define :be_on_screen_at do |screen_pos|
  match do |point|
    camera = Engine::Camera.instance
    return false unless camera

    actual_screen_pos = camera.matrix.transpose * Vector[point[0], point[1], point[2], 1]
    tolerance = 0.00001

    return false if screen_pos.to_a.length == 3 && (actual_screen_pos[2] - screen_pos[2]) > tolerance
    (actual_screen_pos[0] - screen_pos[0]).abs < tolerance &&
      (actual_screen_pos[1] - screen_pos[1]).abs < tolerance
  end

  failure_message do |point|
    camera = Engine::Camera.instance
    return "expected a camera to be present" unless camera

    actual_screen_pos = camera.matrix.transpose * Vector[point[0], point[1], point[2], 1]
    actual_screen_pos = Vector[actual_screen_pos[0], actual_screen_pos[1], actual_screen_pos[2]]
    "expected #{point} to be on the screen at #{screen_pos} but it was at #{actual_screen_pos}"
  end

  failure_message_when_negated do |point|
    camera = Engine::Camera.instance
    return "expected a camera to be present" unless camera

    actual_screen_pos = camera.matrix.transpose * Vector[point[0], point[1], point[2], 1]
    actual_screen_pos = Vector[actual_screen_pos[0], actual_screen_pos[1], actual_screen_pos[2]]
    "expected #{point} not to be on the screen at #{screen_pos} but it was at #{actual_screen_pos}"
  end
end
