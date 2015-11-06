close all;
clear all;

load connectome.mat;

figure,
subplot(1,3,1);
imagesc(log10(M_ll)); colormap jet; axis square; colorbar
subplot(1,3,2);
imagesc(log10(M_nf)); colormap jet; axis square; colorbar
subplot(1,3,3);
imagesc(log2(M_w)); colormap jet; axis square; colorbar

load FC.mat