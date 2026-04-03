clear
close all
U1 = 5;
U2 = 9;
U3 = 13;
U4 = 20;
T1 = 0.02;
T2 = 0.04;
Fd = 5000;
counts = (0:1/Fd:T2);
u1 = counts(1:100)*(U2-U1)/T1+U1;
u2 = (U3+U2)/2;
b3 = (U4-(U4-U3)/(T2-T1)*counts(200));
u3 = counts(101:200)*(U4-U3)/(T2-T1)+b3;
u = [u1,u2,u3];
figure     %перед каждым графиком для вывода в отдельном окне figure
plot(counts(1:201),u);
figure
stem(counts(1:201),u);

%строим спектр дискретного сигнала
%вектор-столбец номеров отсчетов
k = (0:200).';
w = (-pi:pi/350:pi);
kw = k*w;
kw = kw*1j;
kw = exp(kw);
d_s = counts*kw;

%Графики амплитудного и фазового спектра от ЛИНЕЙНОЙ частоты
figure
subplot(1,2,1)
stem(Fd*w/(2*pi),abs(d_s));     
subplot(1,2,2)
stem(Fd*w/(2*pi),angle(d_s));   

%Восстановление аналогового сигнала
rec_t = (-5/Fd:1/(1000*Fd):0.04+5/Fd);
rec_signal = zeros(1, length(rec_t));
Td = 1/Fd;
for p = 1:201
    rec_signal = rec_signal + u(p)*sin(pi*(rec_t-p*Td)/Td)./(pi*(rec_t-p*Td)/Td);
end
figure
hold on
plot(rec_t, rec_signal)
plot(counts(1:201),u)

