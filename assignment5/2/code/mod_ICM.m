function [Z, u, s,eval] =  mod_ICM( Y, mask, K, X, u, s, beta_val)
Z = X;
X_new = X;
old_pos = posterior_eval(X,Y,u,s,mask,beta_val);

for iter = 1:10
for i = 2:size(Y,1)-1
   for j = 2:size(Y,2)-1

       if (mask(i, j) == 0)
           continue;
       end

       values = zeros(1, K);

       for label = 1:K
           prior_val = Prior(X, label, i, j, mask, beta_val);
           posterior = (- ( 1 - beta_val ) * (Y(i, j) - u(1, label))^2 / (2 * s(1,label)^2)) - log(s(1,label));
           values(label) = posterior + log(prior_val);

       end

       [~, index] = max(values);
       X_new(i, j) = index;
   end
end

new_pos = posterior_eval(X_new,Y,u,s,mask,beta_val);

if (new_pos > old_pos)
    Z = X_new .* mask;
    break
else
    X = X_new; 
end
end

display(sprintf('ICM change in Posterior -> log(P(x | y, beta_val, theta)) : oldpos = %d => newpos = %d ',old_pos,new_pos));

if (new_pos<=old_pos)
    display(sprintf('\nPosterior not increased.No MAP update.\n'))
    eval = 0;
else
eval = 1;
end  
     
   
end

