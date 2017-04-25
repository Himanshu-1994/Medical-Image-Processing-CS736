function [z_new,z_mean_new] = optimal_mean(z,z_mean)

z_new = zeros(size(z));
N =size(z,3);
for i = 1:N
  [z_new(:,:,i),~,~,~]=alignment(z_mean,z(:,:,i));
end

z_mean_new = sum(z_new,3)./N;
end

