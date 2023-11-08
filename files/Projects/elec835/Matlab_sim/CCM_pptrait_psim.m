clc;close all;
% 
% Ii = out.Ii;
% Vo = out.Vo;
% 
% Ii_sample = getdatasamples(Ii, (4500:5000));
% Vo_sample = getdatasamples(Vo, (4500:5000));
% 
% 
% % figure(1);
% % p1 = plot(Ii_sample, Vo_sample);
% % set(p1, 'color', 'b');
% % set(p1, 'LineWidth',1);
% hold on;


filename1 = 'chaos_buck_datafile_20.csv';
filename2 = 'chaos_buck_datafile_25.csv';
filename3 = 'chaos_buck_datafile_30.csv';
filename4 = 'chaos_buck_datafile_35.csv';

Vo1 = csvread(filename1,4500,0, [4500 0 5000 0]);
Ii1 = csvread(filename1,4500,1, [4500 1 5000 1]);

Vo2 = csvread(filename2,4500,0, [4500 0 5000 0]);
Ii2 = csvread(filename2,4500,1, [4500 1 5000 1]);

Vo3 = csvread(filename3,4500,0, [4500 0 5000 0]);
Ii3 = csvread(filename3,4500,1, [4500 1 5000 1]);

Vo4 = csvread(filename4,3000,0, [3000 0 5000 0]);
Ii4 = csvread(filename4,3000,1, [3000 1 5000 1]);

figure(1);
%subplot (1,4,1)
pp1 = plot(Vo1,Ii1);
set(pp1, 'color','#D95319');
set(pp1, 'LineWidth',2);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-1 operation');

figure(2);
%subplot (1,4,2)
pp2 = plot(Vo2,Ii2);
set(pp2, 'color','#0072BD');
set(pp2, 'LineWidth',2);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-2 operation');


figure(3);
%subplot (1,4,3)
pp3 = plot(Vo3,Ii3);
set(pp3, 'color', '#EDB120');
set(pp3, 'LineWidth',2);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-3 operation');

figure(4);
%subplot (1,4,4)
pp4 = plot(Vo4,Ii4);
set(pp4, 'color','#77AC30');
set(pp4, 'LineWidth',2);

title('Chaos Operation');
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
