function [output] = myRadonTrans(image, delta_s, delta_t, delta_theta)

t_val = -90:delta_t:90;
theta_val = 0:delta_theta:175;

m = length(t_val);
n = length(theta_val);

output = zeros([m,n]);

for i = 1:m
    for j = 1:n
        output(i,j) = myIntegration(image,t_val(i),theta_val(j),delta_s);
    end
end

output(isnan(output)) = 0;

end

