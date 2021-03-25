function res = KL(vw,bandwidth,suppr_band)
res = double((vw >= bandwidth(1)) & (vw <= bandwidth(2)));
n = find((vw > bandwidth(2)) & (vw < suppr_band(1)));
k = -1/(suppr_band(1) - bandwidth(2));
b = 1 - bandwidth(2)*k;
y = @(x)k.*x + b;
res(n) = y(vw(n));
end