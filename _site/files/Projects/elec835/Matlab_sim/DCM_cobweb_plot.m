% we could try following in command window
figure(1)
DCM1 = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.1*(x-25)).^2./x;
cobweb(DCM1, 24, 100, 20, 30);ylim([20 30]);
figure(2)
DCM2 = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.13*(x-25)).^2./x;
cobweb(DCM2, 24, 100, 20, 30);ylim([20 30]);
figure(3)
DCM3 = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.165*(x-25)).^2./x;
cobweb(DCM3, 24, 100, 20, 30);ylim([20 30]);
figure(4)
DCM4 = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.2*(x-25)).^2./x;
cobweb(DCM4, 24, 100, 20, 30);ylim([20 30]);
