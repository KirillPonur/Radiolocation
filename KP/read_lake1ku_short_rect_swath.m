clear all

 bnum{1} = 'NS';



nb=1;

for ib=1:nb
    mkdir(bnum{ib});
end

 La01(1) = 44;
 La02(1) = 64;
 La0(1) = 0.5*(La01(1)+La02(1));

 
 Lo01(1) = 132;
 Lo02(1) = 168;
 Lo0(1) = 0.5*(Lo01(1)+Lo02(1));

fid = fopen('comfile17.txt');
sh=26; % 3-7,10-12_15
% sh=57; % 8,9_15
qq=0;

while ~feof(fid)
    L = fgets(fid)
    god = strcat(L(sh),L(1+sh));
month = strcat(L(2+sh),L(3+sh));
day = strcat(L(4+sh),L(5+sh));
orbit = strcat('S',L(sh+6:sh+9),'00')
    
    fn = sscanf(L,'%s');   
    fileinfo = hdf5info(fn);
% Groups(1) - HS, Ka-band; Groups(3) - NS, Ku-band
     LaKu = hdf5read(fileinfo.GroupHierarchy.Groups(3).Datasets(1));
     LoKu = hdf5read(fileinfo.GroupHierarchy.Groups(3).Datasets(2));
     
     %sigmaKu =
     %hdf5read(fileinfo.GroupHierarchy.Groups(3).Groups(10).Datasets(5))-
     %MS, Ka-band
     sigmaKu = hdf5read(fileinfo.GroupHierarchy.Groups(3).Groups(9).Datasets(5));
     secofdayKu = hdf5read(fileinfo.GroupHierarchy.Groups(3).Groups(8).Datasets(8));
     preciprateKu = hdf5read(fileinfo.GroupHierarchy.Groups(3).Groups(6).Datasets(10));
     IncAngleKu = hdf5read(fileinfo.GroupHierarchy.Groups(3).Groups(5).Datasets(11));
     sizeKu = size(LaKu);
     Lsw = sizeKu(1)*5;
     
    npolosy = 1;
    jmin = 2860;
    jmax = 3300;
    [boo1,d21,j11]= apprpt(LaKu,LoKu,La0,Lo0,jmin,jmax,npolosy,nb);
    npolosy = sizeKu(1);
    [boo2,d22,j22]= apprpt(LaKu,LoKu,La0,Lo0,jmin,jmax,npolosy,nb);    
    k1=cutfr_rect_swath(LaKu,LoKu,La01,Lo01,La02,Lo02,boo1,boo2,d21,d22,j11,j22,bnum,day,month,god,orbit,Lsw,nb,sizeKu,IncAngleKu,sigmaKu,preciprateKu,secofdayKu);
    
%     if k1==1  
%         npolosy = 1;
%         jmin = 4630;
%         jmax = 5050;
%         [boo1,d21,j11]= apprpt(LaKu,LoKu,La0,Lo0,jmin,jmax,npolosy,nb);
%         npolosy = sizeKu(1);
%         [boo2,d22,j22]= apprpt(LaKu,LoKu,La0,Lo0,jmin,jmax,npolosy,nb);
%         k1=cutfr_rect(LaKu,LoKu,La01,Lo01,La02,Lo02,boo1,boo2,d21,d22,j11,j22,bnum,day,month,god,orbit,Lsw,nb,sizeKu,IncAngleKu,sigmaKu,preciprateKu,secofdayKu);            
%     end
end 