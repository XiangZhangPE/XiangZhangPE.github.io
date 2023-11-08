close all; clc;

% % 1. initial condition
% Vo = 10.61;
% Ii =0.43;
% d = 0.5;
Vo = 20;
Ii = 0;
d = 0.2;
h = 0.2;


% % 2. circuit parameters
xn = [Vo; Ii];
R = 12.5;
L = 208e-6;
C = 222e-6;
rc = 2e-3;
Vin = 33;
Vref = 25;
Ts = 1/3000;

% % 3. State Matrix

A1 = 1/(C*(R+rc))*[-1 R;-C*R/L -C*R*rc/L];
A2 = A1;
A3 = 1/(C*(R+rc))*[-1 0;0 0];

B1 = [0; 1/L];
B2 = [0;0];
B3 = B2;

Dc1 = sqrt(8*(L/(R*Ts))/(((2*Vin/Vref)-1)^2-1));

% % 4.iteration parameter
alpha = 1-Ts/(C*(R+rc)) +(Ts^2)/(2*(C^2)*((R+rc)^2));
beta = R*(Ts^2)/(2*L*C*(R+rc));
D = sqrt((1-alpha)*(Vref^2)/(beta*Vin*(Vin-Vref)));


% 4. state variables matrix related to dn
iteration_count =1;
K = 0.1; % feedback gain
Vc = 24;  % initail state
Vcc = zeros(400-1,1);

% for iteration =1:1:400
% 
%     Vc = alpha*Vc+beta*(h^2)*Vin*(Vin-Vc)/Vc;
%     Vcc(iteration) = Vc;
%     
% %     dc = d;
% %     dd = dc*(Vin-xn(1,1))./xn(1,1);
% %     de = 1-dc-dd;
% %     
% %     N1 = expm(A1.*dc.*Ts);
% %     N2 = expm(A2.*dd.*Ts);
% %     N3 = expm(A3.*de.*Ts);
% %     
% %     M1 = A1\(N1-[1 0;0 1])*B1;
% %     M2 = A2\(N2-[1 0;0 1])*B2;
% %     M3 = A3\(N3-[1 0;0 1])*B3;
% %     
% %     xn = N3*N2*N1*xn+ (N3*N2*M1+N3*M2+M3)*Vin;
%     
%     dn = D-K*(Vc-Vref);
%        
%     if(dn>=1)
%         h = 1;
%     elseif(dn<=0)
%         h = 0;
%     else
%         h = dn;
%     end
%     
%     % 7. Plot the State Variables in time seriers
%     plot( iteration_count, Vc, '.', 'markersize', 10); hold on;
%     %plot( iteration_count, xn(1,1), '.', 'markersize', 10); hold on;
%     %set(gca, 'ylim', [-10 30]);
%     
%     iteration_count = iteration_count+1;
% end



for K = 0.06:0.001:0.26
    Vc = 24;
   
    for Npre =1:1:100 
        Vc = alpha*Vc+beta*(h^2)*Vin*(Vin-Vc)/Vc;
    
        dn = D-K*(Vc-Vref);
       
        if(dn>=1)
            h = 1;
        elseif(dn<=0)
            h = 0;
        else
            h = dn;
        end
    end
    
    
    for Nplot =1:1:200

        Vc = alpha*Vc+beta*(h^2)*Vin*(Vin-Vc)/Vc;
      
        dn = D-K*(Vc-Vref);
       
        if(dn>=1)
            h = 1;
        elseif(dn<=0)
            h = 0;
        else
            h = dn;
        
        end
    
    % 7. Plot the State Variables in time seriers
    plot( K, Vc, '.', 'markersize', 5); hold on;
    iteration_count = iteration_count+1;
    end
    iteration_count =1; 
end

title('Bifurcation diagram of V_{out}-K','FontAngle', 'italic');
xlabel('Feedback Gain K','interpreter','latex'); 
ylabel('Output Voltage $V_{out}$','interpreter','latex');
set(gca, 'xlim', [0.06 0.26]);
hold off;





