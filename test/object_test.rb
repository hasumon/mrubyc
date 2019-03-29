# frozen_string_literal: true

class ObjectTest < MrubycTestCase

  description 'Object class'
  def all

# nil?
assert_equal true,  nil.nil?
assert_equal false, true.nil?
assert_equal false, false.nil?
  end
end
