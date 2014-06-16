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

unsigned long result;
int current_case;
unsigned long partition(long*, int, int);

int findMedian( int a, int b, int c ) {
    if ((a >= b && a <= c) || (a >= c && a <= b)) return 1;
        else if ((b >= a && b <= c) || (b >= c && b <= a)) return 2;
            else return 3;
}

void swap(int &a, int &b)
{
    int t = a;
    a = b;
    b = t;
}

unsigned long quickSort(long* arr, int first, int last)
{
    if ( first < last )
    {
        int pivot = partition(arr, first, last);
        quickSort(arr, first, pivot - 1);
        quickSort(arr, pivot + 1, last);
    }
}

unsigned long partition(long* arr, int first, int last)
{
    if ( 2 == current_case ) swap(arr[ first ], arr[ last ]);

    if ( 3 == current_case )
    {
        int med_index = first + ( last - first ) / 2;
        int median = findMedian( arr[ first ], arr[ med_index ], arr[ last ] );
        if ( 2 == median ) swap(arr[ first ], arr[ med_index ]);
        if ( 3 == median ) swap(arr[ first ], arr[ last ]);
    }    
    
    int pivotValue = arr[ first ];
    int pivotPoint = first;
    for ( int index = first + 1; index <= last; index++ ) {
        if ( arr[ index ] < pivotValue ) {
            pivotPoint++;
            swap(arr[ pivotPoint ], arr[ index ]);
        }
    }

    swap(arr[ pivotPoint ], arr[ first ]);
    result += ( last - first );
    return pivotPoint;
}

int main(int argc, char** argv) {
    const int n = 10000;
    
    for ( current_case = 1; current_case <= 3; current_case++ ) {
        ifstream f;
        f.open("QuickSort.txt");
        long inputNumbers[ n ];
        for ( int i = 0; i < n; i++ ) {
            f >> inputNumbers[ i ];
        }
        f.close();
        
        result = 0;
        quickSort(inputNumbers, 0, n - 1 );
    //    for ( int i = 0; i < n; i++ ) {
    //        std::cout << inputNumbers[ i ] << std::endl;
    //    }
        std::cout << result << std::endl;
    }
    return 0;
}
