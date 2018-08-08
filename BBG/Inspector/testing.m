RowNumber=25;
sigma=50;
kappa=sigma/2;
x=-20:20;
G=-x./kappa^2.*exp(-x.^2/(2*sigma^2));
G1=-G;
plot(G)
hold on
grid on 

plot(data(RowNumber,:))
convd=conv(data(RowNumber,:),G,'same');
convdInv=conv(data(RowNumber,:),G1,'same');
% [Dmax,Imax]=max(convd);
% [Dmin,Imin]=min(convd);
[maxs,Imaxs]=findpeaks(convd,'MinPeakHeight',2);
[mins,Imins]=findpeaks(-convd,'MinPeakHeight',2);
findpeaks(convd,'MinPeakHeight',2);
findpeaks(-convd,'MinPeakHeight',2);
% [Dmax,Imax]=max(maxs);
% Imax=Imaxs(Imax);
% [Dmin,Imin]=max(mins);
% Imin=Imins(Imin);
plot(convd)
% plot(convdInv)
% scatter([Imax Imin],[0 0],20,'filled')