A = [1 0 -4 8 3; 4 -2 3 3 1];
b = zeros(1,4);
for index = 1:size(A,2)
  if A(1,index) > A(2,index)
    b(index) = A(1,index);
  else
    b(index) = A(2,index);
  end
end
b
