/*
 * File:   main.cpp
 * Author: ouwater
 *
 * Created on 23 Март 2012 г., 19:58
 */

#include <cstdlib>
#include <iostream>
#include <fstream>

using namespace std;

unsigned long MergeArraysAndCountInversions(long*, int, int, int, int);

unsigned long CountInversions(long* arr, int first, int last)
{
    if ( first == last )
    {
        return 0;
    }
    else
        if ( first < last )
        {
            int middle = ( first + last ) / 2;
            unsigned long x = CountInversions(arr, first, middle);
            unsigned long y = CountInversions(arr, middle + 1, last);
            unsigned long z = MergeArraysAndCountInversions(arr, first, middle, middle + 1, last);
            return x + y + z;
        }
}

unsigned long MergeArraysAndCountInversions(long* arr, int start1, int end1, int start2, int end2)
{
    int finalStart = start1;
    int finalEnd = end2;
    long *result = new long[ end2 - start1 + 1 ];

    unsigned long counter = 0;
    int indexC = 0;
    while ( ( start1 <= end1 ) && ( start2 <= end2 ) ) {
        if ( arr[ start1 ] < arr[ start2 ] )
        {
            result[ indexC ] = arr[ start1 ];
            start1++;
        }
        else
        {
            result[ indexC ] = arr[ start2 ];
            counter += ( end1 - start1 + 1 ) ;
            start2++;
        }
        indexC++;
    }

    if ( start1 <= end1 )
    {
        for (int i = start1; i <= end1; i++ )
        {
            result[ indexC ] = arr[ i ];
            indexC++;
        }
    }
    else
    {
        for (int i = start2; i <= end2; i++ )
        {
            result[ indexC ] = arr[ i ];
            indexC++;
        }
    }

    indexC = 0;
    for (int i = finalStart; i <= finalEnd; i++ )
    {
        arr[ i ] = result[ indexC ];
        indexC++;
    }

    delete[] result;
    result = 0;
    return counter;
}

/*
 *
 */
int main(int argc, char** argv) {
    const int n = 100000;
    ifstream f;
    f.open("IntegerArray.txt");
    long inputNumbers[ n ];
    for ( int i = 0; i < n; i++ ) {
        f >> inputNumbers[ i ];
    }
    f.close();
    unsigned long result = CountInversions(inputNumbers, 0, n - 1 );
    std::cout << result << std::endl;
    return 0;
}

