# frozen_string_literal: true

class StringSplitTest < MrubycTestCase

  description 'String#split'
  def all

#
# String#split
#

#
# Regex  not supprted.
#


#
# String
#
assert_equal ["a","b","c"],             "a,b,c".split(",")
assert_equal ["a","","b","c"],          "a,,b,c".split(",")
assert_equal ["a","b:c","d"],           "a::b:c::d".split("::")
assert_equal ["a","b:c","d:"],          "a::b:c::d:".split("::")
assert_equal ["a","b:c","d"],           "a::b:c::d::".split("::")
assert_equal ["a", "b:c", "d", ":"],    "a::b:c::d:::".split("::")


#
# " "
#
assert_equal ["a", "b", "c"], "   a \t  b \n  c\r\n".split(" ")
assert_equal ["a", "b", "c"], "a \t  b \n  c\r\n".split(" ")
assert_equal ["a", "b", "c"], "   a \t  b \n  c".split(" ")
assert_equal ["a", "b", "c"], "a \t  b \n  c".split(" ")
assert_equal ["aa", "bb", "cc"], " aa bb cc ".split(" ")
assert_equal ["aa", "bb", "cc"], "aa bb cc ".split(" ")
assert_equal ["aa", "bb", "cc"], " aa bb cc".split(" ")
assert_equal ["aa", "bb", "cc"], "aa bb cc".split(" ")


#
# nil
#
assert_equal ["a", "b", "c"], "   a \t  b \n  c".split()
assert_equal ["a", "b", "c"], "   a \t  b \n  c".split(nil)


#
# "" (empty string)
#
assert_equal [" ", " ", " ", "a", " ", "\t", " ", " ", "b", " ", "\n", " ", " ", "c"], "   a \t  b \n  c".split("")


#
# limit
#
assert_equal ["a", "b", "", "c"],         "a,b,,c,,".split(",", 0)
assert_equal ["a,b,,c,,"],                "a,b,,c,,".split(",", 1)
assert_equal ["a", "b,,c,,"],             "a,b,,c,,".split(",", 2)
assert_equal ["a", "b", ",c,,"],          "a,b,,c,,".split(",", 3)
assert_equal ["a", "b", "", "c,,"],       "a,b,,c,,".split(",", 4)
assert_equal ["a", "b", "", "c", ","],    "a,b,,c,,".split(",", 5)
assert_equal ["a", "b", "", "c", "", ""], "a,b,,c,,".split(",", 6)
assert_equal ["a", "b", "", "c", "", ""], "a,b,,c,,".split(",", 7)
assert_equal ["a", "b", "", "c", "", ""], "a,b,,c,,".split(",", -1)
assert_equal ["a", "b", "", "c", "", ""], "a,b,,c,,".split(",", -2)

assert_equal ["aa", "bb", "cc"],        " aa  bb  cc ".split(" ", 0)
assert_equal [" aa  bb  cc "],          " aa  bb  cc ".split(" ", 1)
assert_equal ["aa", "bb  cc "],         " aa  bb  cc ".split(" ", 2)
assert_equal ["aa", "bb", "cc "],       " aa  bb  cc ".split(" ", 3)
assert_equal ["aa", "bb", "cc", ""],    " aa  bb  cc ".split(" ", 4)
assert_equal ["aa", "bb", "cc", ""],    " aa  bb  cc ".split(" ", 5)
assert_equal ["aa", "bb", "cc", ""],    " aa  bb  cc ".split(" ",-1)

assert_equal ["aa", "bb", "cc"],        "aa  bb  cc".split(" ", 0)
assert_equal ["aa  bb  cc"],            "aa  bb  cc".split(" ", 1)
assert_equal ["aa", "bb  cc"],          "aa  bb  cc".split(" ", 2)
assert_equal ["aa", "bb", "cc"],        "aa  bb  cc".split(" ", 3)
assert_equal ["aa", "bb", "cc"],        "aa  bb  cc".split(" ", 4)
assert_equal ["aa", "bb", "cc"],        "aa  bb  cc".split(" ",-1)

#
# empty source
#
assert_equal [], "".split(",")
assert_equal [], "".split(",", 0)
assert_equal [], "".split(",", 1)
assert_equal [], "".split(",",-1)

assert_equal [], "".split("")
assert_equal [], "".split("", 0)
assert_equal [], "".split("", 1)
assert_equal [], "".split("",-1)

assert_equal [], "".split(" ")
assert_equal [], "".split(" ", 0)
assert_equal [], "".split(" ", 1)
assert_equal [], "".split(" ",-1)


#
# delimiter only
#
assert_equal [],        ",".split(",")
assert_equal [],        ",".split(",", 0)
assert_equal [","],     ",".split(",", 1)
assert_equal ["",""],   ",".split(",",-1)

assert_equal [],        ",,".split(",")
assert_equal [],        ",,".split(",", 0)
assert_equal [",,"],    ",,".split(",", 1)
assert_equal ["","",""],",,".split(",",-1)

assert_equal [],        " ".split(" ")
assert_equal [],        " ".split(" ", 0)
assert_equal [" "],     " ".split(" ", 1)
assert_equal [""],      " ".split(" ",-1)

assert_equal [],        "  ".split(" ")
assert_equal [],        "  ".split(" ", 0)
assert_equal ["  "],    "  ".split(" ", 1)
assert_equal [""],      "  ".split(" ",-1)
  end
end
