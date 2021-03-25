clc
clear
close all



% ����� ���������� � ��������������� ���
dp = 0.0275;
ds = 0.02;

% ����� ��� ���������� ������� KD
KD = @(w)double((w >= 0) & (w <= 0.45*pi));

M = 6;

% ����������� ������ �� ����������� �������
h = zeros(1,M + 1);
j = 0:M;
for k = 0:M
    h(M - k + 1) = sum(KD(pi.*(j + 0.5)./(M + 1)) .* cos(pi.*k.*(j + 0.5)./(M + 1))) / (M + 1);
end
K2 = @(w)0;
a(1) = h(M + 1);
a(2:M + 1) = 2 .* h(M:-1:1);
for k = 0:M
    K2 = @(w)K2(w) + a(k + 1) .* cos(w.*k);
end
K2 = @(w)exp(-1i .* w .* M) .* K2(w);

% ����������� ������ I-�� ���� � ��������� ����������� ������������ KD �
% M = 6
M = 6;
[~,y] = Filter_synth([0 0.4*pi],[0.5*pi pi],M);


% ������ ������� ��� � ������� � ��������������� ���������, ������ ������
% ���
v = 0:0.001:pi;
figure
hold on
grid on
plot(v,y(v),'r')
plot(v,abs(K2(v)),'g')
title(strcat(['������ � ��������� ����. ������������, M = ', int2str(M)]));

xlabel('w');
ylabel('|K|');
plot(v,KD(v));
line([0 0.4*pi], [1+dp 1+dp], 'Color', 'm')
line([0 0.4*pi], [1-dp 1-dp], 'Color', 'm')
line([0.5*pi pi], [ds ds], 'Color', 'm')
%line([0.5*pi pi], [-ds -ds], 'Color', 'm')
legend('��� K(w)','��� K2(w)','��� KD(w)','1 � delta_p; delta_s');

figure
hold on
grid on
plot(v,20*log10(y(v)),'r')
plot(v,20*log10(abs(K2(v))),'g')
title(strcat(['������ � ��������� ����. ������������, M = ', int2str(M)]));
xlabel('w');
ylabel('20log10(|K(w)|)');
plot(v,20*log10(double(KD(v))));
legend('20log10(|K(w)|)','20log10(|K2(w)|)');

% ��������� ������������ ���������� ��� ���������������� ������� �� ���
% ���������� ������� � ��������� ������������� �� ������ ��������
% ����������� � ��������������� ���
maxdev = max(abs(abs(y(v)) - KD(v)));
disp(strcat(['������������ ���������� ��� ���������������� ������� �� ��� ���������� ���������� ', num2str(maxdev)]))

w1 = find(v <= 0.4*pi);
w2 = find(v >= 0.5*pi);
if ((max(y(v(w1))) < 1 + dp) && (min(y(v(w1))) > 1 - dp) && (max(y(v(w2))) < ds))
    disp(strcat(['��������������� ������ ������������� ����������� � ��������������� ���, M = ', int2str(M)]))
else
    disp(strcat(['��������������� ������ �� ������������� ����������� � ��������������� ���, M = ', int2str(M)]))
end