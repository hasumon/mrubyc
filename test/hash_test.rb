# frozen_string_literal: true

class HashTest < MrubycTestCase

  description 'Hash class'
  def all

# coding: utf-8

# 生成
h = {a: 1, b: 2}
assert_equal( {:a=>1, :b=>2 }, h )

h = Hash.new
assert_equal( {}, h )

# 値の取り出し
h = {:key=>"value", "key"=>:value, 3=>"Three", :"4"=>444}
assert_equal( "value", h[:key] )
assert_equal( :value,  h["key"] )
assert_equal( "Three", h[3] )
assert_equal( 444,     h[:"4"] )

# 値の設定、サイズ
h = Hash.new
assert_equal( 0, h.size )
h["key"] = :value
assert_equal( :value,  h["key"] )
assert_equal( 1, h.size )

# Hash#[]: 存在しないキーにアクセスした場合nilが返ること
assert_equal( nil, h["no-exist-key"] )

# operator !=
h1 = {:key=>"value", "key"=>:value, 3=>"Three", :"4"=>444}
assert_not_equal( h, h1 )

# operator ==  (順序が違うHash同士の比較)
h[:key] = "value"
h[:"4"] = 444
h[3] = "Three"
assert_equal( h, h1 )

assert_equal( 4, h.size )
assert_equal( 4, h1.size )

# 値の上書き
h[:key] = "other value"
assert_not_equal( h, h1 )
assert_equal( 4, h.size )


# clear
h.clear
assert_equal( {}, h )
assert_equal( 0, h.size )


# dup
h = {:a=>"A", :b=>"B"}
h1 = h
assert_equal( h, h1 )

h1[:a] = "AA"
assert_equal( h, h1 )

h1 = h.dup
h1[:b] = "BB"
assert_not_equal( h, h1 )


# delete
h = {:ab => "some", :cd => "all"}

assert_equal( "some", h.delete(:ab) )
assert_equal( h, {:cd=>"all"} )

assert_equal( nil, h.delete(:ef) )

# TODO delete with block


# empty?
assert_equal( true, {}.empty? )
assert_equal( false, {:a=>1}.empty? )


# has_key?
h = {:key=>"value", "key"=>:value, 3=>"Three", :"4"=>444}
assert_equal( true,  h.has_key?(:key) )
assert_equal( false, h.has_key?(:key2) )

# has_value?
assert_equal( true,  h.has_value?(444) )
assert_equal( false, h.has_value?(555) )

# key
assert_equal( "key", h.key(:value) )
assert_equal( nil,   h.key(:no_exist) )


# keys
assert_equal( [:key, "key", 3, :"4"], h.keys )

# values
assert_equal( ["value", :value, "Three", 444], h.values )


# size, length, count
assert_equal( 4, h.size )
assert_equal( 4, h.length )
assert_equal( 4, h.count )


# merge
foo = {1=>"a", 2=>"b", 3=>"c"}
bar = {2=>"B", 3=>"C", 4=>"D"}
assert_equal( {1=>"a", 2=>"B", 3=>"C", 4=>"D"}, foo.merge(bar) )
assert_equal( {1=>"a", 2=>"b", 3=>"c"}, foo )
assert_equal( {2=>"B", 3=>"C", 4=>"D"}, bar )

# merge!
assert_equal( {1=>"a", 2=>"B", 3=>"C", 4=>"D"}, foo.merge!(bar) )
assert_equal( {1=>"a", 2=>"B", 3=>"C", 4=>"D"}, foo )
assert_equal( {2=>"B", 3=>"C", 4=>"D"}, bar )


# to_h
h = {}
assert_equal( {}, h.to_h )
  end
end
