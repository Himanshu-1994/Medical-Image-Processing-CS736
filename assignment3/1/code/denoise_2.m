function [X,obj_fun] = denoise_2(Y,alpha,gamma)

num = 100;
step_size = 0.1;
obj_fun = zeros([num,1]);

X = Y;

for i = 1:num
    obj_fun(i) = compute_obj_fun_2(Y,X,alpha,gamma);
    grad = compute_grad_2(Y,X,alpha,gamma);
    S = X - step_size.*grad;
    if (compute_obj_fun_2(Y,S,alpha,gamma)<compute_obj_fun_2(Y,X,alpha,gamma))
        X = S;
        step_size = step_size + 0.1*step_size;
    else
        step_size = step_size - 0.5*step_size;
    end
end

end