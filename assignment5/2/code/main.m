clear;
close all;

load('../data/assignmentSegmentBrainGmmEmMrf.mat');
rng(0);
Y = imageData;
mask = imageMask;
K = 3;

Z = initial_label(Y,mask);

plot_images(Z,'Initial Estimate for labels via Kmeans')
m = zeros(1,K);
s = zeros(1,K);

for label = 1:K
   
    m(1,label) = mean(Y(logical(Z==label))); 
    s(1,label) = std(Y(logical(Z==label))); 
end

%% EM beta = 0.35
display('Beta = 0.35');
beta = 0.35;
[seg, G, m_0] = EMLabels(Y, mask, K, Z, m, s, beta);
plot_images(imageData, 'Original Corrupted Image');
plot_images(G(:, :, 1), 'Class-Membership for Label 1 : beta = 0.35');
plot_images(G(:, :, 2), 'Class-Membership for Label 2 : beta = 0.35');
plot_images(G(:, :, 3), 'Class-Membership for Label 3 : beta = 0.35');
plot_images(seg, 'GMM-MRF-EM Image Segmentation : beta = 0.35');

%% EM beta = 0
display('Beta = 0');
beta = 0;
[seg, G, m_1] = EMLabels(Y, mask, K, Z, m, s, beta);
plot_images(G(:, :, 1), 'Class-Membership for Label 1 : beta = 0');
plot_images(G(:, :, 2), 'Class-Membership for Label 2 : beta = 0');
plot_images(G(:, :, 3), 'Class-Membership for Label 3 : beta = 0');
plot_images(seg, 'GMM-MRF-EM Image Segmentation : beta = 0');


%%
%%
% 
% * The optimal value of *beta is = 0.35* 
% * The label image is initialized to kmeans with 3 clusters.This  is a
% fast way of getting good initialization for the labels.
% * Initial Estimates for class means and variance are obtained from the
% initialized labels by taking membership to any class as 1 and hence mean
% and standard deviations are that of sample data in that class.
% * Initial Mean = [0.2963, 0.6049, 0.5062] ; Initial Standard Deviation = [0.0595, 0.1106, 0.0413] 
% * Optimal estimate of class means for *beta = 0.35* are
% [0.3193, 0.6286, 0.5221] and for *beta = 0* are [0.3795, 0.6358, 0.5346]
% 