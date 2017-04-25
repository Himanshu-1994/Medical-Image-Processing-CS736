function [X,obj_fun] = reconstruct_2(X_init,Y,M,alpha,gamma)

num = 50;
step_size = 0.1;
%obj_fun = zeros([num,1]);
obj_fun = [];
obj_fun = [obj_fun,compute_obj_fun_2(Y,M,X_init,alpha,gamma)];
X = X_init;

for i = 1:num
    %obj_fun(i) = compute_obj_fun_2(Y,M,X,alpha,gamma);
    grad = compute_grad_2(Y,M,X,alpha,gamma);
    S = X - step_size.*grad;
    if (compute_obj_fun_2(Y,M,S,alpha,gamma)<compute_obj_fun_2(Y,M,X,alpha,gamma))
        X = S;
        obj_fun = [obj_fun,compute_obj_fun_2(Y,M,X,alpha,gamma)];
        step_size = step_size + 0.1*step_size;
    else
        step_size = step_size - 0.5*step_size;
    end
end

obj_fun = [obj_fun,compute_obj_fun_2(Y,M,X,alpha,gamma)];
%X = real(X);

end