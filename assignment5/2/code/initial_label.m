function Z = initial_label(Y,mask) 

%     Y = Y - min(Y(:));
%     maximum = max(Y(:));
%     
%     Z = zeros(size(Y, 1), size(Y, 2));
%     
%     positions = and(Y <= maximum, mask == 1);
%     Z(positions) = 3;
%     
%     positions = and(Y <= 2 * maximum / 3, mask == 1);
%     Z(positions) = 2;
%     
%     positions = and(Y <= maximum / 3, mask == 1);
%     Z(positions) = 1; 
%     
% Kmeans initialization
[cluster_idx, ~] = kmeans(Y(:),4,'distance','sqEuclidean', ...
'Replicates',5);
cluster_idx(cluster_idx==1) = 0;
cluster_idx(cluster_idx==2) = 3;
cluster_idx(cluster_idx==3) = 2;
cluster_idx(cluster_idx==4) = 1;
Z = (reshape(cluster_idx,256,256));
Z(logical(mask==0)) = 0;
for i = 1:256
    for j =1:256
        if mask(i,j) == 1 && Z(i,j)==0
            Z(i,j)  = 3;
        end
    end
end

end




