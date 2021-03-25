function [a, K] = Filter_synth(bandwidth,suppr_band,M)
j = 0:M;
vw = pi.*(j + 0.5)./(M + 1);
n = find((vw > bandwidth(2)) & (vw < suppr_band(1)));
k = -1/(suppr_band(1) - bandwidth(2));
b = 1 - bandwidth(2)*k;
y = @(x)k.*x + b;
f = @(tr_proc)Funct(vw,tr_proc(1:length(n)),bandwidth,suppr_band,M);
opt = fminsearch(f,y(vw(n)));
tempK = K3(vw,opt,bandwidth,suppr_band);
k = 0:M;
A = cos(vw(k + 1)'.*k);
a = A\tempK';
K = @(w)0;
for k = 0:M
    K = @(w)K(w) + a(k + 1) .* cos(w.*k);
end
K = @(w)abs(exp(-1i .* w .* M) .* K(w));
end