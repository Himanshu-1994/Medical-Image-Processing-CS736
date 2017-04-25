function [X,obj_fun] = denoise_1(Y,alpha)

num = 100;
step_size = 0.1;
obj_fun = zeros([num,1]);

X = Y;

for i = 1:num
    obj_fun(i) = compute_obj_fun_1(Y,X,alpha);
    grad = compute_grad_1(Y,X,alpha);
    S = X - step_size.*grad;
    if (compute_obj_fun_1(Y,S,alpha)<compute_obj_fun_1(Y,X,alpha))
        X = S;
        step_size = step_size + 0.1*step_size;
    else
        step_size = step_size - 0.5*step_size;
    end
end

end

