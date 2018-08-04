clear all
thNS=load('IncKu.txt');
LaKu=load('LaKu.txt');
LoKu=load('LoKu.txt');
sizeT=size(thNS);
SigNS=zeros(sizeT);
Nbreaks=floor(20*rand(1));
rndPos=rand(1,Nbreaks);
breakPos=sort(floor(rndPos.*sizeT(2)));
breakPos=[1,breakPos,sizeT(2)];

Ai=153.12; Bi=4.25; Ci=-13.67; %ice param
Aw=0.72; Bw=0.03; %water param
f=3;
for j=1:Nbreaks+1    
    if rand>=0.5
        for i=breakPos(j):breakPos(j+1)
            SigNS(:,i)=Ai*abs(1./(abs(thNS(:,i))+Bi))+Ci;%ice
        end
    else
        for i=breakPos(j):breakPos(j+1)
            SigNS(:,i)=10*log10(Aw^2/Bw*secd(thNS(:,i)).^4.*exp(-(tand(thNS(:,i))).^2/Bw)); %water
        end
    end
end
for k=1:sizeT(1)
    a=SigNS(k,:);
    a=a';
    a=circshift(a,[floor(sin(k)*f)+k,0]);
    a=a';
    SigNS(k,:)=a;
end
fidK = fopen('areaKu.txt','wt');
for ii=1:sizeT(1)
    for jj=1:sizeT(2)
        
        fprintf(fidK,'%e   %e   %e   %e   \r\n',LaKu(ii,jj),LoKu(ii,jj),thNS(ii,jj),SigNS(ii,jj));
        
    end
end
    
fidSig = fopen('SigKu.txt','wt');
dlmwrite('SigKu.txt',SigNS,'delimiter','\t');
imagesc(SigNS)
print('sine','-dpng')
%F=param(1)*abs(1./(abs(xdata)+param(2)))+param(3); %ice

%F=param(1)^2/param(2)*secd(xdata).^4.*exp(-(tand(xdata)).^2/param(2)); %water