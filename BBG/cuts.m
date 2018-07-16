clear all
A = load('M:\Sakhalin\cut_dpr\ohot17_swath\d01m01g17S020800_swath\SigKu.txt');
th=load('M:\Sakhalin\cut_dpr\ohot17_swath\d01m01g17S020800_swath\IncKu.txt');
imagesc(A);
figure (3)
plot(A(25,:));



th0(:,1)=th(:,1);
for i=1:24
    th0(i,1)=-th(i,1);
end

i1=30;
i2=40;
%i3=155;

sA=size(A);
sA1=sA(1);
sA2=sA(2);

%B=zeros(sA1);
for jj=1:sA1
    B1(jj)=(A(jj,i1-1)+A(jj,i1)+A(jj,i1+1))/3;
end
%B=zeros(sA1);
for jj=1:sA1
    C(jj)=(A(jj,i2-1)+A(jj,i2)+A(jj,i2+1))/3;
end
% for jj=1:sA1
%     D(jj)=(A(jj,i3-1)+A(jj,i3)+A(jj,i3+1))/3;
% end

set(0,'DefaultAxesFontSize',16,'DefaultAxesFontName','Times New Roman');
   set(0,'DefaultTextFontSize',16,'DefaultTextFontName','Times New Roman'); 

hold on 
figure (2)
h1=plot(th0,B1,'r-.');
hold on
h2=plot(th0,C,'k--');
hold on
% h3=plot(th0,D,'g-');
% hold on

set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
 %set(h3,'LineWidth',2);
xlabel('Incidence angle, deg')
ylabel('RCS, dB')
h_legend=legend('1','2');
title('14-15.06.2015');
% hold on
% plot(th0,A(:,270),'r-.');
% hold on
% plot(th0,A(:,155),'k--');
% hold on
% plot(th0,A(:,190),'g-');