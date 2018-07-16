clear all
 dirn1='okhotskTest2\'; % path to area* files
 list=ls(dirn1);
 ListSize=size(list);   
 dirn2 = 'figuresT3\tracks_color_Ku';   %create new directory to save png's to     
 mkdir(dirn2);
 for i=4:ListSize(1)
          
    MainFile=load(strcat(dirn1,list(i,:),'\areaKu.txt')); %load areaKu file in
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
    axesm('MapProjection','mercator','MapLatLimit',[Boundries(3) Boundries(1)],'MapLonLimit',[Boundries(4) Boundries(2)]);
    hold on
    
    maxz=max(sigma0);
    minz=min(sigma0);   
     
      for j=1:100:SizeSigma
     
          if (floor(j/100)*100-j)==0
             disp(strcat('Pixels drawn: ',num2str(j))); 
          end
          mcolor = wcol(minz,maxz,sigma0(j)); %map sigma0 to color     
          geoshow(La(j),Lo(j), 'Marker', 'o', 'MarkerSize',2,'MarkerFaceColor',mcolor,'Color',mcolor);    %show the iterated ponit  
          hold on  
          
      end   

    %hold on
    colorbar('YTickLabel',...
         {num2str(minz),num2str(minz+(maxz-minz)/5),num2str(minz+2*(maxz-minz)/5),num2str(minz+3*(maxz-minz)/5),...
          num2str(minz+4*(maxz-minz)/5),num2str(minz+5*(maxz-minz)/5)});
      
    hold on
    geoshow('landareas.shp', 'FaceColor',  [0.5 0.5 0.5]);      %show the map 
   % hold on    
    print(strcat(dirn2,'\b1',list(i,:),'.png'),'-dpng');        %save to png
    close;
  end
