function [output] = compute_obj_fun_3(Y,M,X,alpha,gamma)
X1 = circshift(X,-1,1);
X2 = circshift(X,1,1);
X3 = circshift(X,-1,2);
X4 = circshift(X,1,2);

V1 = gamma*abs(X-X1) - (gamma^2)*log(1 + (abs(X-X1))./gamma);
V2 = gamma*abs(X-X2) - (gamma^2)*log(1 + (abs(X-X2))./gamma);
V3 = gamma*abs(X-X3) - (gamma^2)*log(1 + (abs(X-X3))./gamma);
V4 = gamma*abs(X-X4) - (gamma^2)*log(1 + (abs(X-X4))./gamma);

output = (1-alpha)*sum(sum((abs(Y-M.*(fft2(X)))).^2)) + 0.5*alpha*sum(sum(V1+V2+V3+V4));

end