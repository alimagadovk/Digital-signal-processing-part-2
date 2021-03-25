% task 1
clc
clear
close all

delta_p = 0.2929;

Ap = -20*log10(1 - delta_p);

delta_s = 0.01;

As = -20*log(delta_s);

Ap
As
%
close all

df = [290 250 200 150 100 50 40 30 20 10];

N1 = [3 5 8 11 17 34 42 55 82 163];
N2 = [3 4 6 7 10 14 16 18 22 31];
N3 = N2;
N4 = 3:12;

figure
hold on
grid on
plot(N1,df)
title('Фильтр Баттерворта')
xlabel('N')
ylabel('Ширина переходной полосы, Гц')

figure
hold on
grid on
plot(N2,df)
title('Фильтр Чебышева 1-го рода')
xlabel('N')
ylabel('Ширина переходной полосы, Гц')

figure
hold on
grid on
plot(N3,df)
title('Фильтр Чебышева 2-го рода')
xlabel('N')
ylabel('Ширина переходной полосы, Гц')

figure
hold on
grid on
plot(N4,df)
title('Эллиптический фильтр')
xlabel('N')
ylabel('Ширина переходной полосы, Гц')
%% task 3 page 279
clc
clear
close all

syms p

G = 100/(p^2 + 10*2^(1/2)*p + 100);

res = double(solve((p^2 + 10*2^(1/2)*p + 100)/100));


A = 1i*5*sqrt(2);
B = -A;

w = 200*pi;
fd = w / (2*pi);
T = 1/fd;

H = @(z) T.*(A./(1 - exp(res(1)*T)./z) + B./(1 - exp(res(2)*T)./z));

K = @(w)H(exp(1i.*w));

A = @(w)abs(K(w));

phi = @(w)angle(K(w));

vw = 0:0.001:pi;

figure
hold on
grid on
plot(vw,A(vw))
axis([0 pi 0 1])
title('АЧХ в линейном масштабе')
xlabel('v')
ylabel('A(v)')

figure
hold on
grid on
plot(vw,20.*log10(A(vw)))
title('АЧХ в логарифмическом масштабе')
xlabel('v')
ylabel('20*log10(A(v))')
%axis([0 pi min(20.*log10(A(vw))) max(20.*log10(A(vw)))])

figure
hold on
grid on
plot(vw,phi(vw))
axis([0 pi min(phi(vw)) max(phi(vw))])
title('ФЧХ')
xlabel('v')
ylabel('phi(v)')
%% task 3 page 286
clc
clear
close all

G = @(p)100./(p.^2 + (10*2^(1/2)).*p + 100);

w = 200*pi;
fd = w / (2*pi);
T = 1/fd;

gamma = 2/T;

H = @(z) G(gamma.*(1 - 1./z)./(1 + 1./z));

K = @(w)H(exp(1i.*w));

A = @(w)abs(K(w));

phi = @(w)angle(K(w));

vw = 0:0.001:pi;

figure
hold on
grid on
plot(vw,A(vw))
axis([0 pi 0 1])
title('АЧХ в линейном масштабе')
xlabel('v')
ylabel('A(v)')

figure
hold on
grid on
plot(vw,20.*log10(A(vw)))
title('АЧХ в логарифмическом масштабе')
xlabel('v')
ylabel('20*log10(A(v))')
%axis([0 pi min(20.*log10(A(vw))) max(20.*log10(A(vw)))])

figure
hold on
grid on
plot(vw,phi(vw))
axis([0 pi min(phi(vw)) max(phi(vw))])
title('ФЧХ')
xlabel('v')
ylabel('phi(v)')