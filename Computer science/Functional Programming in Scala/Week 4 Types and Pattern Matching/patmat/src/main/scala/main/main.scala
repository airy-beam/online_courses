package main
import patmat.Huffman._

object Main {

  def main(args: Array[String]): Unit = {
    val t1 = Fork(Leaf('a',2), Leaf('b',3), List('a','b'), 5)
    //println(chars(t1))
    
    val sampleTree = makeCodeTree(
	  makeCodeTree(Leaf('x', 1), Leaf('e', 1)),
	  Leaf('t', 2)
    )
    //println(weight(sampleTree))
    
    //println(createCodeTree(string2Chars("airy beammm")))
    //val leafs_list = makeOrderedLeafList( times_list )
    //println(leafs_list)
    
    //println(singleton(List(t1)))
    //println(until(singleton, combine)(leafs_list))
    
    //println(decodedSecret.mkString)
    //val my_secret = encode(frenchCode)(string2Chars("huffmanestcool"))
    //println(my_secret)
    
    //println( my_secret == secret )
    
    //println(codeBits(List(('I', List(1,1,2)), ('Z', List(2,2,1))))('I'))
    
    //println(convert(frenchCode))
    val my_secret = quickEncode(frenchCode)(string2Chars("huffmanestcool"))
    println(my_secret)
    println( my_secret == secret )
  }

}
