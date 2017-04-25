function [grad] = compute_grad_1(Y,M,X,alpha)
X1 = circshift(X,-1,1);
X2 = circshift(X,1,1);
X3 = circshift(X,-1,2);
X4 = circshift(X,1,2);

grad = (1-alpha)*2.*(ifft2(M.*fft2(X)-Y)) + alpha*2.*((X-X1) + (X-X2) + (X-X3) + (X-X4));

end

