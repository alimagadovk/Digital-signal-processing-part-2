clc
clear
close all

% Синтезируем фильтр I-го типа с наилучшим равномерным приближением,
% удовлетворяющий требованиям к неравномерности АЧХ при наименьшем M
M = 24;
[a,~] = Filter_synth([0 0.4*pi],[0.5*pi pi],M);

% Находим ИХ синтезированного фильтра
h = zeros(1,2*M + 1);
h(M + 1) = a(1);
h(M:-1:1) = a(2:M + 1) ./ 2;
h(M + 2:2*M + 1) = h(M:-1:1);

w = [0.2*pi 0.35*pi];
N = 70;
h = [h zeros(1,N - length(h) + 1)];

% Обрабатываем синтезированным фильтром сигналы sin(wn) c частотами
% w(1) = 0.2*pi и w(2) = 0.35*pi, рисуем графики исходного и
% отфильтрованного сигналов
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
    title(strcat(['График исходного и фильтрованного сигналов, w = ',num2str(w(i))]));
    xlabel('n');
    ylabel('A');
    legend('x(n)', 'y(n)', 'shifted y(n)');
end