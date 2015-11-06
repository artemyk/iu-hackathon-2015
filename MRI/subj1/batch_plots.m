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

figure, imagesc(Taal_lp'); colormap jet; xlabel('time'); ylabel('regions');

FC=corr(Taal_lp); % pairwise pearson correllations between every two time series.
figure, imagesc(FC); axis square; colormap jet; xlabel('regions'); ylabel('regions');

load('../../ordering_matrices/yeo_RS7.mat');

figure, imagesc(FC(yeoOrder,yeoOrder)); axis square; colormap jet; xlabel('regions'); ylabel('regions');
 
avgSignal = mean(Taal_lp');
figure, plot(avgSignal)
threshold =2;
mask = abs(avgSignal)<threshold;

nnz(~mask)

FCclean=corr(Taal_lp(mask,:));
figure, imagesc(FCclean(yeoOrder,yeoOrder)); axis square; colormap jet; xlabel('regions'); ylabel('regions');


