function [output] = compute_obj_fun_1(Y,M,X,alpha)
X1 = circshift(X,-1,1);
X2 = circshift(X,1,1);
X3 = circshift(X,-1,2);
X4 = circshift(X,1,2);

output = (1-alpha)*sum(sum((abs(Y-M.*(fft2(X)))).^2)) + 0.5*alpha*sum(sum((abs(X-X1)).^2 + (abs(X-X2)).^2 + abs((X-X3)).^2 + abs((X-X4).^2)));

end

