clear all
dirn1='Hydro\NS\m06y2016\d20m06y2016S023634\'; % path to area* files
MainFile=load(strcat(dirn1,ls(strcat(dirn1,'area*')))); %load areaKu file in
sigma0=MainFile(:,4);                       %get sigma0
La=MainFile(:,1);                           %get lattitude
Lo=MainFile(:,2);                           %get Longitude

SizeSigma=length(sigma0);
Boundries=[64, 168, 44, 132]; %define boundries of the needed area
la1 = 44;
la2 = 64;
lo1 = 132;
lo2 = 168;

figure (30)
landareas=shaperead('landareas.shp','UseGeoCoords',true);
hold on
axesm('MapProjection','mercator','MapLatLimit',...
    [Boundries(3) Boundries(1)],'MapLonLimit',[Boundries(4) Boundries(2)]);
hold on

maxz=max(sigma0);
minz=min(sigma0);
t=0;
cmap=zeros(SizeSigma,3);
LaNew=zeros(SizeSigma,1);
LoNew=zeros(SizeSigma,1);

for j=1:2:SizeSigma
    t=t+1;
    c = wcol(minz,maxz,sigma0(j));
    cmap(t,1)=c(1);
    cmap(t,2)=c(2);
    cmap(t,3)=c(3);
    LaNew(t)=La(j);
    LoNew(t)=Lo(j);
    
end
cmap=cmap(1:t,:);
LoNew=LoNew(1:t);
LaNew=LaNew(1:t);

scatterm(LaNew,LoNew,5,cmap,'filled')
geoshow('landareas.shp', 'FaceColor',  [0.5 0.5 0.5]); %show the map

colorbar('YTickLabel',...
    {num2str(minz),num2str(minz+(maxz-minz)/5),num2str(minz+2*(maxz-minz)/5),num2str(minz+3*(maxz-minz)/5),...
    num2str(minz+4*(maxz-minz)/5),num2str(minz+5*(maxz-minz)/5)});


