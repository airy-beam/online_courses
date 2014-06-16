/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package pkg2sat;
import java.util.*;
import java.io.*;

/**
 *
 * @author ouwater
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        List<Clause> ls=new ArrayList<Clause>();
        
        BufferedReader in = new BufferedReader(new FileReader("/home/ouwater/NetBeansProjects/2SAT/src/pkg2sat/input/2sat1.txt")); 
        String first_line = in.readLine();
        int n = Integer.parseInt(first_line);
        String text;
        while (in.ready()) {
            text = in.readLine();
            
            StringTokenizer tokenizer = new StringTokenizer(text," ");
            int l1 = Integer.parseInt(tokenizer.nextElement().toString());
            boolean l1_negated = ( l1 < 0 );
            if (l1_negated) l1 = -l1;
            
            int l2 = Integer.parseInt(tokenizer.nextElement().toString());
            boolean l2_negated = ( l2 < 0 );
            if (l2_negated) l2 = -l2;
            
            Literal literal1 = new Literal(l1, !(l1_negated) );
            Literal literal2 = new Literal(l2, !(l2_negated) );
            
            Clause clause = new Clause(literal1, literal2);
            ls.add(clause);
        }
        TwoSat two_sat = new TwoSat();
        System.out.println(two_sat.isSatisfiable(ls));
    }
}
