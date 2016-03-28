function [err_cov, err_corr, err_pcorr, err_invcov] = test_exp1lowrank(Covi,nvec)

d = length(Covi);
mu = zeros(d, 1);

Corr=diag(diag(Covi))^(-1/2)*Covi*diag(diag(Covi))^(-1/2);
Inv_Cov=pinv(Covi);
Pcorr=pcorrsing(Covi);

%rank them
Corr = matrix_tiedrank(Corr);
Inv_Cov = matrix_tiedrank(Inv_Cov);
Pcorr = matrix_tiedrank(Pcorr);
Cov = matrix_tiedrank(Covi);

for i = 1:length(nvec)
   X = mvnrnd(mu, Covi, nvec(i));
   
   Covhat = cov(X);
   Covhat = lowrankapprox(Covhat,ceil(sqrt(nvec(i))));
   Covhat = matrix_tiedrank(Covhat);

   err_cov(i) = norm(Covhat - Cov, 'fro')/norm(Cov, 'fro');
   
   Corrhat = corrcoef(X);
   Corrhat = lowrankapprox(Corrhat,ceil(sqrt(nvec(i))));
   Corrhat = matrix_tiedrank(Corrhat);
   err_corr(i) = norm(Corrhat - Corr, 'fro')/norm(Corr, 'fro');
   
   Pcorrhat = pcorrsing(Corrhat);
   Pcorrhat = lowrankapprox(Pcorrhat,ceil(sqrt(nvec(i))));
   Pcorrhat = matrix_tiedrank(Pcorrhat);
   err_pcorr(i) = norm(Pcorrhat - Pcorr, 'fro')/norm(Pcorr, 'fro');
   
   Invcovhat = pinv(Covhat);
   Invcovhat = lowrankapprox(Invcovhat,ceil(sqrt(nvec(i))));
   Invcovhat = matrix_tiedrank(Invcovhat);
   err_invcov(i) = norm(Invcovhat - Inv_Cov, 'fro')/norm(Inv_Cov, 'fro');
   
end
end