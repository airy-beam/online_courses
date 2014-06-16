file = File.new("edges.txt", "r")
nodes_and_edges_count = file.gets.split
nodes_count, edges_count = nodes_and_edges_count[0].to_i, nodes_and_edges_count[1].to_i 

edges = Array.new
0.upto(edges_count - 1) { |i|
  line = file.gets.split
  edges[i] = Array.new
  edges[i][0], edges[i][1], edges[i][2] = line[0].to_i, line[1].to_i, line[2].to_i
}

#0.upto(edges_count - 1) { |i| print edges[i][0], " ", edges[i][1], " ", edges[i][2] ,"\n" }

x = Array.new #spanned vertices
x << 1        #seed vertex 1 picked up arbitrarily

t = Array.new #tree - minimum spanning tree

while x.size < nodes_count
  min_edge_cost = +1.0/0.0
  node1, node2 = 0, 0
  v = 0
  0.upto(edges_count - 1) { |i| 
    if ( (x.include?(edges[i][0]) and not x.include?(edges[i][1])) or
         (x.include?(edges[i][1]) and not x.include?(edges[i][0])) ) and edges[i][2] < min_edge_cost then
      node1, node2, min_edge_cost = edges[i][0], edges[i][1], edges[i][2]
      if not x.include?(edges[i][0]) then v = edges[i][0] else v = edges[i][1] end
    end
  }
  t << [ node1, node2, min_edge_cost ]
  #print node1, "->", node2, " ", min_edge_cost, "\n"
  x << v
  #print x.size, "\n"
end

total_cost = 0
0.upto( t.size - 1) { |i|
  total_cost += t[i][2]
}
print total_cost, "\n"

