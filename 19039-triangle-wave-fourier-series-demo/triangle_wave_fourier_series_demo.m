%===========================================================================
% Triangle Wave Fourier Series Demo  (triangle_wave_fourier_series_demo.m)
%==========================================================================
% The user can design various sawtooth wave by determining its period,
% time shift, dc value, etc. Then the program can automatically compute its
% Fourier series representation, and plot its amplitude spectrum and phase
% spectrum.
% 
% 
% 
% By Jing Tian Email: scuteejtian@hotmail.com
% 
% 

function triangle_wave_fourier_series_demo

clc; close all; clear all;

%parameter of input triangle wave
T0 = 10;    % period
A = 1;
dc = 1;     % dc level
ts = 0;     % time shift, positive: move right. negative: move left
M = 4;      % How many period are shown

Nf = M*T0;       %number of FS components, i.e., C(-Nf),...,C(-1),C(0),C(1),...C(Nf).
w0 = 2*pi/T0;   % frequency

%Figure 1, plot triangle wave
x = -M/2*T0:0.01:M/2*T0; 

syms t n y a1 a2 a3 a4 y1 y2
y = (sym('Heaviside(t+a1)')-sym('Heaviside(t-a2)')) * (-A/T0*2*t+A)...
    + (sym('Heaviside(t+a3)')-sym('Heaviside(t-a4)')) * (A/T0*2*t+A);
y = subs(y,a1,0);
y = subs(y,a2,T0/2);
y = subs(y,a3,T0/2);
y = subs(y,a4,0);
y=simple(y);
f = subs(y,t,x);

%plot triangle wave
figure1 = figure(1);
axes1 = axes('FontSize',14,'Parent',figure1);
box(axes1,'on');
hold(axes1,'all');
ylim(axes1,[dc-2*A dc+2*A]);
grid;
title(['Triangle wave']);
xlabel('t (seconds)'); ylabel('Amplitude');

xx = (x>=0).*(x-ts-fix((x-ts+T0/2)/T0).*T0) + (x<0).*(x-ts-fix((x-ts-T0/2)/T0).*T0);
yy = double(subs(y,t,xx))+dc;
plot(x,yy,'LineWidth',2,'color','b'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% closed-form of Cn (KEY EQUATION) %%%%%%%%%%
%Compute the closed-form of Cn; i.e.,
%C0 = 1/T0 * integral(f(t)) over [-T0/2, T0/2]
%Cn = 1/T0 * integral(f(t)*exp(-j*n*w0*t)) over [-T0/2, T0/2]

C0=int(y,t,-T0/2,T0/2)/T0;
Cs=int(y*exp(-j*w0*n*t)/T0,t,-T0/2,T0/2);
C0=simple(C0);
Cs=simple(Cs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% closed-form of Cn (KEY EQUATION) %%%%%%%%%%

%Figure 2, plot amplitude spectrum
figure2 = figure(2);
axes2 = axes('FontSize',14,'Parent',figure2);
box(axes2,'on');
hold(axes2,'all');
title(['Amplitude Spectrum']);
xlabel('n'); ylabel('Amplitude');

%Compute Cn and plot its amplitude
for k=-Nf:1:Nf
    if k==0
        c = abs(double(C0));        %C0
    else
        c = double(subs(Cs,n,k));   %Cn, substitue n=k into the above closed-form of Cn
    end

    stem(k, abs(c),'color','b','MarkerSize',5);                  %plot
    
end

%Figure 3, plot phase
figure3 = figure(3);
axes3 = axes('FontSize',14,'Parent',figure3);
box(axes3,'on');
hold(axes3,'all');
title(['Phase Spectrum']);
xlabel('n'); ylabel('Phase (degrees)');

%Compute Cn and plot its angle
for k=-Nf:1:Nf
    if k==0
        c = abs(double(C0));        %C0
    else
        c = double(subs(Cs,n,k));   %Cn, substitue n=k into the above closed-form of Cn
    end
    
    stem(k, sign(k)*angle(c)*180/pi,'color','b','MarkerSize',5);    %plot
    
end

