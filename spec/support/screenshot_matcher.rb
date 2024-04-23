# spec/support/screenshot_matcher.rb

RSpec::Matchers.define :match_screenshot do |expected|
  match do |actual|
    expected_image = ChunkyPNG::Image.from_file(expected)
    actual_image = ChunkyPNG::Image.from_file(actual)

    return false unless actual_image.width == expected_image.width && actual_image.height == expected_image.height

    actual_image.pixels.each_with_index do |pixel, index|
      return false unless pixel == expected_image.pixels[index]
    end
    true
  end

  failure_message do |actual|
    "expected that #{actual} would match #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not match #{expected}"
  end
end