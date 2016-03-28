function A = lowrankapprox(Ai,rank)

[u,d,v]=svd(Ai);
dd=diag(d);
k=min(nnz(dd),rank);
dd(k+1:end)=0;
d=diag(dd);
A=u*d*v';
