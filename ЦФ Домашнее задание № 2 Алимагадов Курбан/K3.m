function res = K3(w,trans_proc,bandwidth,suppr_band)
res = double((w >= bandwidth(1)) & (w <= bandwidth(2)));
n = find((w > bandwidth(2)) & (w < suppr_band(1)));
res(n) = trans_proc;
end