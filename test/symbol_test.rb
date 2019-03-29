# frozen_string_literal: true

class SymbolTest < MrubycTestCase

  description 'Symbol class'
  def all

# coding: utf-8
# symbol test

# 生成
s = :symbol
assert_equal :symbol, s

# 比較
assert_equal true, s == :symbol
assert_equal false, s == :symbol2
assert_equal false, s != :symbol
assert_equal true, s != :symbol2

# to_sym
s = "abc"
assert_equal :abc, s.to_sym
assert_not_equal :abc, s

# to_s
s = :symbol
assert_equal "symbol", s.to_s
assert_not_equal "symbol", s
  end
end
