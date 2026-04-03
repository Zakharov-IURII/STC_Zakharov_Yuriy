close all
%квантуем сигнал по уровням q = 1/256
q = 1/256;
k = (0:10^5-1);
x = 5*cos(2*pi/5000*30*k+pi/3);
x_q = round(x/q)*q;
q_noise = x_q - x;
%графики
figure
subplot(2,2,1);
plot(q_noise(1:200));
subplot(2,2,2);
histogram(q_noise, 100);
subplot(2,2,3);
[Rx, dx] = xcorr(q_noise, 100, 'unbiased');
plot(dx, Rx);
subplot(2,2,4);
pwelch(q_noise, 256);
sgtitle('q = 1/256');

%для шага 1/16
q = 1/16;
k = (0:10^5-1);
x = 5*cos(2*pi/5000*30*k+pi/3);
x_q = round(x/q)*q;
q_noise = x_q - x;
%графики
figure
subplot(2,2,1);
plot(q_noise(1:200));
subplot(2,2,2);
histogram(q_noise, 100);
subplot(2,2,3);
[Rx, dx] = xcorr(q_noise, 100, 'unbiased');
plot(dx, Rx);
subplot(2,2,4);
pwelch(q_noise, 256);
sgtitle('q = 1/16');

%для шага 1
q = 1;
k = (0:10^5-1);
x = 5*cos(2*pi/5000*30*k+pi/3);
x_q = round(x/q)*q;
q_noise = x_q - x;
%графики
figure
subplot(2,2,1);
plot(q_noise(1:200));
subplot(2,2,2);
histogram(q_noise, 100);
subplot(2,2,3);
[Rx, dx] = xcorr(q_noise, 100, 'unbiased');
plot(dx, Rx);
subplot(2,2,4);
pwelch(q_noise, 256);
sgtitle('q = 1');

%дискретный белый гауссов шум, шаг 1/256
q = 1/256;
sn = randn(1, 10^5);
sn = sn/max(abs(sn)); %нормируем к его максимальному значению
sn_q = round(sn/q)*q;
q_noise = sn_q - sn;
%графики
figure
subplot(2,2,1);
plot(q_noise(1:200));
subplot(2,2,2);
histogram(q_noise, 100);
subplot(2,2,3);
[Rx, dx] = xcorr(q_noise, 100, 'unbiased');
plot(dx, Rx);
subplot(2,2,4);
pwelch(q_noise, 256);
sgtitle('Белый гауссов шум, q = 1/256');

%речевой сигнал из файла mtlb.mat
mtlb = mtlb/max(abs(mtlb));
mtlb_q = round(mtlb/q)*q;
q_noise = mtlb_q - mtlb;
%графики
figure
subplot(2,2,1);
plot(q_noise(1:200));
subplot(2,2,2);
histogram(q_noise, 100);
subplot(2,2,3);
[Rx, dx] = xcorr(q_noise, 100, 'unbiased');
plot(dx, Rx);
subplot(2,2,4);
pwelch(q_noise, 256);
sgtitle('Речевой сигнал, q = 1/256');


