clear all;
close all;
load('KKIfullresults2.mat');

dataset='KKI';
numpipes=64;
%%Comparing ANTs to FNIRT
%antslist and fnirtlist are the placeholders; strings are held in strlist
[strproc,antslist,fnirtlist]=compare_pipe(newname, 2, 'ANTs', mnrval);
pants=signrank(antslist, fnirtlist);
%%Comparing ff to nff
[strff, nfflist, fflist] = compare_pipe(newname, 3,'nff', mnrval);
pff=signrank(fflist, nfflist);
%%Comparing  to ns
[strs, nslist, slist] = compare_pipe(newname, 4,'ns', mnrval);
ps=signrank(slist,nslist);
%%Comparing GSR to no GSR
[strg, nglist, glist]=compare_pipe(newname, 5, 'ng', mnrval);
pgsr=signrank(glist, nglist);
%%Comparing Atlases
[strat,aallist,cc200list,holist,desiklist,str2,str3,str4]=compare_atlas(newname,6,mnrval);

%%generate figures
figprep=figure(1);
plot(1:32, antslist, 'LineWidth',2);
hold on
plot(1:32, fnirtlist, 'LineWidth',2);
title(strcat(dataset, sprintf(' Comparing Ants vs FNIRT; p=%f', pants)));
legend('ANTs', 'FNIRT');
xlim([1 32]);
set(gca,'xtick',1:32);
set(gca, 'XtickLabel', strproc);
set(gca, 'XtickLabelRotation', 90);
set(figprep, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figprep, strcat(dataset, 'compprep.png'), 'png');

figff=figure(2);
plot(1:32, fflist, 'LineWidth',2);
hold on
plot(1:32, nfflist, 'LineWidth',2);
title(strcat(dataset, sprintf(' Comparing ff vs nff; p=%f', pff)));
legend('freq-filter', 'no freq-filter');
xlim([1 32]);
set(gca,'xtick',1:32);
set(gca, 'XtickLabel', strff);
set(gca, 'XtickLabelRotation', 90);
set(figff, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figff, strcat(dataset, 'compff.png'), 'png');

figs=figure(3);
plot(1:32, slist, 'LineWidth',2);
hold on
plot(1:32, nslist, 'LineWidth',2);
title(strcat(dataset, sprintf(' Comparing scrub vs no scrub; p=%f', ps)));
legend('scrub', 'no scrub');
xlim([1 32]);
set(gca,'xtick',1:32);
set(gca, 'XtickLabel', strs);
set(gca, 'XtickLabelRotation', 90);
set(figs, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figs, strcat(dataset, 'comps.png'), 'png');

figg=figure(4);
plot(1:32, glist, 'LineWidth',2);
hold on
plot(1:32, nglist, 'LineWidth',2);
title(strcat(dataset, sprintf(' Comparing GSR vs no GSR; p=%f', pff)));
legend('GSR', 'no GSR');
xlim([1 32]);
set(gca,'xtick',1:32);
set(gca, 'XtickLabel', strg);
set(gca, 'XtickLabelRotation', 90);
set(figg, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figg, strcat(dataset, 'compg.png'), 'png');

figat=figure(5);
plot(1:16, aallist, 'LineWidth',2);
hold on
plot(1:16, cc200list, 'LineWidth',2);
plot(1:16, holist, 'LineWidth',2);
plot(1:16, desiklist, 'LineWidth',2);
title(strcat(dataset, sprintf(' Comparing Atlases')));
legend('aal', 'cc200', 'ho','desik');
xlim([1 8]);
set(gca,'xtick',1:8);
set(gca, 'XtickLabel', strat);
set(gca, 'XtickLabelRotation', 90);
set(figat, 'PaperUnits', 'inches', 'PaperPosition', [0 0 19 10]);
saveas(figat, strcat(dataset, 'comat.png'), 'png');