function [Z,G,m] = EMLabels(Y, mask, K, Z, m, s, beta_val)

G = zeros(size(Y,1),size(Y,2),K);

for iterations = 1:40
    
    % MAP estimate of Label Image
    [Z,m,s,eval] = mod_ICM(Y,mask,K,Z,m,s,beta_val);
    
    if eval == 0
       display('Terminating');
       break    
    end
    
    % Membership Calculation
    for i = 2:size(Y,1)-1
        for j = 2:size(Y,2)-1

            if mask(i,j) > 0

            member = zeros(1,K);
            
            for l = 1:K
                
                % Calculate Prior
                Pr = Prior(Z,l,i,j,mask,beta_val);
                % Calculate Posterior
                Ps = exp(-1*(1- beta_val)*(Y(i,j)-m(l))^2/(2 * s(1, l)^2))/s(1,l);
                    
                member(1,l)= Ps*Pr;
            end
            
            member = member./sum(member);
            
            if (sum(isnan(member)) > 0)
                G(i,j,:) = G(i,j,:);
            else
                G(i,j,:) = member;
            end
            
            end

        end  
    end
    
    % Update mean and Variances
    
    for labels = 1:K
        m(1,labels) = sum(sum(G(:,:,labels).*Y))/sum(sum(G(:,:,labels)));
        s(1,labels) = sqrt(sum(sum(G(:,:,labels).*((Y(:,:)-m(labels)).^2)))/sum(sum(G(:,:,labels))));
    end
    
end

end

