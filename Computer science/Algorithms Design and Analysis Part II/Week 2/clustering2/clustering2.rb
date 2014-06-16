require 'ruby-bsearch-1.5/bsearch.rb'

file = File.new("clustering2.txt", "r")
first_line = file.gets.split
nodes_count, word_length = first_line[0].to_i, first_line[1].to_i

nodes_leaders = Array.new
1.upto(nodes_count) { |i| nodes_leaders[i] = i }

nodes = Array.new
n_count = 0
while not file.eof 
  line = file.gets.split.join
  nodes[n_count] = Array.new
  nodes[n_count][0] = n_count         # write down original index
  nodes[n_count][1] = n_count         # cluster #: initially each node is a separate cluster 
  nodes[n_count][2] = line.to_i(2)
  n_count += 1 
end
file.close

nodes.sort! { |a, b| a[2] <=> b[2] }

cluster_count = nodes_count

0.upto( nodes_count - 1 ) { |i|
  find_range = nodes.bsearch_range {|x| x[2] <=> nodes[i][2] }
  if find_range.min != nil then
    l = [ find_range.min, i + 1 ].max
    u = find_range.max
    if l <= u then
      l.upto(u) { |j|
        if nodes[i][1] != nodes[j][1] then
          cluster_being_replaced = nodes[j][1]
          0.upto(nodes_count - 1) { |k| if nodes[k][1] == cluster_being_replaced then nodes[k][1] = nodes[i][1] end }
          cluster_count -= 1
        end
      }
    end
  end
}

0.upto( nodes_count - 1 ) { |i|
  0.upto(word_length - 1) { | bit1 |
    number = nodes[i][2]
    if nodes[i][2][ word_length - bit1 - 1 ] == 0 then
      number += ( 2 ** ( word_length - bit1 - 1 ) )
    else
      number -= ( 2 ** ( word_length - bit1 - 1 ) )
    end
    find_pos = nodes.bsearch_first { |x| x[2] <=> number }
    if find_pos != nil then
        if nodes[i][1] != nodes[find_pos][1] then
          cluster_being_replaced = nodes[find_pos][1]
          0.upto(nodes_count - 1) { |k| if nodes[k][1] == cluster_being_replaced then nodes[k][1] = nodes[i][1] end }
          cluster_count -= 1
        end
    end
  }
}

0.upto( nodes_count - 1 ) { |i|
  0.upto(word_length - 2) { | bit1 |
    (bit1 + 1).upto(word_length - 1) { | bit2 |
      number = nodes[i][2]
      if nodes[i][2][ word_length - bit1 - 1 ] == 0 then
        number += ( 2 ** ( word_length - bit1 - 1 ) )
      else
        number -= ( 2 ** ( word_length - bit1 - 1 ) )
      end
      if nodes[i][2][ word_length - bit2 - 1 ] == 0 then
        number += ( 2 ** ( word_length - bit2 - 1 ) )
      else
        number -= ( 2 ** ( word_length - bit2 - 1 ) )
      end
      find_pos = nodes.bsearch_first { |x| x[2] <=> number }
      if find_pos != nil then
          if nodes[i][1] != nodes[find_pos][1] then
            cluster_being_replaced = nodes[find_pos][1]
            0.upto(nodes_count - 1) { |k| if nodes[k][1] == cluster_being_replaced then nodes[k][1] = nodes[i][1] end }
            cluster_count -= 1
          end
      end
    }
  }
}

print "K = ", cluster_count, "\n"

