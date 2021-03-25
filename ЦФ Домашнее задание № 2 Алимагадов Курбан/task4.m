clc
clear
close all

% ����������� ������ I-�� ���� � ��������� ����������� ������������,
% ��������������� ����������� � ��������������� ��� ��� ���������� M
M = 24;
[a,~] = Filter_synth([0 0.4*pi],[0.5*pi pi],M);

% ������� �� ���������������� �������
h = zeros(1,2*M + 1);
h(M + 1) = a(1);
h(M:-1:1) = a(2:M + 1) ./ 2;
h(M + 2:2*M + 1) = h(M:-1:1);

w = [0.2*pi 0.35*pi];
N = 70;
h = [h zeros(1,N - length(h) + 1)];

% ������������ ��������������� �������� ������� sin(wn) c ���������
% w(1) = 0.2*pi � w(2) = 0.35*pi, ������ ������� ��������� �
% ���������������� ��������
for i = 1:2
    y = zeros(1,N+1);
    x = @(n)sin(w(i).*n);
    for n = 0:N
        for m = 0:n
            y(n + 1) = y(n + 1) + h(m + 1) .* x(n - m + 1);
        end
    end
    figure(i)
    hold on
    grid on
    plot(0:N,x(0:N),'r','linewidth',1.75)
    plot(0:N,y,'b','linewidth',1.75)
    plot(-M:N-M,y,'g-.', 'linewidth',1.5)
    axis([0 N -2 2])
    title(strcat(['������ ��������� � �������������� ��������, w = ',num2str(w(i))]));
    xlabel('n');
    ylabel('A');
    legend('x(n)', 'y(n)', 'shifted y(n)');
end