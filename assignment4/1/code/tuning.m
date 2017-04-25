load('../data/assignmentImageReconstructionPhantom.mat');
%load('../data/assignmentImageReconstructionBrain.mat');
%[m,n] = size(imageNoiseless);
Y = imageKspaceData;
X_init = real(ifft2(Y));
A = imageNoiseless;
M = imageKspaceMask;


%% Prior 1

% alpha = 0:0.01:1;
% 
% err = zeros([101,1]);
% 
% for i = 1:101
%     [X, obj_fun] = reconstruct_1(X_init,Y,M,alpha(i));
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
 
[denoised_image_1, obj_fun_1] = reconstruct_2(X_init,Y,M,0.71,0.01);

% [X,obj_fun] = denoise_3(Y,0.95,0.007);
% RRMSE(X,A)
% [X,~] = denoise_3(Y,0.55,0.07);
% figure();
% imshow(abs(X))