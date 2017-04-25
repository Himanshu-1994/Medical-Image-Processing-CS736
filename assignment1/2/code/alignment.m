function [z2new,T,s,R] = alignment(z1,z2)

N =  size(z1,2);
T = (sum(z1,2)-sum(z2,2))./N;

z1 = bsxfun(@minus,z1,T);
% M = HX
M = zeros(2,1);
M(1) = sum(sum((z1.*z2),1),2);
z_int = (flipud(z1).*z2);
z_int(2,:) =z_int(2,:).*-1;
M(2) = sum(sum(z_int));

%H = eye(2,2);7
%H = H.* sum(sum(z2.*z2));
h = sum(sum(z2.*z2));
a = M./h; 
s = sqrt(a'*a);
theta = atan2(a(2),a(1));
R = [cos(theta) -1*sin(theta);sin(theta),cos(theta)];
z2new = bsxfun(@plus,(s*R)*z2,T);
