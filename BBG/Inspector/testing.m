close all;
clear all;
load('matlab2.mat')
load('matlab.mat')
RowNumber=40;
sigma=25;
x=-100:100;
G=-x.*exp(-x.^2/(2*sigma^2));
Gh=@(x,s) -x.*exp(-x.^2/(2*s^2));
G1=-G;
plot(G)
hold on
grid on 

plot(data(RowNumber,:))
convd=conv(data(RowNumber,:),G,'same');
% convd=convd/max(convd)*max(data(RowNumber,:));
convdInv=conv(data(RowNumber,:),G1,'same');
% [Dmax,Imax]=max(convd);
% [Dmin,Imin]=min(convd);
[maxs,Imaxs]=findpeaks(convd,'MinPeakHeight',2);
[mins,Imins]=findpeaks(-convd,'MinPeakHeight',2);
% findpeaks(convd/max(convd)*max(data(RowNumber,:)));
% findpeaks(-convd,'MinPeakHeight',2);
% [Dmax,Imax]=max(maxs);
% Imax=Imaxs(Imax);
% [Dmin,Imin]=max(mins);
% Imin=Imins(Imin);
plot(convd/max(convd)*max(data(RowNumber,:)))

Gdx = diff([G 0]);
datadx = diff([data(RowNumber,:) mean(data(RowNumber,:))]);
% pTop=abs(convd).*abs(conv(datadx,G,'same'));
% pTop=pTop/max(pTop)*max(data(RowNumber,:));
% %pBottom=sqrt(integral(@(x)Gh(x,sigma),0,584));
SNR=abs(convd)./sqrt(integral(@(x)(Gh(x,sigma)).^2,0,584));
Loc=abs(conv(datadx,Gdx,'same'))./sqrt(integral(@(x)diff(([Gh(x,sigma) 0])).^2,0,584));
param=SNR.*Loc;
% plot(SNR/max(SNR)*max(data(RowNumber,:)));
% plot(Loc/max(Loc)*max(data(RowNumber,:)));
plot(param/max(param)*max(data(RowNumber,:)))
findpeaks(param/max(param)*max(data(RowNumber,:)),'MinPeakHeight',0.5*max(param/max(param)*max(data(RowNumber,:))))

% plot(Gdx)
% plot(convdInv)
% scatter([Imax Imin],[0 0],20,'filled')