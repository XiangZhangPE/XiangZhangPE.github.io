clc;close all;

Ii = (out.Ii);
Vo = (out.Vo);
% % % Ii_data = Ii.Data;
% % % Vo_data = Vo.Data;


Nplot = 40;
% % % T_simulantion = 0.1s, delt =1e-6s/step, 1e5 steps in total
% % % Ts =4e-4s, every cycle need 400 steps, so Ii_tn sample the data every 400 steps

Ii_sample = getdatasamples(Ii, (100000-Nplot*400:100000));
Vo_sample = getdatasamples(Vo, (100000-Nplot*400:100000));


% % % Vin = Simulink.Parameter(20:0.1:35)
% % % L = Simulink.Parameter(10e-3:1e-4:25e-3)
% % % C = Simulink.Parameter(20e-6:2e-7:80e-6)
% % % the total quantity of different Vin is 151
% % % the total quantity of different L is 151
% % % the total quantity of different C is 251


Ii_tn = zeros(Nplot,1);
Vo_tn = zeros(Nplot,1);
counter1 = 1;
counter2 = 1;

for Vin = 20:0.1:35
%for L = 10e-3:1e-4:25e-3
%for C = 20e-6:2e-7:80e-6

    for primer = 1:400:400*Nplot
    Ii_tn(counter1) = Ii_sample(primer,counter2);
    Vo_tn(counter1) = Vo_sample(primer,counter2);
    counter1 = counter1 + 1;
    end
    plot(Vin*ones(Nplot,1), Ii_tn, '.', 'markersize', 4);
    %plot(L*ones(Nplot,1), Ii_tn, '.', 'markersize', 4);
    %plot(C*ones(Nplot,1), Ii_tn, '.', 'markersize', 4);
    
    hold on;
    counter1 = 1;
    counter2 = counter2 +1;
end

title('Bifurcation diagram of Indutor Current - Input Voltage','FontAngle', 'italic');
xlabel('Input Voltage $V_{in}$','interpreter','latex'); 
ylabel('Inductor Current $I_i$','interpreter','latex');
set(gca, 'xlim', [20 35]);
hold off;

% title('Bifurcation diagram of Indutor Current - Inductor Value','FontAngle', 'italic');
% xlabel('Inductor Value $L_{buck}$','interpreter','latex'); 
% ylabel('Inductor Current $I_i$','interpreter','latex');
% set(gca, 'xlim', [10e-3 25e-3]);
% hold off;

% title('Bifurcation diagram of Indutor Current - Capacitor Value','FontAngle', 'italic');
% xlabel('Capacitor Value $C_{out}$','interpreter','latex'); 
% ylabel('Inductor Current $I_i$','interpreter','latex');
% set(gca, 'xlim', [20e-6 80e-6]);
% hold off;

