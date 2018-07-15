clear all

bnum{1} = 'NS';
com='comfile17.txt';
nb=1;
for ib=1:nb
    mkdir(bnum{ib});
end

    % LaTop---- -----------
    %          |           |
    %          |           |
    %          |           |
    %          |           |
    % LaBottom- -----------
    %          |           |
    %       LoLeft      LoRight
    
 %Boundries=[64,168,44,132]; %boundries like this [LaTop,LoRight,LaBottom,LoLeft], clockwise
 %as follows: CenterPoint=[LoMidPoint,LaMidPoint]
 %CenterPoint=[0.5*(Boundries(2)+Boundries(4)),0.5*(Boundries(1)+Boundries(3))]
 
 
 LaBottom(1) = 44;
 LaTop(1) = 64;
 La0(1) = 0.5*(LaBottom(1)+LaTop(1));
 
 LoLeft(1) = 132;
 LoRight(1) = 168;
 Lo0(1) = 0.5*(LoLeft(1)+LoRight(1));

fid = fopen(com);
sh=26; % 3-7,10-12_15
% sh=57; % 8,9_15
qq=0;

while ~feof(fid)
    L = fgets(fid);
    year = strcat(L(sh),L(1+sh));
    month = strcat(L(2+sh),L(3+sh));
    day = strcat(L(4+sh),L(5+sh));
    orbit = strcat('S',L(sh+6:sh+9),'00');
    
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
    k1=cutfr_rect_swath(LaKu,LoKu,LaBottom,LoLeft,LaTop,LoRight,boo1,boo2,d21,d22,j11,j22,bnum,day,month,year,orbit,Lsw,nb,sizeKu,IncAngleKu,sigmaKu,preciprateKu,secofdayKu);
    
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