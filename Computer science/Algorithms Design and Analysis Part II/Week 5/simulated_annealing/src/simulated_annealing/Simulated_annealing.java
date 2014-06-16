/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package simulated_annealing;
import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author ouwater
 */
public class Simulated_annealing {

    /**
     * @param args the command line arguments
     */
    private static final double INITIAL_TEMPERATURE = 110.0;
    private static final double FINAL_TEMPERATURE = 0.5;
    private static final double ALPHA = 0.99;
    private static final int ITERATIONS_AT_TEMPERATURE = 1500000;

    private static Solution currentSolution = new Solution();
    private static Solution workingSolution = new Solution();
    private static Solution bestSolution = new Solution();
    
    private static ArrayList<cCity> map = new ArrayList<cCity>();
    
    private static final int CITY_COUNT = 25;
    private static final double TARGET = 0;                // correct answer.
    private static double XLocs[] = new double[] {20833.3333, 20900.0, 21300.0, 21600.0, 21600.0, 21600.0, 22183.3333, 22583.3333, 22683.3333, 23616.6667, 23700.0, 23883.3333, 24166.6667, 25149.1667, 26133.3333, 26150.0, 26283.3333, 26433.3333, 26550.0, 26733.3333, 27026.1111, 27096.1111, 27153.6111, 27166.6667, 27233.3333};
    private static double YLocs[] = new double[] {17100.0, 17066.6667, 13016.6667, 14150.0, 14966.6667, 16500.0, 13133.3333, 14300.0, 12716.6667, 15866.6667, 15933.3333, 14533.3333, 13250.0, 12365.8333, 14500.0, 10550.0, 12766.6667, 13433.3333, 13850.0, 11683.3333, 13051.9444, 13415.8333, 13203.3333, 9833.3333, 10450.0};
    
    
    //private static final int CITY_COUNT = 10;
    //private static final double TARGET = 0;                // correct answer.
    //private static double XLocs[] = new double[] {200.0, 180.9, 130.9, 69.1, 19.1, 0.0, 19.1, 69.1, 130.9, 180.9};
    //private static double YLocs[] = new double[] {100.0, 158.8, 195.1, 195.1, 158.8, 100.0, 41.2, 4.9, 4.9, 41.2};
   
//    private static final int CITY_COUNT = 14;
//    private static final double TARGET = 85.97;                // correct answer.
//    private static int XLocs[] = new int[] {25, 30, 35, 39, 39, 35, 30, 25, 20, 15, 11, 11, 15, 20};
//    private static int YLocs[] = new int[] {4, 5, 8, 15, 20, 27, 30, 31, 30, 27, 20, 15, 8, 5};
    
    private static void simulatedAnnealingAlgorithm()
    {
        boolean solution = false;
        boolean useNew = false;
        int accepted = 0;
        double temperature = INITIAL_TEMPERATURE;

        initializeSolution();

        currentSolution.computeEnergy();
        System.out.println("Distance: " + currentSolution.solutionEnergy());

        bestSolution.solutionEnergy(currentSolution.solutionEnergy());

        workingSolution.equals(currentSolution);

        while(temperature > FINAL_TEMPERATURE)
        {
            accepted = 0;

            for(int i = 0; i < ITERATIONS_AT_TEMPERATURE; i++)
            {
                useNew = false;

                workingSolution.randomChange();
                
                workingSolution.computeEnergy();
                System.out.println("Distance: " + workingSolution.solutionEnergy());

                if(workingSolution.solutionEnergy() <= currentSolution.solutionEnergy()){
                    useNew = true;
                }else{
                    double test = new Random().nextDouble(); //  Get random value between 0.0 and 1.0
                    double delta = workingSolution.solutionEnergy() - currentSolution.solutionEnergy();
                    double calc = Math.exp(-delta / temperature);
                    if(calc > test){
                        accepted++;
                        useNew = true;
                    }
                }

                if(useNew){
                    useNew = false;
                    currentSolution.equals(workingSolution);
                    if(currentSolution.solutionEnergy() < bestSolution.solutionEnergy()){
                        bestSolution.equals(currentSolution);
                        solution = true;
                    }
                }else{
                    workingSolution.equals(currentSolution);
                }

                System.out.println("Current Solution Energy: " + currentSolution.solutionEnergy());
                System.out.println("Working Solution Energy: " + workingSolution.solutionEnergy());
                System.out.println("Best Solution Energy: " + bestSolution.solutionEnergy());
            }
            temperature *= ALPHA;
            System.out.println("Temperature: " + temperature);
        }
        
        if(solution){
            for(int j = 0; j < CITY_COUNT; j++)
            {
                System.out.print(bestSolution.data(j) + ", ");
            }
            System.out.print("\n");
            if(bestSolution.solutionEnergy() <= TARGET){
                System.out.println("Best solution is: Correct");
            }else{
                System.out.println("Best solution is: Not Correct");
            }
        }
        return;
    }
    
    
    private static void initializeMap()
    {
        cCity city = null;

        for(int i = 0; i < CITY_COUNT; i++)
        {
            city = new cCity();
            city.x(XLocs[i]);
            city.y(YLocs[i]);
            map.add(city);
        }
        return;
    }
    
    private static void initializeSolution()
    {
        // Initial setup of the solution.
        for(int i = 0; i < CITY_COUNT; i++)
        {
            currentSolution.data(i, i);
        }

        // Randomly perturb the solution.
        for(int i = 0; i < CITY_COUNT; i++)
        {
            currentSolution.randomChange();
        }
        return;
    }
    
    private static double getDistance(final int FirstCity, final int SecondCity)
    {
        cCity CityA = null;
        cCity CityB = null;
        double A2 = 0;
        double B2 = 0;
        CityA = map.get(FirstCity);
        CityB = map.get(SecondCity);
        A2 = Math.pow(Math.abs(CityA.x() - CityB.x()), 2);
        B2 = Math.pow(Math.abs(CityA.y() - CityB.y()), 2);

        return Math.sqrt(A2 + B2);
    }
    
    private static int getExclusiveRandomNumber(final int high, final int except)
    {
        boolean done = false;
        int getRand = 0;

        while(!done)
        {
            getRand = new Random().nextInt(high);
            if(getRand != except){
                done = true;
            }
        }

        return getRand;
    }
    
    private static class Solution
    {
        private double mSolutionEnergy = 0.0;
        private int mData[] = null;
    
        public Solution()
        {
            mData = new int[CITY_COUNT];
            return;
        }
        
        public Solution(Solution that)
        {
            mData = new int[CITY_COUNT];
            for(int i = 0; i < CITY_COUNT; i++)
            {
                this.mData[i] = that.data(i);
            }
            this.mSolutionEnergy = that.mSolutionEnergy;
            return;
        }
        
        public void equals(Solution that)
        {
            for(int i = 0; i < CITY_COUNT; i++)
            {
                this.mData[i] = that.data(i);
            }
            this.mSolutionEnergy = that.mSolutionEnergy;
            return;
        }
        
        public void data(int index, int value)
        {
            this.mData[index] = value;
            return;
        }
        
        public int data(int index)
        {
            return this.mData[index];
        }
        
        public void solutionEnergy(double value)
        {
            this.mSolutionEnergy = value;
            return;
        }
        
        public double solutionEnergy()
        {
            return this.mSolutionEnergy;
        }
        
        public void randomChange()
        {
            int temp = 0;
            int x = 0;
            int y = 0;

            // Get two different random numbers.
            x = new Random().nextInt(CITY_COUNT);
            y = getExclusiveRandomNumber(CITY_COUNT, x);
            
            temp = this.mData[x];
            this.mData[x] = this.mData[y];
            this.mData[y] = temp;
            return;
        }
        
        public void computeEnergy()
        {
            this.mSolutionEnergy = 0.0;
            // Find the round-trip distance. 
            for(int i = 0; i < CITY_COUNT; i++)
            {
                if(i == CITY_COUNT - 1){
                    this.mSolutionEnergy += getDistance(this.mData[CITY_COUNT - 1], this.mData[0]); // Complete trip.
                }else{
                    this.mSolutionEnergy += getDistance(this.mData[i], this.mData[i + 1]);
                }
            }
            return;
        }
        
    } // Solution class
    
    private static class cCity
    {
        private double mX = 0;
        private double mY = 0;
    
        public double x()
        {
            return mX;
        }
        
        public void x(final double xCoordinate)
        {
            mX = xCoordinate;
            return;
        }
    
        public double y()
        {
            return mY;
        }
        
        public void y(final double yCoordinate)
        {
            mY = yCoordinate;
            return;
        }
    } // cCity class
    
    public static void main(String[] args)
    {
        initializeMap();
        simulatedAnnealingAlgorithm();
        return;
    }
}
