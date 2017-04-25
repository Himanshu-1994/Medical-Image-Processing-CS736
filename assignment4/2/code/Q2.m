%% Q2
load('../data/assignmentImageReconstructionBrain.mat');
Y = imageKspaceData;
[m,n] = size(Y);
M = imageKspaceMask;
X_init = (ifft2(Y));

%% Reconstruction

alpha_1 = 0.9998;
[reconstructed_image_1, obj_fun_1] = reconstruct_1(X_init,Y,M,alpha_1);

alpha_2 = 0.9999;
gamma_2 = 0.01;
[reconstructed_image_2, obj_fun_2] = reconstruct_2(X_init,Y,M,alpha_2,gamma_2);

alpha_3 = 0.9999;
gamma_3 = 0.017;
[reconstructed_image_3, obj_fun_3] = reconstruct_3(X_init,Y,M,alpha_3,gamma_3);

%% Displaying the Images

figure();
imshow(abs(X_init))
title('InverseFourier-KspaceData')

figure();
imshow(abs(reconstructed_image_1))
title('Reconstructed Image using Quadratic Prior')

figure();
imshow(abs(reconstructed_image_2))
title('Reconstructed Image using Huber Prior')

figure();
imshow(abs(reconstructed_image_3))
title('Reconstructed Image using Discontinuity Adaptive Prior')

%% Plotting the objective functions

figure();
plot(obj_fun_1)
title('Quadratic Prior')

figure();
plot(obj_fun_2)
title('Huber Prior')

figure();
plot(obj_fun_3)
title('Discontinuity Adaptive Prior')