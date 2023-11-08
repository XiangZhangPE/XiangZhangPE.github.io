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


filename_dcm1 = 'chaos_buck_datafile_k0.1_DCM.csv';
filename_dcm2 = 'chaos_buck_datafile_k0.13_DCM.csv';
filename_dcm3 = 'chaos_buck_datafile_k0.165_DCM.csv';
filename_dcm4 = 'chaos_buck_datafile_k0.2_DCM.csv';


Vo1 = csvread(filename_dcm1,40000,1, [40000 1 50000 1]);
Ii1 = csvread(filename_dcm1,40000,2, [40000 2 50000 2]);

Vo2 = csvread(filename_dcm2,40000,1, [40000 1 50000 1]);
Ii2 = csvread(filename_dcm2,40000,2, [40000 2 50000 2]);

Vo3 = csvread(filename_dcm3,40000,1, [40000 1 50000 1]);
Ii3 = csvread(filename_dcm3,40000,2, [40000 2 50000 2]);

Vo4 = csvread(filename_dcm4,40000,1, [40000 1 50000 1]);
Ii4 = csvread(filename_dcm4,40000,2, [40000 2 50000 2]);

figure(1);
%subplot (1,4,1)
pp1 = plot(Vo1,Ii1);
set(pp1, 'color','#D95319');
set(pp1, 'LineWidth',1);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-1 operation K=0.1');

figure(2);
%subplot (1,4,2)
pp2 = plot(Vo2,Ii2);
set(pp2, 'color','#0072BD');
set(pp2, 'LineWidth',1);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-2 operation K=0.136');

figure(3);
%subplot (1,4,3)
pp3 = plot(Vo3,Ii3);
set(pp3, 'color', '#EDB120');
set(pp3, 'LineWidth',1);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-4 operation K=0.16');

figure(4);
%subplot (1,4,4)
pp4 = plot(Vo4,Ii4);
set(pp4, 'color','#77AC30');
set(pp4, 'LineWidth',2);

title('Chaos Operation K=0.2');
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
