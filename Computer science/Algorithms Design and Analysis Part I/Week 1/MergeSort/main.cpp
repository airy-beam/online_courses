/* 
 * File:   main.cpp
 * Author: ouwater
 *
 * Created on 23 Март 2012 г., 19:58
 */

#include <cstdlib>
#include <iostream>

using namespace std;

int MergeLists(long*, int, int, int, int);

int MergeSort(long* arr, int first, int last)
{
    if ( first < last )
    {
        int middle = ( first + last ) / 2;
        MergeSort(arr, first, middle);
        MergeSort(arr, middle + 1, last);
        MergeLists(arr, first, middle, middle + 1, last);
    }
}

int MergeLists(long* arr, int start1, int end1, int start2, int end2)
{
    int finalStart = start1;
    int finalEnd = end2;
    long *result = new long[ end2 - start1 + 1 ];

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
}

/*
 * 
 */
int main(int argc, char** argv) {
    long inputNumbers[ 100 ];
    //debug fill array
    int t = 1;
    for ( int i = 99; i >= 0; i-- )
    {
        inputNumbers[ i ] = t;
        t++;
    }
    //for ( int i = 0; i < 100; i++ ) std::cout << inputNumbers[ i ] << std::endl;
    //end of debug fill
    MergeSort(inputNumbers, 0, 99);
    for ( int i = 0; i < 100; i++ ) std::cout << inputNumbers[ i ] << std::endl;
    return 0;
}

