function [output] = compute_obj_fun_2(Y,M,X,alpha,gamma)
X1 = circshift(X,-1,1);
X2 = circshift(X,1,1);
X3 = circshift(X,-1,2);
X4 = circshift(X,1,2);

V1 = abs(X-X1);
V1(V1<=gamma) = 0.5*(V1(V1<=gamma).^2);
V1(V1>gamma) = gamma*V1(V1>gamma) - 0.5*(gamma^2);

V2 = abs(X-X2);
V2(V2<=gamma) = 0.5*V2(V2<=gamma).^2;
V2(V2>gamma) = gamma*V2(V2>gamma) - 0.5*(gamma^2);

V3 = abs(X-X3);
V3(V3<=gamma) = 0.5*V3(V3<=gamma).^2;
V3(V3>gamma) = gamma*V3(V3>gamma) - 0.5*(gamma^2);

V4 = abs(X-X4);
V4(V4<=gamma) = 0.5*V4(V4<=gamma).^2;
V4(V4>gamma) = gamma*V4(V4>gamma) - 0.5*(gamma^2);

output = (1-alpha)*sum(sum((abs(Y-M.*(fft2(X)))).^2)) + 0.5*alpha*(sum(sum(V1+V2+V3+V4)));

end

