clc
Ap2 = -6.11;
Ap = 20*log10(-10^(Ap2/20) + 2)

%%
clc
A = 73.83;
F = 0.09;

beta = 0.1102*(A - 8.7)

N = (A - 7.95)/(14.36*F)
%%
clc
Ap = 20*log10(1 + 0.0012)

As = -20*log10(0.001)
%%
clc
clear
close all
KD = @(w)i.*w;
%
M = 15;
K1 = @(w)0;
for i = 1:M
    if (i ~= M)
        h1(i) = cos(pi.*(i - M))./(i - M);
    else
        h1(i) = 0;
    end
end
for i = 1:M - 1
    i
    K1 = @(w)K1(w) + 2.*h1(M - i).*sin(w.*i);
end
K1 = @(w)1i.*exp(-1i.*w.*M).*K1(w);

%
for i = 1:M
    h2(i) = -sin(pi.*(i - (M - 1/2)))./(pi.*(i - (M - 1/2)).^2);
end

K2 = @(w)0;
for i = 1:M - 1
    M - i
    K2 = @(w)K2(w) + 2.*h2(M - i).*sin(w.*(i - 1/2));
end
K2 = @(w)1i.*exp(-1i.*w.*(M - 1/2)).*K2(w);


vw = -pi:0.001:pi;

figure
hold on
grid on
plot(vw,abs(KD(vw)))
plot(vw,abs(K2(vw)),'r')
xlabel('v')
ylabel('K(v)')

figure
hold on
grid on
plot(vw,abs(abs(KD(vw)) - abs(K2(vw))),'g')
xlabel('v')
ylabel('K(v)')