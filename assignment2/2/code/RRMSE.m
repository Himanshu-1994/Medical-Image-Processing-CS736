function [err] = RRMSE(A,B )
err = sqrt((sum(sum((A-B).^2)))/(sum(sum(A.^2))));
end

