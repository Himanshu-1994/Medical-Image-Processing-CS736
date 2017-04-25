%% Que3
% 
% * Code for alignment of two point sets is in *'alignment.m'*
% * Code for finding optimal mean shape per iteration is in *'optimal_mean.m'*
% * Rest of the code including calculation of *'Modes of Variation'* is implemented below.
clear all;
load('../data/bone3D.mat');
no_shapes = 30;
no_points = 252;
z = shapesTotal;
z_a = z;

%% Convert all shapes to pre-shape space

T = sum(z,2)./no_shapes;
zc = bsxfun(@minus,z,T);
zs = reshape(zc,[3*no_points,no_shapes]);
s = sqrt(sum(zs.^2));
zpre = bsxfun(@rdivide,zs,s);
zp = reshape(zpre,[3,no_points,no_shapes]);

%Initialze z_mean to one of the points
z_mean = sum(zp,3);
s = sqrt(z_mean(:)'*z_mean(:));
z_mean = z_mean./s;

%% Allign Points and Find Mean Shape
step = 1;
iter = 0;

while step > 10e-7
    
    [zp,z_mean_opt]=optimal_mean(zp,z_mean);
    a = bsxfun(@minus,zp,z_mean_opt);
    error = sum(sum(sum(a.*a)));
    step = sum(sum((z_mean-z_mean_opt).^2));
    z_mean = z_mean_opt;
    fprintf('Iter = %d Change in position of z_mean is %d\n',iter,step);
    iter = iter+1;
end

%% Plot of Original Point Set
K = no_points;
N = no_shapes;
figure();
S = repmat(5,K,1)';
no_points = 252;
for i =1:N
C = repmat(rand(1,3),K,1);
%patch('Vertices',z_mean','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','interp','EdgeColor','b',...
%    'FaceAlpha','1');
scatter3(z_a(1,:,i),z_a(2,:,i),z_a(3,:,i),S,C,'filled');
hold on;

end
hold off;
title('Orignal data points');

%% Plot of mean shape with aligned point

figure();
S = repmat(5,K,1)';
for i =1:N
C = repmat(rand(1,3),K,1);
scatter3(zp(1,:,i),zp(2,:,i),zp(3,:,i),S,C,'filled');
hold on;
end

S = repmat(30,K,1)';
C = repmat([0,0,1],K,1);
%scatter3(z_mean(1,:),z_mean(2,:),z_mean(3,:),S,C,'filled');
%line(z_mean(1,:),z_mean(2,:),z_mean(3,:),'Color','r','Linewidth',1.5);

f2 = patch('Vertices',z_mean','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','b','EdgeColor','b',...
    'FaceAlpha','0.3');

view(3);
hold off;
title('Mean Shape and Aligned PointSets');

%% Calculate and Plot Principal Modes Of Variation

a = bsxfun(@minus,zp,z_mean);
x = [a(1,:,:) a(2,:,:) a(3,:,:)];
x = reshape(x,[3*no_points,no_shapes]);
Ca = (x*x')./no_shapes;
[V,E] = eig(Ca);
eig_values = diag(E);

figure();
plot(flipud(eig_values),'b');
ylabel('Magnitude');
xlabel('Eigen Values');
title('Plot of Variance (Eigen Values)');

%% Calculate and Plot Principal Modes Of Variation

z_a = [z_mean(1,:) (z_mean(2,:)) (z_mean(3,:))]' ;

ind = [756 755];
for i = 1:2

pmv1=z_a-2*sqrt(eig_values(ind(i)))*V(:,ind(i));
p = zeros(size(z_mean));
p(1,:) = pmv1(1:end/3); 
p(2,:) = pmv1(end/3+1:2*end/3); 
p(3,:) = pmv1((2*end/3)+1:end); 
 

pmv2=z_a+2*sqrt(eig_values(ind(i)))*V(:,ind(i));
p1 = zeros(size(z_mean));
p1(1,:) = pmv2(1:end/3); 
p1(2,:) = pmv2(end/3+1:2*end/3); 
p1(3,:) = pmv2((2*end/3)+1:end); 


figure();
set(gcf,'units','centimeters','position',[0 0 30 12]);
subplot(1,3,1)
f1 = patch('Vertices',p','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','r','EdgeColor','r',...
    'FaceAlpha','0.3','EdgeAlpha','0.3');
view([1,0.5,-0.5])
hold on
subplot(1,3,2)
f2 = patch('Vertices',z_mean','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','b','EdgeColor','b',...
    'FaceAlpha','0.3','EdgeAlpha','0.3');
view([1,0.5,-0.5])
subplot(1,3,3)
f3 = patch('Vertices',p1','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','g','EdgeColor','g',...
    'FaceAlpha','0.3','EdgeAlpha','0.3');
view([1,0.8,-0.5])
legend([f1 f2 f3],'-2*{\surd}\lambda','Mean','+2*{\surd}\lambda')
suptitle(strcat('Modes of Variation for ',' Eigen Value:',num2str(i),' = ',num2str(eig_values(ind(i)))));

hold off;

figure();
set(gcf,'units','centimeters','position',[0 0 30 12]);
f1 = patch('Vertices',p','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','none','EdgeColor','r',...
    'FaceAlpha','0.3','EdgeAlpha','1');
hold on

f2 = patch('Vertices',z_mean','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','none','EdgeColor','b',...
    'FaceAlpha','0.3','EdgeAlpha','1');

f3 = patch('Vertices',p1','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','none','EdgeColor','g',...
    'FaceAlpha','0.3','EdgeAlpha','1');

view([1 1 0])

legend([f1 f2 f3],'-2*{\surd}\lambda','Mean','+2*{\surd}\lambda')
title(strcat('Modes of Variation for ',' Eigen Value:',num2str(i),' = ',num2str(eig_values(ind(i)))));

figure();
set(gcf,'units','centimeters','position',[0 0 25 15]);
f1 = patch('Vertices',p','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','r','EdgeColor','r',...
    'FaceAlpha','0.5','EdgeAlpha','0.6');
view([1,0.5,-0.5])
hold on

f2 = patch('Vertices',z_mean','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','b','EdgeColor','b',...
    'FaceAlpha','0.5','EdgeAlpha','0.6');
view([1,0.5,-0.5])

f3 = patch('Vertices',p1','Faces',TriangleIndex,'FaceVertexCData',(1:252)','FaceColor','g','EdgeColor','g',...
    'FaceAlpha','0.5','EdgeAlpha','0.6');
view([1,0.8,-0.5])
legend([f1 f2 f3],'-2*{\surd}\lambda','Mean','+2*{\surd}\lambda')
suptitle(strcat('Alligned PointSets and Modes of Variation for ',' Eigen Value:',num2str(i),' = ',num2str(eig_values(ind(i)))));

S = repmat(6,K,1)';
for j =1:N
C = repmat(rand(1,3),K,1);
scatter3(zp(1,:,j),zp(2,:,j),zp(3,:,j),S,C,'filled');
hold on;
end
hold off;
end