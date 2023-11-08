close all; clc;

% 1. initial condition
Vo = 10.61;
Ii =0.43;
dn = 0.5;
% Vo = 0;
% Ii = 0;
% dn = 0.5;


% 2. circuit parameters
xn = [Vo; Ii];
R = 22;
L = 20e-3;
C =  47e-6;

VU = 8.2;
VL = 3.8;
Vref = 11.3;

Vin = 22;
Ts = 1/2500;

% 3. state variables matrix
% digits(7);
Aon = [-1/(R*C) 1/C; -1/L 0];
Aoff = Aon;
Bon = [0;1/L];
Boff = [0;0];

% % @ Important Notice
% Aoninv = vpa(Aon\[1 0; 0 1])= inv(Aon) = Aon^-1;
% Aoffinv = vpa(Aoff\[1 0; 0 1]);

% % @ Important Notice
% % c = Aon .*Bon
% % d = Aon*Bon
% % note that .* is corresponding element plot; * is matrix calculation


 % 4. state variables matrix related to dn
iteration_count =1;
iteration_count1 =1;

K = 8.2;

for Vin = 20:1:20
    
    xn = [10; 0.43];
    
for iteration =1:1:200
    
    % d = Vref/Vin;
     d = 1-dn;

    % % @ Important Notice
    % % Non1 = exp(Aon*d*Ts); 
    % % Non2 = expm(Aon*d*Ts);
    % % exp() has very big difference to expm()    
        
    Non = expm(Aon*d*Ts);
    Noff = expm(Aoff*dn*Ts);
    
    Mon = Aon\(Non-[1 0;0 1])*Bon;
    Moff = Aoff\(Noff-[1 0;0 1])*Boff;
    
    An = Non*Noff;
    Bn = Non*Moff+Mon;
    
    % 5. Calculate the dn
    syms dn2
    
    Noff_transit = expm(Aoff*dn2*Ts);
    Moff_transit = Aoff\(Noff_transit-[1 0;0 1])*Boff;
    Non_transit = expm(Aon*dn2*Ts);
    Mon_transit = Aoff\(Non_transit-[1 0;0 1])*Bon;
    
    % Sdn = [K,0]*(Non_transit*xn+Mon_transit*Vin)-K*Vref-VL-(VU-VL)*dn2*Ts;
     Sdn = [K,0]*(Noff_transit*xn+Moff_transit*Vin)-K*Vref-VL-(VU-VL)*dn2*Ts;
    dn2 = vpasolve(Sdn == 0, dn2);
    
    if(dn2>=1)
        dn = 1;
    elseif(dn2<=0)
        dn = 0;
    else
    dn = double(dn2*10000/10000);
    end
    

    % 6. Update the state variables  
    xn = An*xn+Bn*Vin;
    xm = Noff*xn+Moff*Vin;
    
        dfdxn = Non*Noff;
        dfddn = (-Aon*Ts*Non*Moff+Non*Aoff*Ts*Noff)*xn + (-Aon*Ts*Non*Moff+Non*Noff*Boff*Ts-Non*Bon*Ts)*Vin;
        dsddn = [K 0]*Noff*(Aoff*xn+Boff*Vin)*Ts -(VU-VL)*Ts;
        dsdxn = [K 0]*Noff;

        Jacobian_Buck = dfdxn - dfddn*((dsddn)\dsdxn);

        eigens = eig(Jacobian_Buck);
        plot(real(eigens), imag(eigens), '.', 'markersize', 10); hold on;
    
    % 7. Plot the State Variables in time seriers
    figure(iteration_count1)
    plot( iteration_count, xn(1,1), '.', 'markersize', 10); hold on;
    plot( iteration_count, dn, 'o', 'markersize', 5)
    set(gca, 'ylim', [-10 30]);
    
    iteration_count = iteration_count+1;
end
iteration_count = 1;
iteration_count1 =iteration_count1+1;
end

% Npre = 50;
% Nplot = 50;
% 
% for Vin = 20:0.01:35
%     
%         xn = [Vo; Ii];  
%         
%     for n = 1:Npre
%         
%         d = 1-dn;
%         Non = expm(Aon*d*Ts);
%         Noff = expm(Aoff*dn*Ts);
%     
%         Mon = Aon\(Non-[1 0;0 1])*Bon;
%         Moff = Aoff\(Noff-[1 0;0 1])*Boff;
%     
%         An = Non*Noff;
%         Bn = Non*Moff+Mon;
% 
%         xn = An*xn +Bn*Vin; 
%         dn = 1-xn(1,1)/Vin;
%     end
%     
%     for n = 1:Nplot
%         
%         d = 1-dn;
%         Non = expm(Aon*d*Ts);
%         Noff = expm(Aoff*dn*Ts);
%     
%         Mon = Aon\(Non-[1 0;0 1])*Bon;
%         Moff = Aoff\(Noff-[1 0;0 1])*Boff;
%     
%         An = Non*Noff;
%         Bn = Non*Moff+Mon;
%         
%         xn = An*xn +Bn*Vin;
%         dn = 1-xn(1,1)/Vin;
%     
%         dfdxn = Non*Noff;
%         dfddn = (-Aon*Ts*Non*Moff+Non*Aoff*Ts*Noff)*xn + (-Aon*Ts*Non*Moff+Non*Noff*Boff*Ts-Non*Bon*Ts)*Vin;
%         dsddn = [K 0]*Noff*(Aoff*xn+Boff*Vin)*Ts -(VU-VL)*Ts;
%         dsdxn = [K 0]*Noff;
% 
%         Jacobian_Buck = dfdxn - dfddn*((dsddn)\dsdxn);
% 
%         eigens = eig(Jacobian_Buck);
%         plot(real(eigens), imag(eigens), '.', 'markersize', 10); hold on;
%     
%      end
%    
% end




