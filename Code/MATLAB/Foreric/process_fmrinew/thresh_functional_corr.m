function [mnrall, D, mnrmax, tvalmax, tvalall] = thresh_functional_corr(wgraphs, id)
% 
% A function to compute and threshold the weighted graphs of functional data
% obtained from a graph building algorithm
% 
% Inputs:
%     wgraphs: the weighted graphs of the form nxnxk, where n is the number 
%         of rois and k is the number of subjects
%     fileval: the value of the files being considered
% Outputs:
%     mnrall: the full vector of mnr at all thresholds
%     D: the distance matrix at the optimal threshold
%     mnrmax: the maximum mnr
%     tvalmax: the mnr at the optimal tval
%

mnrmax = 0;
tvalall = linspace(min(min(min(wgraphs))), max(max(max(wgraphs))), 25);
for tloc=1:length(tvalall)
    corr = wgraphs;
    corr(corr<=tvalall(tloc)) = 0;
    dist = graph_todist(corr);
    mnrtest = 1 - compute_mnr(dist, id);
    if (mnrtest > mnrmax)
        mnrmax = mnrtest;
        D = dist;
        tvalmax = tvalall(tloc);
    end
    display(mnrtest);
    mnrall(tloc) = mnrtest;
end
end