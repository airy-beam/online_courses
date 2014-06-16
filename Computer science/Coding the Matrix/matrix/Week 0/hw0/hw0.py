# Please fill out this stencil and submit using the provided submission script.





## Problem 1
def myFilter(L, num): return [ x for x in L if x % num != 0 ]


## Problem 2
def myLists(L): return [ [ x+1 for x in range(x)] for x in L ]


## Problem 3
def myFunctionComposition(f, g): return { x : g[f[x]] for x in f.keys() }


## Problem 4
# Please only enter your numerical solution.

complex_addition_a = (3 + 1j) + (2 + 2j)
complex_addition_b = (-1 + 2j) + (1 - 1j)
complex_addition_c = (2 + 0j) + (-3 + .001j)
complex_addition_d = 4*(0 + 2j) + (.001 + 1j)


## Problem 5
from GF2 import one 
GF2_sum_1 = 1 ##one + one + one + 0
GF2_sum_2 = one * one + 0 * one + 0 * 0 + one * one
GF2_sum_3 = (one + one + one) * (one + one + one + one)

## Problem 6
def mySum(L): return sum(L)



## Problem 7
def myProduct(L):
    current = 1
    for x in L:
        current = current * x
    return current


## Problem 8
def myMin(L): return min(L)



## Problem 9
def myConcat(L): return ''.join(L)



## Problem 10
def myUnion(L): 
    current = set()
    for x in L:
        current = current | x
    return current

print(myUnion([{1,2},{2,3}]))

