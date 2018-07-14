   %  dirn1='F:\slick_1\1\special\cut\';
 dirn1='okhot17\';
 list=ls(dirn1);
 szl=size(list);
 
 for i=4:szl(1)
     
     
%    i=1;  
%    dirn1='H:\slick_1\1\2010_06\cut\data\20100608.71561';
     
     AA=load(strcat(dirn1,list(i,:),'\areaKu.txt'));
     sigma0=AA(:,4);
     lala1=AA(:,1);
     lolo1=AA(:,2);
    
%     sigma0=load(strcat(dirn1,'\Prec.txt'));
%     lala1=load(strcat(dirn1,'\La.txt'));
%     lolo1=load(strcat(dirn1,'\Lo.txt'));
    
    szsig=size(sigma0);    
%   for q=1:szsig(1)
%   ii=floor((q-1)/49)+1;
%   jj=q-(ii-1)*49;
%   SigA(ii,jj)=Sig(q);
%   end
la1 = 44;
la2 = 64;
lo1 = 132;
lo2 = 168;

    k=szsig(1);

    figure (30)
    landareas=shaperead('landareas.shp','UseGeoCoords',true);
      hold on
     axesm('MapProjection','mercator','MapLatLimit',[la1 la2],'MapLonLimit',[lo1 lo2]);

     hold on

     q1=1;
      for ii=1:szsig(1)
          for jj=1:szsig(2)
              z(q1)=sigma0(ii,jj);
              lala(q1)=lala1(ii,jj);
              lolo(q1)=lolo1(ii,jj);
              q1=q1+1;
          end
      end
      
%       z = sigma0;
       maxz=max(z);
%        maxz=5;
      minz=min(z);   
     
      for i1=1:q1-1
%           if z(i1)>=maxz
%                z(i1)=maxz-0.001;
%           end
          
          if (floor(i1/100)*100-i1)==0
             i1 
          end
               
          mcolor = wcol(minz,maxz,z(i1));      
          geoshow(lala(i1),lolo(i1), 'Marker', 'o', 'MarkerSize',2,'MarkerFaceColor',mcolor,'Color',mcolor);      
          hold on    
      end   

      hold on
      colorbar('YTickLabel',...
            {num2str(minz),num2str(minz+(maxz-minz)/5),num2str(minz+2*(maxz-minz)/5),num2str(minz+3*(maxz-minz)/5),...
          num2str(minz+4*(maxz-minz)/5),num2str(minz+5*(maxz-minz)/5)});
      
       hold on
       geoshow('landareas.shp', 'FaceColor',  [0.5 0.5 0.5]); 
       hold on
%        geoshow(28.737,-88.387, 'Marker', '+', 'MarkerSize',5,'MarkerFaceColor','k','Color','k');
%        hold on
%        geoshow(29.208,-88.226, 'Marker', '+', 'MarkerSize',5,'MarkerFaceColor','k','Color','k');
%        
        
        
        dirn2 = 'figures\tracks_color_Ku';       
        mkdir(dirn2);
        
        print(strcat(dirn2,'\b1',list(i,:),'.png'),'-dpng'); 
        close;
  end
