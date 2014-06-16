load('pop_coding.mat')
max(r1)
max(r2)
max(r3);
max(r4);
vec = max(r1) * c1 + max(r2) * c2 + max(r3) * c3 + max(r4) * c4
x = vec(1)
y = vec(2)
[THETA,RHO] = cart2pol(x, y)
THETA * ( 180 / pi())
c1
c2
