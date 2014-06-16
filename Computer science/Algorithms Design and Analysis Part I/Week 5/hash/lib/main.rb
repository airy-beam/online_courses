#Programming Question - 5

fnumbers = File.new("HashInt.txt")
numbers = Hash.new
NUMBER_OF_NUMBERS = 1_000_000
1.upto(NUMBER_OF_NUMBERS) { |i|
  numbers[ fnumbers.gets.to_i ] = true
}

[ 231552,234756,596873,648219,726312,981237,988331,1277361,1283379 ].each { | target |
  can_be = false
  numbers.each{ | key, value |
    if numbers[ target - key ] then
      can_be = true
    end
  }
  if can_be then print "1" else print "0" end
}
print "\n"

