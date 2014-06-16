file = File.new("knapsack1.txt", "r")
first_line = file.gets.split
knapsack_size, number_of_items = first_line[0].to_i, first_line[1].to_i

items = Array.new
1.upto(number_of_items) { |i| 
  line = file.gets.split
  items[i] = Array.new
  items[i][0], items[i][1] = line[0].to_i, line[1].to_i
}

a = Array.new
a[0] = Array.new 
0.upto(knapsack_size) { |x| a[0][x] = 0 }

1.upto(number_of_items) { |i|
  a[i] = Array.new
  0.upto(knapsack_size) { |x| 
    if items[i][1] > x then
      a[i][x] = a[i - 1][x]
    else
      a[i][x] = [ a[i - 1][x], a[ i - 1 ][ x - items[i][1] ] + items[i][0] ].max
    end
  }
}
print a[number_of_items][knapsack_size], "\n"
