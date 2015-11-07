close all;
clear all;

for i =1:3
    
    subj = sprintf('subj%d',i);
    load(fullfile(pwd,'..','clrmaps.mat'));
    load(fullfile(pwd,subj,'connectome.mat'));
    
    load(fullfile(pwd,subj,'FC.mat'))
    %figure, imagesc(Taal_lp'); colormap jet; xlabel('time'); ylabel('regions');
    
    % regions to keep
    lregs = [ 222, 205, 207, 200, 199, 192, 178, 175, 184 ];
    rregs = [ 86, 98, 72, 67, 66, 70, 69, 44, 41, 43 ];
    regs = [ lregs rregs ];
    
    % subset the beginning
    % yeoOrder = yeoOrder(regs);
    
    % subset to ROIs in occipital / partietal
    % Taal_lp = Taal_lp(:, [ lregs rregs ]);
    
    FC=corr(Taal_lp); % pairwise pearson correllations between every two time series.
    
    load('../ordering_matrices/yeo_RS7.mat');
    
    avgSignal = mean(Taal_lp');
    threshold = 1.00;
    mask = abs(avgSignal) < threshold;
    
    nnz(~mask)
    
    FCclean=corr(Taal_lp(mask,:));
    
    N=size(FC,1);
    maskut = triu(true(N,N),1);
    
    C=ones(1200,1);
    R=nan(size(Taal_lp));
    for i = 1:N
        ts=Taal_lp(:,i);
        [a,b,r]=regress(ts,[avgSignal',C]);
        R(:,i)=r;
    end
    
    % figure, imagesc(R'); colormap jet;
    % caxis([-0.8 0.8])
    
    FCR=corr(R);
    FCR = FCR(regs, regs); % SUBSET JUST THE REGIONS WE WANT
    % figure, imagesc(FCR(yeoOrder,yeoOrder),[-1,1]); axis square; xlabel('regions'); ylabel('regions');
    figure, imagesc(FCR,[-1,1]); axis square; xlabel('region #'); ylabel('region #');
    ax = gca; ax.XTick = 1:size(regs, 2); ax.YTick = 1:size(regs, 2); ax.XTickLabel = {regs}; ax.YTickLabel = {regs};
    title('FC clean')
    colormap(redblue(end:-1:1,:)./255)
    
    % figure, hist(FCR(mask),50); axis square;
    save(fullfile(pwd,subj,'FC_new.mat'),'FCR');
    
    %SC = M_w;  %(yeoOrder,yeoOrder);
    %ncomm = unique(yeoROIs);
    %for cc1 = 1:length(ncomm)
    %    ff = find(yeoROIs == ncomm(cc1));
    %    for cc2 = cc1:length(ncomm)
    %        gg = find(yeoROIs == ncomm(cc2));
    %        rsn_dens(cc1,cc2) = nnz(SC(ff,gg));
    %        rsn_dens(cc1,cc2) = rsn_dens(cc1,cc2)./(length(ff)*length(gg));
    %    end
    %end
    
end
