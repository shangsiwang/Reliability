% The function compute pairwise distance between graphs
% The input should be k*k*n which represents n graphs
% The output is n*n distance matrix
function [D]=graph_todist(graphs)

[k,~,n]=size(graphs);
graphs=reshape(graphs,k*k,n)';
D=squareform(pdist(graphs,'euclidean'));

end