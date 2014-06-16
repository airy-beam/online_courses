file = File.new("clustering.txt", "r")
@@nodes_count = file.gets.to_i
K = 4

@@nodes_leaders = Array.new
1.upto(@@nodes_count) { |i| @@nodes_leaders[i] = i }

edges = Array.new
edge_count = 0
while not file.eof 
  line = file.gets.split
  edges[edge_count] = Array.new
  edges[edge_count][0], edges[edge_count][1], edges[edge_count][2] = line[0].to_i, line[1].to_i, line[2].to_i
  edge_count += 1 
end
file.close

edges.sort! { |a, b| a[2] <=> b[2] }

def union_two_clusters(a, b)
  1.upto(@@nodes_count) { |i| if @@nodes_leaders[i] == a then @@nodes_leaders[i] = b end }
end

clusters_count = @@nodes_count
i = 0
until clusters_count == K do
  cur_edge = edges[i]
  if @@nodes_leaders[cur_edge[0]] != @@nodes_leaders[cur_edge[1]] then
    union_two_clusters(@@nodes_leaders[cur_edge[0]], @@nodes_leaders[cur_edge[1]])
    clusters_count -= 1
  end 
  i += 1
end

spacing = +1.0/0.0
edges.each { |edge|
  if @@nodes_leaders[edge[0]] != @@nodes_leaders[edge[1]] then
    if edge[2] < spacing then spacing = edge[2] end
  end
}
print spacing, "\n"

