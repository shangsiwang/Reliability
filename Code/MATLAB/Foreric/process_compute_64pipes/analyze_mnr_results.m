load('KKIfullresults.mat')
dataset='KKI';
numpipes=8;
numatlases=4;
numnuis=2;

close all;
legpip=['pipeline_abide_run__ANTS                     '; 'pipeline_abide_run__ANTS__freq-filter        '; ...
     'pipeline_abide_run__ANTS__freq-filter__scrub '; 'pipeline_abide_run__ANTS__scrub              '; ...
     'pipeline_abide_run__FNIRT                    '; 'pipeline_abide_run__FNIRT__freq-filter       '; ...
     'pipeline_abide_run__FNIRT__freq-filter__scrub'; 'pipeline_abide_run__FNIRT__scrub             '];
legpip=cellstr(legpip);

legmasks=['mask aal mask pad                  '; 'mask CC200                         ';...
        'mask ho mask pad                   '; 'mask MNI152 T1 3mm desikan adjusted'];
legmasks=cellstr(legmasks); 

legnuis=['No GSR'; ...
      '   GSR'];
legnuis=cellstr(legnuis);

%% Comparing ANTS to FNIRT
figpipe=figure(1);
hold on;
for i=1:numpipes
    
    plot(1:8, mnrval((8*(i-1)+(1:8))), 'LineWidth', 2);
    
end
ylabel('MNR thresholded by nbin');
title(strcat(dataset, ' ', ' Comparing overall pipeline strategies'));
legend(legpip);
set(figpipe, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figpipe, strcat(dataset, 'comppipe.png'), 'png');

%% Comparing Atlases
figat=figure(2);
hold on
atlas=zeros(4,16);
at1num=1;at2num=1;at3num=1;at4num=1;
for i=1:numpipes*numatlases*numnuis
    if mod(i,4)==0
        atlas(1,at1num) = mnrval(i);
        at1num = at1num+1;
    elseif mod(i,4)==1
        atlas(2,at2num) = mnrval(i);
        at2num = at2num+1;
    elseif mod(i,4) == 2
        atlas(3,at3num) = mnrval(i);
        at3num=at3num+1;
    elseif mod(i,4) == 3
        atlas(4,at4num) = mnrval(i);
        at4num=at4num+1;
    end
end
for i=1:numatlases
    plot(1:numpipes*numnuis, atlas(i,:), 'LineWidth', 2);
end
ylabel('MNR thresholded by nbin');
title(strcat(dataset, ' ', ' Comparing atlases'));
legend(legmasks);
set(figat, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figat, strcat(dataset, 'compat.png'), 'png');

%%Comparing Nuis Strategies
fignuis=figure(3);
hold on
nuis=zeros(numnuis, numpipes*numatlases);
num1nuis=1;num2nuis=1;
for i = 1:numpipes*numatlases*numnuis
    if mod(floor((i-1)/4),2)==1
        nuis(1,num1nuis) = mnrval(i);
        num1nuis = num1nuis+1;
    else
        nuis(2,num2nuis) = mnrval(i);
        num2nuis=num2nuis+1;
    end
end
for i=1:numnuis
    plot(1:numpipes*numatlases, nuis(i,:), 'LineWidth', 2);
end
ylabel('MNR using nbin*');
title(strcat(dataset, ' ', ' Comparing Nuisance stragegies'));
legend('No GSR', 'GSR');
set(fignuis, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(fignuis, strcat(dataset, 'compnuis.png'), 'png');

%% ANTs vs FNIRT

figprep=figure(4);
hold on
prep=zeros(numnuis*numatlases*4, numnuis*numatlases*4);
num1prep=1;num2prep=1;
for i = 1:numpipes*numatlases*numnuis
    if floor((i-1)/32)==0
        prep(1,num1prep) = mnrval(i);
        num1prep = num1prep+1;
    else
        prep(2,num2prep) = mnrval(i);
        num2prep=num2prep+1;
    end
end
for i=1:2
    plot(1:numatlases*numnuis*4, prep(i,:), 'LineWidth', 2);
end
ylabel('MNR using nbin*');
title(strcat(dataset, ' Comparing ANTs vs FNIRT'));
legend('ANTs', 'FNIRT');
set(figprep, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figprep, strcat(dataset, 'compprep.png'), 'png');

%%freq-filter vs no freq-filter
figfreq=figure(5);
hold on
freq=zeros(numnuis*numatlases*4, numnuis*numatlases*4);
num1freq=1;num2freq=1;
for i = 1:numpipes*numatlases*numnuis
    pipeval=strname{i,:}(4);
    if mod(pipeval, 4) == 2 || mod(pipeval,4) == 3        
        freq(1,num1freq) = mnrval(i);
        num1freq = num1freq+1;
    else
        freq(2,num2freq) = mnrval(i);
        num2freq=num2freq+1;
    end
end
for i=1:2
    plot(1:numatlases*numnuis*4, freq(i,:), 'LineWidth', 2);
end
ylabel('MNR using nbin*');
title(strcat(dataset, ' Comparing impact of freq-filter'));
legend('freq-filter', 'no freq-filter');
set(figfreq, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figfreq, strcat(dataset, 'compfreq.png'), 'png');

%% scrubbing vs no scrubbing
figscrub=figure(6);
hold on
scrub=zeros(numnuis*numatlases*4, numnuis*numatlases*4);
num1scrub=1;num2scrub=1;
for i = 1:numpipes*numatlases*numnuis
    pipeval=strname{i,:}(4);
    if mod(pipeval, 4) == 0 || mod(pipeval,4) == 3        
        scrub(1,num1scrub) = mnrval(i);
        num1scrub = num1scrub+1;
    else
        scrub(2,num2scrub) = mnrval(i);
        num2scrub=num2scrub+1;
    end
end
for i=1:2
    plot(1:numatlases*numnuis*4, scrub(i,:), 'LineWidth', 2);
end
ylabel('MNR using nbin*');
title(strcat(dataset, ' Comparing impact of scrubbing'));
legend('scrubbing', 'no scrubbing');
set(figfreq, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figfreq, strcat(dataset, 'compscrub.png'), 'png');