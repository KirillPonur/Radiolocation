clear all
thNS=load('IncKu.txt');
LaKu=load('LaKu.txt');
LoKu=load('LoKu.txt');
sizeT=size(thNS);
SigNS=zeros(sizeT);
Water=zeros(sizeT);
Ice=zeros(sizeT);
SigNS_map=perlin2D(sizeT(1),sizeT(2));
Ai=153.12; Bi=4.25; Ci=-13.67; %ice param
Aw=0.72; Bw=0.03; %water param
WN=randn(sizeT);
for i=1:sizeT(2)
    Ice(:,i)=Ai*abs(1./(abs(thNS(:,i))+Bi))+Ci;%ice
    Water(:,i)=10*log10(Aw^2/Bw*secd(thNS(:,i)).^4.*exp(-(tand(thNS(:,i))).^2/Bw)); %water
end
%filling with w/i
for i=1:sizeT(2)
    for j=1:sizeT(1)
        if SigNS_map(j,i)< 0.4
            SigNS(j,i)=Ice(j,i);
        else
            SigNS(j,i)=Water(j,i);
        end
    end
end
%smoothing
for n=1:1
    for i=2:sizeT(2)-1
        for j=2:sizeT(1)-1
            %         if SigNS(j,i) < mean([SigNS(j+1,i) SigNS(j-1,i) SigNS(j,i+1) SigNS(j,i-1)])
            SigNS(j,i)=mean([SigNS(j+1,i) SigNS(j-1,i) SigNS(j,i+1) SigNS(j,i-1)]);
            %         end
        end
    end
end

%add noise
SigNS=SigNS+WN+0.1*SigNS.*perlin2D(sizeT(1),sizeT(2));
fidK = fopen('areaKu.txt','wt');

for ii=1:sizeT(1)
    for jj=1:sizeT(2)
        
        fprintf(fidK,'%e   %e   %e   %e   \r\n',LaKu(ii,jj),LoKu(ii,jj),thNS(ii,jj),SigNS(ii,jj));
        
    end
end
    
fidSig = fopen('SigKu.txt','wt');
dlmwrite('SigKu.txt',SigNS,'delimiter','\t');
imagesc(SigNS)
colorbar
print('angled','-dpng')