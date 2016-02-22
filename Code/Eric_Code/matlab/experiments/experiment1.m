clear, clf

d = 100;
Nsims=5;
nvec = round(logspace(1,2.3,10));

for i=1:Nsims
    display(i)
    switch i
        case 1
            C = eye(d);
        case 2
            C = ones(d) + eye(d);
        case 3
            C = ones(d) + eye(d);
            C(end,1) = 0;
            C(1,end) = 0;
        case 4
            C = ones + eye(d);
            C(end - 1, 2) = 0;
            C(2, end - 1) = 0;
        case 5
            L=orth(randn(d));
            L=round(L*10);
            C=L*L';
    end
    [e_cov(i,:),e_cor(i,:),e_icor(i,:),e_icov(i,:)]           = test_exp1(C,nvec);
    [e_lcov(i,:),e_lcor(i,:),e_licor(i,:),e_licov(i,:)]       = test_exp1low(C,nvec);
    [e_rcov(i,:),e_rcor(i,:),e_ricor(i,:),e_ricov(i,:)]       = test_exp1rank(C,nvec);
    [e_lrcov(i,:),e_lrcor(i,:),e_lricor(i,:),e_lricov(i,:)]   = test_exp1lowrank(C,nvec);
end

e_icov(e_icov>20)=NaN;

%%
colorkey = ['ro', 'go', 'bo', 'mo', 'r+', 'g+', 'b+', 'm+'];
for i=1:Nsims
    z = figure(i); clf
    hold on;
    semilogx(nvec, e_cov(i,:), 'ro');
    semilogx(nvec, e_cor(i,:), 'go');
    semilogx(nvec, e_icor(i,:), 'bo');
    semilogx(nvec, e_icov(i,:), 'mo');
    
    semilogx(nvec, e_lcov(i,:), 'rd');
    semilogx(nvec, e_lcor(i,:), 'gd');
    semilogx(nvec, e_licor(i,:), 'bd');
    semilogx(nvec, e_licov(i,:), 'md');

    semilogx(nvec, e_rcov(i,:), 'r+','markersize',12);
    semilogx(nvec, e_rcor(i,:), 'g+');
    semilogx(nvec, e_ricor(i,:), 'b+');
    semilogx(nvec, e_ricov(i,:), 'm+');
    
    semilogx(nvec, e_lrcov(i,:), 'r*','markersize',12);
    semilogx(nvec, e_lrcor(i,:), 'g*');
    semilogx(nvec, e_lricor(i,:), 'b*');
    semilogx(nvec, e_lricov(i,:), 'm*');

    legend( 'cov', 'cor', 'icor', 'icov',...
            'lcov', 'lcor', 'licor', 'licov',...
            'rcov', 'rcor', 'ricor', 'ricov',...
            'lrcov', 'lrcor', 'lricor', 'lricov');
    
    title(sprintf('Simulation %d', i));
    xlabel('number of time steps');
    ylabel('normalized error');
    
    saveas(z, sprintf('../../Figures/sim%d_d%d.png', i,d));
end

%%

% ColorSet = varycolor(4);
ColorSet=[0 0 1; 0 1 0; 1 0 1; 1 0 0];
set(0,'DefaultAxesColorOrder',ColorSet)

z = figure(Nsims+1);
subplot(221)
plot([e_cov(5,:); e_lcov(5,:); e_rcov(5,:); e_lrcov(5,:)]','linewidth',2)
axis('tight')
set(gca,'XTick',1:2:length(nvec),'XTickLabel',nvec(1:2:end))
title('cov')
ylabel('normalized error')
xlabel('# time steps')
legend('cov','lcov','rcov','lrcov')

subplot(222)
plot([e_cor(5,:); e_lcor(5,:); e_rcor(5,:); e_lrcor(5,:)]','linewidth',2)
set(gca,'XTick',1:2:length(nvec),'XTickLabel',nvec(1:2:end))
title('corr')

subplot(223)
plot([e_icov(5,:); e_licov(5,:); e_ricov(5,:); e_lricov(5,:)]','linewidth',2)
set(gca,'XTick',1:2:length(nvec),'XTickLabel',nvec(1:2:end))
title('inv cov')

subplot(224)
plot([e_icor(5,:); e_licor(5,:); e_ricor(5,:); e_lricor(5,:)]','linewidth',2)
set(gca,'XTick',1:2:length(nvec),'XTickLabel',nvec(1:2:end))
title('inv corr')

saveas(z, sprintf('../../Figures/summary_d%d.png', d));
