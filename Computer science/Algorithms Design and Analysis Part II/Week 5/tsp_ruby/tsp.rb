require 'rubygems'
require 'bitset'

class City
  attr_accessor :x, :y
end

class Bitset
  def ==(rhs)
    if self.size != rhs.size then
      false
    else
      equals = true
      0.upto(self.size - 1) { |bit| if self[bit] != rhs[bit] then equals = false end }
      equals
    end
  end 
  
  def to_i
    if @as_int == nil then
      i = 0
      0.upto(self.size - 1) { |bit| if self[bit] == true then i += 2 ** ( self.size - bit - 1) end }
      @as_int = i
      @as_int
    else
      @as_int
    end
  end   
end

file = File.new("test.txt", "r")
n = file.gets.to_i

cities = Array.new

1.upto(n) { |i|
  line = file.gets.split
  cur_city = City.new
  cur_city.x = line[0].to_f
  cur_city.y = line[1].to_f
  cities[i] = cur_city 
}

c = Array.new
1.upto(n) { |i|
  c[i] = Array.new
  1.upto(n) { |j|
    c[i][j] = Math.sqrt( (cities[i].x - cities[j].x)**2 + (cities[i].y - cities[j].y)**2 )
  }
}

# print "{ "
# 1.upto(n) { |i|
  # print "{ "
  # 1.upto(n) { |j|
    # print c[i][j]
    # if j < n then print ", " end
  # }
  # print " } "
  # if i < n then print ", " end
  # print "\n"
# }
# print "} "

# print "{ \n"
# 1.upto(n) { |i|
  # print "{ \"", i, "\", "
  # print cities[i].x, ",", cities[i].y
  # print " } "
  # if i < n then print ", " end
  # print "\n"
# }
# print "} "

s = Array.new
s_size = 2 ** ( n - 1 )
0.upto( s_size - 1 ) { |p|
  s[p + 1] = Bitset.new(n)
  s[p + 1][0] = true
  1.upto( n - 1 ) { |i|
    (s[p + 1])[i] = ( p[ n - i - 1] == 1 )
  }
}

a = Hash.new
one_s = Bitset.new(n)
one_s[0] = true
1.upto(s_size) { |i|
  if i.modulo(100_000) == 0 then print i, "\n" end
  a[ s[i].to_i ] = Array.new
  if s[i] == one_s then a[ s[i].to_i ][1] = 0 else a[ s[i].to_i ][1] = +1.0/0.0 end
}

2.upto(n) { |m|
  1.upto(s_size) { |i|
    if s[i].cardinality == m then
      2.upto(n) { |j|
        if ( s[i][j-1] == true ) then
          s_less_j = Bitset.new(n)
          0.upto(n - 1) { |bit| s_less_j[bit] = (s[i])[bit] }
          s_less_j[j-1] = false
          t = +1.0/0.0
          1.upto(n) { |k|
            if ( k != j ) and ( s[i][k-1] == true ) then 
              curr_val = a[ s_less_j.to_i ][ k ] + c[k][j]
              if curr_val < t then t = curr_val end
            end
          }
          a[ s[i].to_i ][ j ] = t
        end
      }
    end
  }
}

one_to_n = Bitset.new(n)
0.upto(n - 1) { |bit| one_to_n[bit] = true }
solution = +1.0/0.0
2.upto(n) { |j|
  curr_val = a[ one_to_n.to_i ][j] + c[j][1]
  if curr_val < solution then solution = curr_val end
}
print solution, "\n"
