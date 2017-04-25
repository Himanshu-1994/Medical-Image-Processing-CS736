function [z2new,R] = alignment(z1,z2)

N =  size(z1,2);
X = z2;
Y = z1;
W = eye(N);

% SVD of XWYt
A = X*W*Y';
[U,E,V] = svd(A);

M=eye(3);

R = V*M*U';

if det(R)==-1
    M(end,end) = -1;
    R = V*M*U';
end
z2new = R*X;