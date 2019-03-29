# frozen_string_literal: true

class OpBasicTest < MrubycTestCase

  description 'OP CODE basic'
  def all

# coding: utf-8
#
# IREPオペコード　基本演算テスト

# op_add
a = 1
b = 2
assert_equal( a + b, 3 )

a = 1
b = 2.0
assert_equal( a + b, 3.0 )

a = 1.0
b = 2
assert_equal( a + b, 3.0 )

a = 1.0
b = 2.0
assert_equal( a + b, 3.0 )


# op_addi
a = 1
assert_equal( a + 2, 3 )
assert_equal( 1 + 2, 3 )


a = 1.0
assert_equal( a + 2, 3.0 )
assert_equal( 1.0 + 2, 3.0 )


# op_sub
a = 1
b = 2
assert_equal( a - b, -1 )

a = 1
b = 2.0
assert_equal( a - b, -1.0 )

a = 1.0
b = 2
assert_equal( a - b, -1.0 )

a = 1.0
b = 2.0
assert_equal( a - b, -1.0 )

# op_subi
a = 1
assert_equal( a - 2, -1 )

a = 1.0
assert_equal( a - 2, -1.0 )


# op_mul
a = 2
b = 3
assert_equal a * b, 6

a = 2
b = 3.0
assert_equal a * b, 6.0

a = 2.0
b = 3
assert_equal a * b, 6.0

a = 2.0
b = 3.0
assert_equal a * b, 6.0


# op_lt
a = 1
b = 2
assert_true( a < b )
assert_false( b < a )

a = 1
b = 2.0
assert_true( a < b )
assert_false( b < a )

a = 1.0
b = 2
assert_true( a < b )
assert_false( b < a )

a = 1.0
b = 2.0
assert_true( a < b )
assert_false( b < a )

a = 1
b = 1
assert_false( a < b )

a = 1
b = 1.0
assert_false( a < b )

a = 1.0
b = 1
assert_false( a < b )

a = 1.0
b = 1.0
assert_false( a < b )


# op_le
a = 1
b = 2
assert_true( a <= b )
assert_false( b <= a )

a = 1
b = 2.0
assert_true( a <= b )
assert_false( b <= a )

a = 1.0
b = 2
assert_true( a <= b )
assert_false( b <= a )

a = 1.0
b = 2.0
assert_true( a <= b )
assert_false( b <= a )

a = 1
b = 1
assert_true( a <= b )

a = 1
b = 1.0
assert_true( a <= b )

a = 1.0
b = 1
assert_true( a <= b )

a = 1.0
b = 1.0
assert_true( a <= b )


# op_gt
a = 1
b = 2
assert_false( a > b )
assert_true( b > a )

a = 1
b = 2.0
assert_false( a > b )
assert_true( b > a )

a = 1.0
b = 2
assert_false( a > b )
assert_true( b > a )

a = 1.0
b = 2.0
assert_false( a > b )
assert_true( b > a )

a = 1
b = 1
assert_false( a > b )

a = 1
b = 1.0
assert_false( a > b )

a = 1.0
b = 1
assert_false( a > b )

a = 1.0
b = 1.0
assert_false( a > b )

# op_ge
a = 1
b = 2
assert_false( a >= b )
assert_true( b >= a )

a = 1
b = 2.0
assert_false( a >= b )
assert_true( b >= a )

a = 1.0
b = 2
assert_false( a >= b )
assert_true( b >= a )

a = 1.0
b = 2.0
assert_false( a >= b )
assert_true( b >= a )

a = 1
b = 1
assert_true( a >= b )

a = 1
b = 1.0
assert_true( a >= b )

a = 1.0
b = 1
assert_true( a >= b )

a = 1.0
b = 1.0
assert_true( a >= b )
  end
end
