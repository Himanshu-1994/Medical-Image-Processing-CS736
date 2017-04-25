%load('../data/assignmentImageDenoisingPhantom.mat');
load('../data/assignmentImageDenoisingBrainNoisy.mat');
[m,n] = size(imageNoisy);
Y = imageNoisy;
%A = imageNoiseless;

%% Prior 1

% alpha = 0:0.01:1;
% 
% err = zeros([101,1]);
% 
% for i = 1:101
%     [X, obj_fun] = denoise_1(Y,alpha(i));
%     err(i,1) = RRMSE(X,A);
% end

%% Prior 2

% alpha = 0:0.01:1;
% gamma = 0:0.1:10;
% 
% err = zeros([101,101]);
% 
% for i = 1:101
%     for j = 1:101
%         [X,obj_fun] = denoise_2(Y,alpha(i),gamma(j));
%         err(i,j) = RRMSE(X,A);
%     end
% end

%% Trial & Error
% 
% [X,obj_fun] = denoise_3(Y,0.95,0.007);
% RRMSE(X,A)
[X,~] = denoise_3(Y,0.55,0.07);
figure();
imshow(abs(X))