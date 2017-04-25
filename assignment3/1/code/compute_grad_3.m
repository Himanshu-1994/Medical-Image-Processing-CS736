function [grad] = compute_grad_3(Y,X,alpha,gamma)
X1 = circshift(X,-1,1);
X2 = circshift(X,1,1);
X3 = circshift(X,-1,2);
X4 = circshift(X,1,2);

G1 = 2*(X-X1).*(gamma./(2*(gamma + abs(X-X1))));
G2 = 2*(X-X2).*(gamma./(2*(gamma + abs(X-X2))));
G3 = 2*(X-X3).*(gamma./(2*(gamma + abs(X-X3))));
G4 = 2*(X-X4).*(gamma./(2*(gamma + abs(X-X4))));

grad = (1-alpha)*2.*(X-Y) + alpha*(G1 + G2 + G3 + G4);

end