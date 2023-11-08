function cobweb(fcn,x0,N,xmin,xmax)
% fcn is the name of the function, should be write in format of:
% logistic = @(x) r.*x.*(1-x);
% x0 is the starting value,
% N is the number of iterates, 
% xmin and xmax give the range of x-values to be plotted.
dx=(xmax-xmin)/1000;
x=xmin:dx:xmax;
y=feval(fcn,x);

% first plot the xn+1=f(xn) and y=x axis
% if the xn and xn+1 needed, we could add the two commented lines in plot.
plot(x,y,'b',...
    ...[xmin xmax],[0 0],'k',...
    ...[0 0],[min(y)-.1*abs(min(y)) max(y)],'k',...
    [xmin xmax],[xmin xmax],'g','LineWidth',1.5);
hold on

% Y=iterates(fcn,x0,N);
% could be write as a seperate function
Y=[x0];
x=x0;
for i=1:N
y=feval(fcn,x);
Y=[Y y];
x=y;
end
%YY(1)=Y(1);
for i=1:N
    XX(2*i-1)=Y(i);
    XX(2*i)=Y(i);
    YY(2*i)=Y(i+1);
    YY(2*i+1)=Y(i+1);
end
XX(2*N+1)=Y(N+1);
plot(XX,YY,'r',x0,0,'r*');
xlabel('x_{n}');
ylabel('x_{n+1}');
hold off;

% we could try following in command window

% DCM = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.1*(x-25)).^2./x;cobweb(DCM, 24, 100, 20, 30);ylim([20 30]);
% DCM = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.13*(x-25)).^2./x;cobweb(DCM, 24, 100, 20, 30);ylim([20 30]);
% DCM = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.165*(x-25)).^2./x;cobweb(DCM, 24, 100, 20, 30);ylim([20 30]);
% DCM = @(x) 0.8872*x +39.6*(33-x).*(0.4717-0.2*(x-25)).^2./x;cobweb(DCM, 24, 100, 20, 30);ylim([20 30]);
