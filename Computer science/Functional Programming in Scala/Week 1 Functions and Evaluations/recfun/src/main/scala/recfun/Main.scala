package recfun
import common._

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  /**
   * Exercise 1
   */
  def pascal(c: Int, r: Int): Int = 
    if ( ( c == 0 ) && ( r == 0 ) ) 1
    else
      (
          if ( ( c == 0 ) || ( c == r ) ) 1
          else pascal(c - 1, r - 1) + pascal(c, r - 1) 
      )

  /**
   * Exercise 2
   */
  def balance(chars: List[Char]): Boolean = 
  {
      def balance_inner( k: Int, chars: List[Char]): Boolean =
      {
        if ( chars.isEmpty ) ( k == 0 )
        else ( 
            if ( k < 0 ) false 
            else ( if ( (chars.head != '(') && (chars.head != ')') )
		              ( balance_inner(k, chars.tail) )
		           else
		        	  ( if ( chars.head == '(' ) ( balance_inner( k + 1, chars.tail ) )
		        	    else ( balance_inner( k - 1, chars.tail) ) ) 
		         )
		      )
      }
      
      balance_inner(0, chars)
  }

  /**
   * Exercise 3
   */
  def countChange(money: Int, coins: List[Int]): Int = 
  {
    def countChangeWithPalm(sum: Int, coins: List[Int]): Int =
    {
      if ( sum == money ) 1
      else (
              if ( sum > money ) 0
              else (
                      countChangeWithPalm( sum + coins.head , coins ) +
                      ( if ( !( coins.tail.isEmpty ) ) ( countChangeWithPalm( sum , coins.tail ) )
			            else 0 )
                    )
            )
    }
    
    if ( ( money <= 0 ) || ( coins.isEmpty ) ) 0 else countChangeWithPalm(0, coins)
  }
}
