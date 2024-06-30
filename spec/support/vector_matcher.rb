# frozen_string_literal: true

RSpec::Matchers.define :be_vector do |expected, tolerance: 0.00001|
  match do |actual|
    (expected - actual).magnitude < tolerance
  end

  failure_message do |actual|
    "expected that #{actual} would be equal to #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not be equal to #{expected}"
  end
end
