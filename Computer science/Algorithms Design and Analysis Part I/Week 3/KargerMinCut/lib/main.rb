#Programming Question - 3

fgraph = File.new("kargerAdj.txt")
vertex = [ ]
orig_number_of_edges = 0
ORIG_NUMBER_OF_VERTICES = 40
1.upto(ORIG_NUMBER_OF_VERTICES) { |i|
  vertex_line = fgraph.gets
  vertex_and_edges = vertex_line.gsub(/\s+/, " ").strip
  vertex[i] = vertex_and_edges.split(/[ ]+/)
  0.upto( vertex[i].size - 1 ) { |j| vertex[i][j] = vertex[i][j].to_i }
  orig_number_of_edges += vertex[i].size - 1;
}

orig_vertex = [ ]
1.upto(ORIG_NUMBER_OF_VERTICES) { |i|
  orig_vertex[i] = [ ]
  0.upto( vertex[i].size - 1 ) { |j| orig_vertex[i][j] = vertex[i][j] }
}

min_cut_edges = 100
min_a_part = []
min_b_part = []

#trial = 0
(ORIG_NUMBER_OF_VERTICES**2).times {
  #trial += 1
  #print trial, "\n"

  vertex = [ ]
  1.upto(ORIG_NUMBER_OF_VERTICES) { |i|
    vertex[i] = [ ]
    0.upto( orig_vertex[i].size - 1 ) { |j| vertex[i][j] = orig_vertex[i][j] }
  }
  number_of_edges = orig_number_of_edges
  number_of_vertices = ORIG_NUMBER_OF_VERTICES

  represents = [ ]
  1.upto(ORIG_NUMBER_OF_VERTICES) { |i| represents[ i ] = [ ]; represents[ i ] << i; }

  while number_of_vertices > 2
    rand_edge_number = 1+rand(number_of_edges)
    rand_edge_head, rand_edge_tail = nil;
    current_vertex = 1;
    until rand_edge_head != nil
      if ( vertex[current_vertex][0] != nil ) then
        if rand_edge_number <= ( vertex[current_vertex].size - 1 ) then
          rand_edge_head = vertex[current_vertex][0]
          rand_edge_tail = vertex[current_vertex][rand_edge_number]
        end
        rand_edge_number -= ( vertex[current_vertex].size - 1 )
      end
      current_vertex += 1
    end

    #Perform contraction
    self_cycles = 0
    vertex[rand_edge_tail][0] = nil

    1.upto( vertex[rand_edge_tail].size - 1 ) { |j|
        if vertex[rand_edge_tail][j] != rand_edge_head then
          vertex[rand_edge_head] << vertex[rand_edge_tail][j]
        else
          self_cycles += 1
        end
    }

    j = 1
    until ( j >= vertex[rand_edge_head].size )
      if vertex[rand_edge_head][j] == rand_edge_tail then
        vertex[rand_edge_head].delete_at(j)
        self_cycles += 1
      else
        j += 1
      end
    end

    1.upto(ORIG_NUMBER_OF_VERTICES) { |i|
      1.upto( vertex[i].size - 1 ) { |j|
        if vertex[i][j] == rand_edge_tail then
          vertex[i][j] = rand_edge_head
        end
      }
    }

    number_of_edges -= self_cycles
    number_of_vertices -= 1
    represents[ rand_edge_head ] += represents[ rand_edge_tail ];
  end

  #Identifying resulting subsets A and B
  i = 1
  a, b = nil, nil
  until ( a != nil )
    if ( vertex[i][0] != nil ) then a = i end
    i += 1
  end
  until ( b != nil )
    if ( vertex[i][0] != nil ) then b = i end
    i += 1
  end
  is_in_A = [ ]
  0.upto(represents[a].size - 1) { |i|
    is_in_A[represents[a][i]] = true
  }

  number_of_crossing_edges = 0
  0.upto(represents[a].size - 1) { |i|
    1.upto( orig_vertex[ represents[a][i] ].size - 1 ) { |j|
      if not is_in_A[ orig_vertex[ represents[a][i] ][ j ] ] then
        number_of_crossing_edges += 1
      end
    }
  }

  if number_of_crossing_edges < min_cut_edges then
    min_cut_edges = number_of_crossing_edges
    min_a_part = []
    min_b_part = []
    0.upto(represents[a].size - 1) { |i| min_a_part << represents[a][i] }
    0.upto(represents[b].size - 1) { |i| min_b_part << represents[b][i] }
  end
}

min_a_part.sort!
min_b_part.sort!
print min_a_part.size, " vs ", min_b_part.size, "\n"
print "A: "; 0.upto(min_a_part.size - 1) {|i| print min_a_part[i], " "}
print "\n"
print "B: "; 0.upto(min_b_part.size - 1) {|i| print min_b_part[i], " "}
print "\n"
print min_cut_edges, "\n"
