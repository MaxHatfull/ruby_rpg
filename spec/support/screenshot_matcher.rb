# spec/support/screenshot_matcher.rb

RSpec::Matchers.define :match_screenshot do |expected|
  match do |actual|
    expected_image = ChunkyPNG::Image.from_file(expected)
    actual_image = ChunkyPNG::Image.from_file(actual)

    return false unless actual_image.width == expected_image.width && actual_image.height == expected_image.height

    diff_image = ChunkyPNG::Image.new(actual_image.width, actual_image.height, ChunkyPNG::Color::TRANSPARENT)

    failed = false
    actual_image.height.times do |y|
      actual_image.row(y).each_with_index do |pixel, x|
        if pixel == expected_image[x, y]
          diff_image[x, y] = pixel
        else
          diff_image[x, y] = ChunkyPNG::Color.rgb(255, 0, 0)
        end
        failed ||= pixel != expected_image[x, y]
      end
    end

    diff_location = File.join(File.dirname(actual), "diff_#{File.basename(actual)}")
    diff_image.save(diff_location) if failed
    !failed
  end

  failure_message do |actual|
    "expected that #{actual} would match #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not match #{expected}"
  end
end