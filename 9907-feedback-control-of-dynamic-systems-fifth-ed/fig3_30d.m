%  Figure 3.30d      Feedback Control of Dynamic Systems, 5e
%                        Franklin, Powell, Emami
%

clf;
num=1;
a=1;

zeta =1;
den2=[1/(zeta*a) 1];
den1=[1 2*zeta 1];
den=conv(den1,den2);
t=0:.1:8;
y1=step(num,den,t);

zeta =.7;
den2=[1/(zeta*a) 1];
den1=[1 2*zeta 1];
den=conv(den1,den2);
y2=step(num,den,t);

zeta =.5;
den2=[1/(zeta*a) 1];
den1=[1 2*zeta 1];
den=conv(den1,den2);
y3=step(num,den,t);

axis([1 6 .1 .9])
plot(t,y1,'-',t,y2,'--',t,y3,'-.'),grid
title('Fig. 3.30d Step response with extra pole, \alpha= 1')
xlabel('\omega_n t')
ylabel('y(t)')
