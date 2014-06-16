package funsets

object Main extends App {
  import FunSets._
  val s1 = singletonSet(1)
  val s2 = singletonSet(2)
  val s3 = singletonSet(3)
  val s4 = union(s1, s2)
  val s5 = union(s4, s3)
  def p(x: Int): Boolean = if ( x <= 3 ) true else false
  val s6 = filter(s5, p )
  println(forall(s5, p))
}
