function [err_cov, err_corr, err_pcorr, err_invcov] = test_exp1(Cov,nvec)

d = length(Cov);
mu = zeros(d, 1);

Corr=diag(diag(Cov))^(-1/2)*Cov*diag(diag(Cov))^(-1/2);
Inv_Cov=pinv(Cov);
Pcorr=pcorrsing(Cov);


for i = 1:length(nvec)
   X = mvnrnd(mu, Cov, nvec(i));
   
   Covhat = cov(X);
   err_cov(i) = norm(Covhat - Cov, 'fro')/norm(Cov, 'fro');
   
   Corrhat = corrcoef(X);
   err_corr(i) = norm(Corrhat - Corr, 'fro')/norm(Corr, 'fro');
   
   Pcorrhat = pcorrsing(Corrhat);
   err_pcorr(i) = norm(Pcorrhat - Pcorr, 'fro')/norm(Pcorr, 'fro');
   
   Invcovhat = pinv(Covhat);
   err_invcov(i) = norm(Invcovhat - Inv_Cov, 'fro')/norm(Inv_Cov, 'fro');
   
end
end