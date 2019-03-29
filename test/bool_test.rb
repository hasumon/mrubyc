# frozen_string_literal: true

class BoolTest < MrubycTestCase

  description 'Bool'
  def all

# coding: utf-8
# true / false
v = true
assert_true( v )

v = false
assert_false( v )

v = nil
assert_false( v )

v = 0
assert_true( v )

v = 1
assert_true( v )

v = 0.0
assert_true( v )

v = 0.0 / 0
assert_true( v )

v = "0"
assert_true( v )

v = ""
assert_true( v )

v = []
assert_true( v )

v = :sym
assert_true( v )


##### !演算子 #####
v = true
assert_false( !v )

v = false
assert_true( !v )

v = nil
assert_true( !v )

v = 0
assert_false( !v )

v = 1
assert_false( !v )

v = 0.0
assert_false( !v )

v = 0.0 / 0
assert_false( !v )

v = "0"
assert_false( !v )

v = ""
assert_false( !v )

v = []
assert_false( !v )

v = :sym
assert_false( !v )


##### !=演算子 #####

v1,v2 = true,true
assert_equal( v1, v2 )

v1,v2 = true,false
assert_not_equal( v1, v2 )

v1,v2 = false,true
assert_not_equal( v1, v2 )

v1,v2 = false,false
assert_equal( v1, v2 )

v1,v2 = true,nil
assert_not_equal( v1, v2 )

v1,v2 = nil,true
assert_not_equal( v1, v2 )

v1,v2 = false,nil
assert_not_equal( v1, v2 )

v1,v2 = nil,false
assert_not_equal( v1, v2 )
  end
end
