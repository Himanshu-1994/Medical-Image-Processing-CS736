function [output] = RRMSE(Y,X)
% X is the reference image
X1 = abs(X);
Y1 = abs(Y);

output = sqrt(sum(sum((X1-Y1).^2)))/sqrt(sum(sum(X1.^2)));

end

