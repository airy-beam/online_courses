class Floyd #aka all-pairs shortest paths algorithm
 def initialize(weightMatrix=nil,oo= +1.0/0.0 ) #256?
  @weightMatrix=weightMatrix
  @oo=oo #needed to set a weight considered "infinite"
 end
  
 attr_accessor :oo
 
 attr_accessor :weightMatrix
 
 def getDistanceMatrix
  numNodes=@weightMatrix[0].length
  distanceMatrix=Array.new(@weightMatrix)
  
  for k in 0...numNodes
   #print k, "\n"
   for i in 0...numNodes
    #Optimization: if no path from i to k, no need to test k to j
    if distanceMatrix[i][k]<@oo then 
     for j in 0...numNodes
      distance = distanceMatrix[i][k] + distanceMatrix[k][j]
      if distance<distanceMatrix[i][j] then
       distanceMatrix[i][j]=distance
      end
     end
    end
   end
  end
  distanceMatrix
 end

 def showDistanceMatrix
  puts "weight"
  @weightMatrix.each{|c| print c.to_s.gsub(@oo.to_s,"oo"),"\n"}
  puts "distance"
  getDistanceMatrix.each{|c| print c.to_s.gsub(@oo.to_s,"oo"),"\n"}
 end

end
  
#tests:
if __FILE__ == $0
 floyd=Floyd.new
 oo=floyd.oo
 floyd.weightMatrix=[[0,oo,3,oo],[2,0,oo,oo],[oo,7,0,1],[6,oo,oo,0]]
 floyd.showDistanceMatrix
 dim=10 #randomize out a big graph
 weightMatrix=Array.new(dim){Array.new(dim)}
 for i in 0...dim do
  for j in 0...dim do
   if i==j then
    weightMatrix[i][j]=0
   elsif rand(dim/2)==0 then
    weightMatrix[i][j]=rand(9)+1
   else
    weightMatrix[i][j]=oo
   end
  end
 end
 floyd.weightMatrix=weightMatrix
 floyd.showDistanceMatrix
end