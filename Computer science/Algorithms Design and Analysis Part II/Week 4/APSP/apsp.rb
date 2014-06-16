require 'floyd.rb'

file = File.new("g3.txt", "r")
first_line = file.gets.split
number_of_vertices, number_of_edges = first_line[0].to_i, first_line[1].to_i

#print number_of_vertices, " ", number_of_edges, "\n"

#edges = Array.new
edge_costs = Array.new
0.upto(number_of_vertices - 1) { |i| 
  edge_costs[i] = Array.new
  0.upto(number_of_vertices - 1) { |j|
     if ( i == j ) then
       edge_costs[i][j] = 0
     else
       edge_costs[i][j] = +1.0 / 0.0
     end
  }
}

0.upto(number_of_edges - 1) { |i| 
  line = file.gets.split
  #edges[i] = Array.new
  edge_costs[line[0].to_i - 1][line[1].to_i - 1] = line[2].to_i
  #edges[i][0], edges[i][1], edges[i][2] = line[0].to_i, line[1].to_i, line[2].to_i
}

path_matrix = Floyd.new(edge_costs).getDistanceMatrix
has_cycle = false
0.upto(number_of_vertices - 1) { |i|
  if path_matrix[i][i] < 0 then
    print i, "!\n"
    has_cycle = true
  end
}
if has_cycle then
  print "NULL\n"
else
  opt_solution = path_matrix[0][1]
  0.upto(number_of_vertices - 1) { |i| 
    0.upto(number_of_vertices - 1) { |j|
      if ( i != j ) and ( path_matrix[i][j] < opt_solution ) then
        opt_solution = path_matrix[i][j]
      end
    }
  }
  print opt_solution, "\n"
end

#print edge_costs[2][38]

# a = Array.new
# 1.upto(number_of_vertices) { |i|
  # a[i] = Array.new  
  # 1.upto(number_of_vertices) { |j|
    # a[i][j] = Array.new
    # if ( i == j) then
      # a[i][j][0] = 0
    # else
      # if edge_costs[i][j] != nil then
        # a[i][j][0] = edge_costs[i][j]
      # else
        # a[i][j][0] = +1.0 / 0.0
      # end
    # end
  # }
# }

# 1.upto(number_of_vertices) { |k|
  # print k, "\n"
  # #k_ind = k.modulo(2)
  # #k_prev = 1 - k_ind  
  # 1.upto(number_of_vertices) { |i|
    # if edge_costs[i][k] < +1.0 / 0.0  then
      # 1.upto(number_of_vertices) { |j|
        # #a[i][j][k] = [ a[i][j][k-1], a[i][k][k-1] + a[k][j][k-1] ].min
        # distance = edge_costs[i][k] + edge_costs[k][j]
        # if distance < edge_costs[i][j] then
          # edge_costs[i][j] = distance
        # end
      # }
    # end
  # }
# }
# 
# 1.upto(number_of_vertices) { |i|
  # if edge_costs[i][i][number_of_vertices] < 0 then
    # print i, "!\n"
  # end
# }