# frozen_string_literal: true

class NilClassTest < MrubycTestCase

  description 'NilClass class'
  def all

# coding: utf-8

assert_equal( true,  nil.nil? )

assert_equal( 0,   nil.to_i )
assert_equal( "",  nil.to_s )
assert_equal( 0.0, nil.to_f )
assert_equal( [],  nil.to_a )
assert_equal( {},  nil.to_h )

#assert_equal( false, nil & true )
#assert_equal( false, nil & false )
#assert_equal( true,  nil ^ true )
#assert_equal( false, nil ^ false )
#assert_equal( true,  nil | true )
#assert_equal( false, nil | false )
  end
end
