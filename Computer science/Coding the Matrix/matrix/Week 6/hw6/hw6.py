# version code 988
# Please fill out this stencil and submit using the provided submission script.

from matutil import *
from GF2 import one
from vecutil import zero_vec
from matutil import rowdict2mat
from triangular import triangular_solve


## Problem 1
# Write each matrix as a list of row lists

echelon_form_1 = [[ 1, 2, 0, 2, 0 ],
                  [ 0, 1, 0, 3, 4 ],
                  [ 0, 0, 2, 3, 4 ],
                  [ 0, 0, 0, 2, 0 ],
                  [ 0, 0, 0, 0, 4 ]]

echelon_form_2 = [[ 0, 4, 3, 4, 4 ],
                  [ 0, 0, 4, 2, 0 ],
                  [ 0, 0, 0, 0, 1 ],
                  [ 0, 0, 0, 0, 0 ]]

echelon_form_3 = [[ 1, 0, 0, 1 ],
                  [ 0, 0, 0, 1 ],
                  [ 0, 0, 0, 0 ]]

echelon_form_4 = [[ 1, 0, 0, 0 ],
                  [ 0, 1, 0, 0 ],
                  [ 0, 0, 0, 0 ],
                  [ 0, 0, 0, 0 ]]



## Problem 2
def is_echelon(A):
    '''
    Input:
        - A: a list of row lists
    Output:
        - True if A is in echelon form
        - False otherwise
    Examples:
        >>> is_echelon([[1,1,1],[0,1,1],[0,0,1]])
        True
        >>> is_echelon([[0,1,1],[0,1,0],[0,0,1]])
        False
    '''
    result = True
    prev_non_null = 0
    r = 0
    while ( result and r < len(A) ):
        c = 0
        while ( result and c <= len(A[r]) and (c == len(A[r]) or A[r][c] == 0) ):
            c = c + 1
        if ( 0 == r): prev_non_null = c
        if ( r > 0 and ( c <= prev_non_null and not ( c == len(A[r]) + 1 and prev_non_null == len(A[r]) + 1 ) ) ):
            result = False
            break
        prev_non_null = c
        r = r + 1
    return result     


## Problem 3
# Give each answer as a list

echelon_form_vec_a = [1, 0, 3, 0]
echelon_form_vec_b = [-3, 0, -2, 3]
echelon_form_vec_c = [-5, 0, 2, 0, 2]



## Problem 4
# If a solution exists, give it as a list vector.
# If no solution exists, provide "None".

solving_with_echelon_form_a = None
solving_with_echelon_form_b = [ 21, 0, 2, 0, 0 ]


## Problem 5
def echelon_solve(rowlist, label_list, b):
    '''
    Input:
        - rowlist: a list of Vecs
        - label_list: a list of labels establishing an order on the domain of
                      Vecs in rowlist
        - b: a vector (represented as a list)
    Output:
        - Vec x such that rowlist * x is b
    >>> D = {'A','B','C','D','E'}
    >>> U_rows = [Vec(D, {'A':one, 'E':one}), Vec(D, {'B':one, 'E':one}), Vec(D,{'C':one})] 
    >>> b_list = [one,0,one]
    >>> cols = ['A', 'B', 'C', 'D', 'E']
    >>> echelon_solve(U_rows, cols, b_list)
    Vec({'B', 'C', 'A', 'D', 'E'},{'B': 0, 'C': one, 'A': one})
    '''
    D = rowlist[0].D
    x = zero_vec(D)
    for j in reversed(range(len(b))):
        row = rowlist[j]
        l = [(i,row[i]) for i in label_list if row[i] !=0]
        if len(l)> 0: nonzero = l[0]
        else: continue
        c = nonzero[0]
        x[c] = (b[j] - x*row)/nonzero[1]
    return x


## Problem 6
rowlist = [Vec({'A','B','C','D'}, {'A':one, 'B':one, 'D':one}), Vec({'A','B','C','D'}, {'B':one}), Vec({'A','B','C','D'}, {'C':one}), Vec({'A','B','C','D'}, {'D':one})]     # Provide as a list of Vec instances
label_list = [ 'A','B','C','D' ] # Provide as a list
#b = rowdict2mat([Vec({'A','B','C','D'}, {'A':one}), Vec({'A','B','C','D'}, {'A':one, 'B':one}), Vec({'A','B','C','D'}, {'A':one, 'C':one}), Vec({'A','B','C','D'}, {'A':one, 'C':one, 'D':one})])* Vec({'A','B','C','D'}, {'A':one, 'C':one})         # Provide as a list
b = [ one, one, 0, 0 ] 
#print (b)


## Problem 7
null_space_rows_a = {3, 4} # Put the row numbers of M from the PDF
#print( Vec({'a','b','c','d','e'}, {'a':one, 'c':one, 'e':one}) * coldict2mat([Vec({'a','b','c','d','e'}, {'c':one, 'd':one, 'e':one}), Vec({'a','b','c','d','e'}, {}), Vec({'a','b','c','d','e'}, {}), Vec({'a','b','c','d','e'}, {'a':one, 'b':one, 'c':one}), Vec({'a','b','c','d','e'}, {'b':one, 'd':one}) ]) )


## Problem 8
null_space_rows_b = {4}
#print( Vec({'a','b','c','d','e'}, {'c':one, 'e':one}) * coldict2mat([Vec({'a','b','c','d','e'}, {'c':one, 'd':one, 'e':one}), Vec({'a','b','c','d','e'}, {'d':one}), Vec({'a','b','c','d','e'}, {'d':one}), Vec({'a','b','c','d','e'}, {'a':one, 'b':one, 'c':one,'e':one}), Vec({'a','b','c','d','e'}, {'b':one, 'd':one}) ]) )


## Problem 9
# Write each vector as a list
closest_vector_1 = [1.6, 3.2]
closest_vector_2 = [0,1,0]
closest_vector_3 = [3,2,1,-4]



## Problem 10
# Write each vector as a list

project_onto_1 = [2,0]
projection_orthogonal_1 = [0,1]

project_onto_2 = [-0.1666666667,-0.3333333333,0.1666666667]
projection_orthogonal_2 = [1.1666666667,1.3333333333,3.8333333333]

project_onto_3 = [1,1,4]
projection_orthogonal_3 = [0,0,0]



## Problem 11
norm1 = 3
norm2 = 4
norm3 = 1

