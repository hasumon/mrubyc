# frozen_string_literal: true

class FixnumTest < MrubycTestCase

  description 'Fixnum'
  def all

#
# test Fixnum methods
#

# abs
assert_equal 12, 12.abs
assert_equal 34.56, (-34.56).abs
assert_equal 34.56, -34.56.abs


# chr
assert_equal "A", 65.chr


# times
i = 0
10.times {
  i += 1
}
assert_equal 10, i


# to_f
assert_equal( 10.0, 10.to_f )
assert_equal( -10.0, -10.to_f )


# to_i
assert_equal( 10, 10.to_i )
assert_equal( -10, -10.to_i )


# to_s
assert_equal( "10", 10.to_s )
assert_equal( "1010", 10.to_s(2) )
assert_equal( "12", 10.to_s(8) )
assert_equal( "a", 10.to_s(16) )
assert_equal( "z", 35.to_s(36) )

assert_equal( "-1", -1.to_s )
assert_equal( "-10", -10.to_s )
assert_equal( "-15wx", -54321.to_s(36) )

  end
end
