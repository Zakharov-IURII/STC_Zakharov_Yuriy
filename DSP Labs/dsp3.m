clear
close all
U1 = 5;
U2 = 9;
U3 = 13;
U4 = 20;
T1 = 0.02;
T2 = 0.04;
Fd = 5000;
%график дискретизированного сигнала
%вектор отсчетов
counts = (0:1/Fd:T2);
u1 = counts(1:100)*(U2-U1)/T1+U1;
u2 = (U3+U2)/2;
b3 = (U4-(U4-U3)/(T2-T1)*counts(200));
u3 = counts(101:200)*(U4-U3)/(T2-T1)+b3;
x = [u1,u2,u3];
figure
stem(x);
%Расчет ДПФ с помощью функции fft;
y = fft(x);
%fftshift перестраивает ДПФ путем сдвига первого эл-та в центр (для
%наглядности и симметрии от-но нулевой частоты)
y_1 = fftshift(y); 
figure
subplot(2,1,1);
stem(abs(y_1));
subplot(2,1,2);
stem(angle(y_1));
%Оценка ширины спектра
E0 = sum(x.^2);
N0_max = 0;
y_2 = y;
y_2(N0_max+2:length(y)-N0_max) = 0;
x_rec = ifft(y_2);
E_1 = sum(x_rec.^2);
while(E_1 < 0.999*E0)
    N0_max = N0_max + 1;
    y_2 = y;
    y_2(N0_max+2:length(y)-N0_max) = 0;
    x_rec = ifft(y_2);
    E_1 = sum(x_rec.^2);
end
disp(N0_max);
figure
subplot(2,1,1);
stem(abs(y_2));
subplot(2,1,2);
stem(angle(y_2));
figure
hold on
stem(x);
stem(x_rec);

%Добавление нулей
x_zeros = [x,zeros(1,length(x))];
y_zeros = fft(x_zeros);
figure
subplot(2, 1, 1);
stem(abs(y_zeros));
subplot(2,1,2);
stem(angle(y_zeros));

%Измерение скорости расчетов при вычислении ДПФ непосредственно по т.
%формуле
%Матрица преоб-я для ДПФ:
% t = 6;
% while(t<14)
%     N = 2^t;
%     D = dftmtx(N);
%     if N < length(x)
%         x_zeros1 = x(1:N);
%     else
%         x_zeros1 = [x, zeros(1, N - length(x))];
%     end
%     y = zeros(1, N);
%     tic
%     for k = 1:460  %подобрано, чтобы для N = 1024 время составило ~1 с (далее делим на k)
%         y = x_zeros1 * D;
%     end
%     toc
%    t = t + 1;
% end

% Измерение скорости расчетов при вычислении быстрого ПФ
t = 6;
while(t<14)
    N = 2^t;
    y = zeros(1, N);
    tic
    for k = 1:95000  %подобрано, чтобы для N = 1024 время составило ~1 с (далее делим на k)
        y = fft(x,N);
    end
    toc
   t = t + 1;
end





