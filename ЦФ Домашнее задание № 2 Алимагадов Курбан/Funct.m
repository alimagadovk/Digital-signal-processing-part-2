function res = Funct(vw,trans_proc,bandwidth,suppr_band,M)
tempK = K3(vw,trans_proc,bandwidth,suppr_band);
k = 0:M;
A = cos(vw(k + 1)'.*k);
a = A\tempK';
F = @(w)0;
for k = 0:M
    F = @(w)F(w) + a(k + 1) .* cos(w.*k);
end
K = @(w)abs(F(w)) - KL(w,bandwidth,suppr_band);
opt = fminbnd(@(w)-abs(K(w)),0,pi);
res = abs(K(opt));
end