clc;close all;

Ii = (out.Ii);
Vo = (out.Vo);

%Ii_data = Ii.Data;
%Vo_data = Vo.Data;

Ii_sample = getdatasamples(Ii, (99000:100000));
Vo_sample = getdatasamples(Vo, (99000:100000));

Ii_data = Ii.Data;
Vo_data = Vo.Data;


% Matalab phase portrait
% remember to set simulation run time to 0.1s, step set at 1e-6s

p1 = plot(Vo_sample,Ii_sample,'--');
set(p1, 'color', 'b');
set(p1, 'LineWidth',3);
hold on;

% PSIM phase portrait
% remember to set simulation run time to 0.1s, step set at 1e-6s

filename_sample = 'chaos_buck_compare.csv';
Vo_mat = csvread(filename_sample,40000,1, [40000 1 50000 1]);
Ii_mat = csvread(filename_sample,40000,2, [40000 2 50000 2]);

pp1 = plot(Vo_mat,Ii_mat);
set(pp1, 'color','r');
set(pp1, 'LineWidth',2);
ylabel('Inducto Current Ii')
xlabel('Capacitor Voltage Vo')
title('Period-2 operation');
legend('Matlab','PSIM');



% %% poincare map
% %% remember to set simulation run time to 1s, step set at 1e-6s
% %% Vin is adjustable, remember to change the titile
% 
% Nplot = 2000;
% Ii_poincare = getdatasamples(Ii, (1000000-Nplot*400:1000000));
% Vo_poincare = getdatasamples(Vo, (1000000-Nplot*400:1000000));
% Ii_tn = zeros(Nplot,1);
% Vo_tn = zeros(Nplot,1);
% 
% counter1 = 1;
% counter2 = 1;
% 
% for primer = 1:400:400*Nplot
% Ii_tn(counter1) = Ii_poincare(primer,counter2);
% Vo_tn(counter1) = Vo_poincare(primer,counter2);
% counter1 = counter1 + 1;
% end
% figure(2)
% p2 = plot(Vo_tn,Ii_tn,'.','markersize', 8);
% set(p2, 'color','#77AC30');
% set(gca, 'xlim', [11.6 12.8]);
% set(gca, 'ylim', [0.4 0.8]);
% title('Poincare map when Vin=26V','FontAngle', 'italic');
% xlabel('Capacitor Voltage $V_{C}$','interpreter','latex'); 
% ylabel('Inductor Current $I_i$','interpreter','latex');