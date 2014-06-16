package streams
//import streams.Solver
//import streams.InfiniteTerrain

trait SolutionChecker extends streams.GameDef with streams.Solver with streams.StringParserTerrain {
}

trait Level1 extends SolutionChecker {
      /* terrain for level 1*/

    val level =
    """ooo-------
      |oSoooo----
      |ooooooooo-
      |-ooooooooo
      |-----ooToo
      |------ooo-""".stripMargin
      
    val v = Vector(Vector('o','o','o','-','-','-','-','-','-','-'),
		  	Vector('o','S','o','o','o','o','-','-','-','-'),
			Vector('o','o','o','o','o','o','o','o','o','-'),
			Vector('-','o','o','o','o','o','o','o','o','o'),
			Vector('-','-','-','-','-','o','o','T','o','o'),
			Vector('-','-','-','-','-','-','o','o','o','-'))
}

object Test extends Level1 with App {
  println("Hey!")

  val tf = this.terrainFunction(v)
  
  val Pos1 = new Pos(1,1)
  val Pos2 = new Pos(1,1)
  
  println(tf(Pos1))
  println(findChar('S', v))
  
  val Block1 = new Block(Pos1, Pos2)
  
  //println( Block1.isStanding )
  //println( Block1.isLegal )
  
  val Block2 = startBlock
  //println(Block2)
  
  val ns = Block2.neighbors
  //println(ns)
  
  val l_ns = Block1.legalNeighbors
  //println(l_ns)
  
  val Block3 = new Block(new Pos(4,7), new Pos(4,7))
  //println(Block3.isLegal)
  
  //println(done(Block3))
  
  val nsh = neighborsWithHistory(Block1, List())
  println(nsh)
}
