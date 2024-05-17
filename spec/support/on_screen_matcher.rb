# frozen_string_literal: true

RSpec::Matchers.define :be_on_screen_at do |screen_pos|
  match do |point|
    camera = Engine::Camera.instance
    return false unless camera

    actual_screen_pos = camera.matrix.transpose * Vector[point[0], point[1], point[2], 1]
    tolerance = 0.00001

    (actual_screen_pos[0] / actual_screen_pos[3] - screen_pos[0]).abs < tolerance &&
      (actual_screen_pos[1] / actual_screen_pos[3] - screen_pos[1]).abs < tolerance &&
      (actual_screen_pos[2] / actual_screen_pos[3] - screen_pos[2]).abs < tolerance
  end

  failure_message do |point|
    camera = Engine::Camera.instance
    return "expected a camera to be present" unless camera

    actual_screen_pos = camera.matrix.transpose * Vector[point[0], point[1], point[2], 1]
    w = actual_screen_pos[3]
    actual_screen_pos = Vector[actual_screen_pos[0], actual_screen_pos[1], actual_screen_pos[2]] / w
    "expected #{point} to be on the screen at #{screen_pos} but it was at #{actual_screen_pos} w = #{w}"
  end

  failure_message_when_negated do |point|
    camera = Engine::Camera.instance
    return "expected a camera to be present" unless camera

    actual_screen_pos = camera.matrix.transpose * Vector[point[0], point[1], point[2], 1]
    w = actual_screen_pos[3]
    actual_screen_pos = Vector[actual_screen_pos[0], actual_screen_pos[1], actual_screen_pos[2]] / w
    "expected #{point} not to be on the screen at #{screen_pos} but it was at #{actual_screen_pos}, w = #{w}"
  end
end
