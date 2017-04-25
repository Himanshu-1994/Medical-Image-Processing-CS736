function [X,obj_fun] = reconstruct_1(X_init,Y,M,alpha)

num = 50;
step_size = 0.1;
%obj_fun = zeros([num,1]);
obj_fun = [];
obj_fun = [obj_fun,compute_obj_fun_1(Y,M,X_init,alpha)];
X = X_init;

for i = 1:num
    %obj_fun(i) = compute_obj_fun_1(Y,M,X,alpha);
    grad = compute_grad_1(Y,M,X,alpha);
    S = X - step_size.*grad;
    if (compute_obj_fun_1(Y,M,S,alpha)<compute_obj_fun_1(Y,M,X,alpha))
        X = S;
        obj_fun = [obj_fun,compute_obj_fun_1(Y,M,X,alpha)];
        step_size = step_size + 0.1*step_size;
    else
        step_size = step_size - 0.5*step_size;
    end
end

obj_fun = [obj_fun,compute_obj_fun_1(Y,M,X,alpha)];
% X = real(X);

end

