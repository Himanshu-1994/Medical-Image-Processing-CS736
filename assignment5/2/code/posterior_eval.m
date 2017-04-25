function [value]= posterior_eval(X,Y,u,s,mask,beta_val)

value = 0;

for i = 2:size(Y,1)-1
   for j = 2:size(Y,2)-1
       if mask(i,j)==0
           continue
       end
           label = X(i,j);
           prior_val = Prior(X, label, i, j, mask, beta_val);
           log_posterior = (- ( 1 - beta_val ) * (Y(i, j) - u(1, label))^2 / (2 * s(1,label)^2)) - log(s(1,label));
           value = value + log(prior_val) + log_posterior;
       
   end
end
