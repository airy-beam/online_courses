from orthogonalization import orthogonalize, aug_orthogonalize
import math
from vec import Vec

def orthonormalize(L):
    '''
    Input: a list L of linearly independent Vecs
    Output: A list T of orthonormal Vecs such that for all i in [1, len(L)],
            Span L[:i] == Span T[:i]
    '''
    return [ (1/math.sqrt(x*x)) * x for x in orthogonalize(L)]

def adjust(v, multipliers):
    return Vec(v.D, { i: multipliers[i]*v[i] for i in v.D } )


def aug_orthonormalize(L):
    '''
    Input:
        - L: a list of Vecs
    Output:
        - A pair Qlist, Rlist such that:
            * coldict2mat(L) == coldict2mat(Qlist) * coldict2mat(Rlist)
            * Qlist = orthonormalize(L)
    '''
    Q, R = aug_orthogonalize(L)
    Qlist = orthonormalize(L)
    Rlist = [ adjust(r, [ math.sqrt(x*x) for x in Q ]) for r in R ]
    #Rlist = [ math.sqrt(x*x) for x in Q ]
    return Qlist, Rlist
