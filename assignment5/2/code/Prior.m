function [prior_val] = Prior(Z,label,i,j,mask,beta)
    S = 0;
    if mask(i - 1, j) == 1
        S = S + (Z(i - 1, j) ~= label);
    end
    if mask(i + 1, j) == 1
        S = S + (Z(i + 1, j) ~= label);
    end
    if mask(i, j - 1) == 1
        S = S + (Z(i, j - 1) ~= label);
    end
    if mask(i, j + 1) == 1
        S = S + (Z(i, j + 1) ~= label);
    end

    prior_val = exp(-beta*S);
end

