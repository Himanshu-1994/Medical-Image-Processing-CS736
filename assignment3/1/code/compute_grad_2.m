function [grad] = compute_grad_2(Y,X,alpha,gamma)
X1 = circshift(X,-1,1);
X2 = circshift(X,1,1);
X3 = circshift(X,-1,2);
X4 = circshift(X,1,2);

G1 = X - X1;
G1(abs(G1)>gamma) = (G1(abs(G1)>gamma)*gamma)./(abs(G1(abs(G1)>gamma)));

G2 = X - X2;
G2(abs(G2)>gamma) = (G2(abs(G2)>gamma)*gamma)./(abs(G2(abs(G2)>gamma)));

G3 = X - X3;
G3(abs(G3)>gamma) = (G3(abs(G3)>gamma)*gamma)./(abs(G3(abs(G3)>gamma)));

G4 = X - X4;
G4(abs(G4)>gamma) = (G4(abs(G4)>gamma)*gamma)./(abs(G4(abs(G4)>gamma)));

grad = (1-alpha)*2.*(X-Y) + alpha*(G1 + G2 + G3 + G4);

end

