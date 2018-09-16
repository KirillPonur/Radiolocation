function varargout = Inspector(varargin)
% INSPECTOR MATLAB code for Inspector.fig
%      INSPECTOR, by itself, creates a new INSPECTOR or raises the existing
%      singleton*.
%
%      H = INSPECTOR returns the handle to a new INSPECTOR or the handle to
%      the existing singleton*.
%
%      INSPECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INSPECTOR.M with the given input arguments.
%
%      INSPECTOR('Property','Value',...) creates a new INSPECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Inspector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Inspector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Inspector

% Last Modified by GUIDE v2.5 01-Aug-2018 11:17:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Inspector_OpeningFcn, ...
                   'gui_OutputFcn',  @Inspector_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Inspector is made visible.
function Inspector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Inspector (see VARARGIN)

% Choose default command line output for Inspector
handles.output = hObject;
handles.path='';
guidata(hObject, handles);

% UIWAIT makes Inspector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Inspector_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



    function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to dataInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataInput as text
%        str2double(get(hObject,'String')) returns contents of dataInput as a double


%%%%%%%%%%%  Mfuncs  %%%%%%%%%%%%%%
         function plotMap(handles,file)
            axes(handles.Map)
            cla
            MainFile=load(strcat(file,'\',ls(strcat(file,'\area*')))); %load areaKu file in
            sigma0=MainFile(:,4);                       %get sigma0
            La=MainFile(:,1);                           %get lattitude
            Lo=MainFile(:,2);                           %get Longitude
            SizeSigma=length(sigma0);
            Boundries=[64, 168, 44, 132]; %define boundries of the needed area
            axes(handles.Map)
            landareas=shaperead('landareas.shp','UseGeoCoords',true);
            hold on
            axesm('MapProjection','mercator','MapLatLimit',[Boundries(3) Boundries(1)],'MapLonLimit',[Boundries(4) Boundries(2)]);
            hold on
            maxz=max(sigma0);
            minz=min(sigma0);
            t=0;
            cmap=zeros(SizeSigma,3);
            LaNew=zeros(SizeSigma,1);
            LoNew=zeros(SizeSigma,1);
            for j=1:SizeSigma
                t=t+1;
                cmap(t,:)=wcol1(minz,maxz,sigma0(j));
                LaNew(t)=La(j);
                LoNew(t)=Lo(j);
            end
            cmap=cmap(1:t,:);
            LoNew=LoNew(1:t);
            LaNew=LaNew(1:t);
            
            geoshow('landareas.shp', 'FaceColor',  [0.5 0.5 0.5]); %show the map
            scatterm(LaNew,LoNew,5,cmap,'filled')
            
         function f = wcol1(xmin,xmax, x)
                
                d = xmax - xmin;
                dd = d/4+0.00001;
                
                if (x>=xmin) && (x<xmin+dd)
                    xx = x - xmin;
                    B= 255;
                    R = 0;
                    G = 255*xx/dd;
                end
                if (x>=xmin+dd) && (x<xmin+2*dd)
                    xx = x - xmin - dd;
                    B = (dd - xx)*255/dd;
                    G = 255;
                    R = 0;
                end
                if (x>=xmin+2*dd) && (x<xmin+3*dd)
                    xx = x - xmin - 2*dd;
                    B = 0;
                    G = 255;
                    R = 255*xx/dd;
                end
                if (x>=xmin+3*dd) && (x<=xmin+4*dd)
                    xx = x - xmin - 3*dd;
                    B = 0;
                    G = (dd - xx)*255/dd;
                    R = 255;
                end
                f = [R/255 G/255 B/255];
                
         function [handles]=flipImage(handles) %flip images
             sz=size(handles.thetaNS);
             tempT=handles.thetaNS;
             tempS=handles.sigNS;
             for i=1:sz(1)
                handles.thetaNS(i,:)=tempT(sz(1)-i+1,:);
                handles.sigNS(i,:)=tempS(sz(1)-i+1,:);
             end
             
             sz=size(handles.thetaMS);
             tempT=handles.thetaMS;
             tempS=handles.sigMS;
             for i=1:sz(1)
                 handles.thetaMS(i,:)=tempT(sz(1)-i+1,:);
                 handles.sigMS(i,:)=tempS(sz(1)-i+1,:);
             end
             
         function updateTags(handles)
             set(handles.KuVC,'Tag','KuVC');
             set(handles.KuHC,'Tag','KuHC');
             set(handles.KaVC,'Tag','KaVC');
             set(handles.KaHC,'Tag','KaHC');
                         
         function drawRectangle(position,handles)
          position=[floor(position(1)),floor(position(2)),floor(position(3)),floor(position(4))];
          % [xmin ymin width height]
          tSize=size(handles.thetaNS);
          sigNSV=zeros(tSize(1),1);
          sigNSH=zeros(tSize(2),1);
          thNS=handles.thetaNS(:,position(1));
          for i=1:floor(tSize(1)/2)
              thNS(i)=-handles.thetaNS(i);
          end
          
          for j=position(2):position(2)+position(4)
              for i=position(1):position(1)+position(3)
                 sigNSV(j)=sigNSV(j)+handles.sigNS(j,i);
              end
              sigNSV(j)=sigNSV(j)/position(3);
          end
          
          for i=position(1):position(1)+position(3)
              for j=position(2):position(2)+position(4)
                 sigNSH(i)=sigNSH(i)+handles.sigNS(j,i);
              end
              sigNSH(i)=sigNSH(i)/position(4);
          end
          [paramNew]=lsqcurvefit(@HypApp,[5 0 0],thNS(position(2):position(2)+position(4)),sigNSV(position(2):position(2)+position(4)));
          err=100/(max(sigNSV(position(2):position(2)+position(4)))-min(sigNSV(position(2):position(2)+position(4))))*mean((HypApp(paramNew,thNS(position(2):position(2)+position(4)))-sigNSV(position(2):position(2)+position(4))).^2);
          plot(handles.KuHC,position(1):position(1)+position(3),sigNSH(position(1):position(1)+position(3)))
          plot(handles.KuVC,thNS(position(2):position(2)+position(4)),sigNSV(position(2):position(2)+position(4)))
          hold(handles.KuVC);
          plot(handles.KuVC,thNS(position(2):position(2)+position(4)),HypApp(paramNew,thNS(position(2):position(2)+position(4))))
          hold(handles.KuVC,'off');
%     scatter(handles.KuVC,th0(floor(y)),handles.sigNS(floor(y),floor(x)),'g','filled')
%     hold(handles.KuVC,'off');
%     plot(handles.KuHC,handles.sigNS(floor(y),:))
%     hold(handles.KuHC);
%     scatter(handles.KuHC,x,handles.sigNS(floor(y),floor(x)),'g','filled')
%     hold(handles.KuHC,'off');
    if paramNew(1)<2000 && paramNew(1)>15 && paramNew(3)<100 && err<10
        handles.iceText.String='Is Ice';
    else
        handles.iceText.String='Not Ice';
    end
    handles.KuVC.Title.String=strcat('Horizontal-Summmed. AvSquare:',num2str(err),'%',' a=',num2str(paramNew(1)),' c=',num2str(paramNew(2)));
    handles.KuHC.Title.String='Vertical-Summed';
    handles.KuVC.YLabel.String='RCS-Db';
    handles.KuHC.YLabel.String='RCS-Db';
               
         function F=HypApp(param,xdata)
          F=param(1)*abs(1./(abs(xdata)+param(2)))+param(3);                
             
         function F=WaterApp(param,xdata)
             F=param(1)^2/param(2)*secd(xdata).^4.*exp(-(tand(xdata)).^2/param(2));
         
         function icePredict(handles) % scan the track
             sizeTh=size(handles.thetaNS);
             colFlags1=zeros(1,sizeTh(2));
             colFlags2=zeros(1,sizeTh(2));
             colFlags3=zeros(1,sizeTh(2));
             newsigNS=handles.sigNS;
             iceAverage=zeros(sizeTh(1),1);
             iceAvAm=0;
             waterAverage=zeros(sizeTh(1),1);
             waterAvAm=0;
         parfor i=1:sizeTh(2) % vertical-scan ||||||->
             thNS=handles.thetaNS(:,i);
             for j=1:floor(sizeTh(1)/2)
              thNS(j)=-handles.thetaNS(j);
             end
             
            [paramNewH]=lsqcurvefit(@HypApp,[5 0 0],thNS,handles.sigNS(:,i));
            errH=100/(max(handles.sigNS(:,i))-min(handles.sigNS(:,i)))*mean((handles.sigNS(:,i)-HypApp(paramNewH,thNS)).^2);
            if paramNewH(1)<2000 && paramNewH(1)>15 && paramNewH(3)<100 && errH<30
                iceFlag=true;
                iceAverage=iceAverage+handles.sigNS(:,i);
                iceAvAm=iceAvAm+1;
            else
                iceFlag=false;
            end
            
%             sigNSNorm = 10.^(handles.sigNS(:,i)./10); % convert to normalized   
%             [paramNewW] = lsqcurvefit(@WaterApp,[1 1],thNS,sigNSNorm);
%             WaterAppDB = 10*log10(WaterApp(paramNewW,thNS));
%             errW = 100/(max(handles.sigNS(:,i))-min(handles.sigNS(:,i)))*mean((handles.sigNS(:,i)-WaterAppDB).^2);
%                 if abs(paramNewW(1))>0.5 && abs(paramNewW(1))<0.85 && paramNewW(2)>0 && paramNewW(2)<0.1 && errW<15
%                 waterFlag = true;
%                 waterAverage=waterAverage+handles.sigNS(:,i);
%                 waterAvAm=waterAvAm+1;
%                 else
%                 waterFlag = false;
%                 end
            colFlags3(i) = iceFlag;
%             colFlags2(i) = waterFlag;
            colFlags2(i) = 0;
            
            %straighten
%             if  waterFlag
%                 waterDiff = max(WaterAppDB)-WaterAppDB;
%                  newsigNS(:,i)=newsigNS(:,i)+waterDiff;
%             end
%             if iceFlag
%                 iceDiff = max(HypApp(paramNewH,thNS))-HypApp(paramNewH,thNS);
%                 newsigNS(:,i)=newsigNS(:,i)+iceDiff;
%             end
         end
%          iceAverage=iceAverage/iceAvAm;
%          waterAverage=waterAverage/waterAvAm;
%          [Lmin,LminIndex]=min(abs(iceAverage(1:floor(sizeTh(1)/2))-waterAverage(1:floor(sizeTh(1)/2))));
%          [Rmin,RminIndex]=min(abs(iceAverage(floor(sizeTh(1)/2):length(iceAverage))-waterAverage(floor(sizeTh(1)/2):length(waterAverage))));
%          RminIndex=RminIndex+floor(sizeTh(1))/2-1;      
         %edges
         params=zeros(sizeTh);
         for i=1:sizeTh(1)
            [maxs,Imaxs]=findpeaks(findEdgesH(handles.sigNS,i));
            maxs=maxs.*100/max(maxs);
            for j=1:length(maxs)
                if maxs(j)>20
                    params(i,Imaxs(j))=1;
                end
            end
         end
         
         %exp flipped
%          params1=zeros(sizeTh);
%          fsigNS=fliplr(handles.sigNS);
%          for i=1:sizeTh(1)
%             [maxs,Imaxs]=findpeaks(findEdgesH(fsigNS,i));
%             maxs=maxs.*100/max(maxs);
%             for j=1:length(maxs)
%                 if maxs(j)>15
%                     params1(i,Imaxs(j))=1;
%                 end
%             end
%          end
         %exp
         
         
         %for vertical cuts
%          for i=1:sizeTh(2)
%             [maxs,Imaxs]=findpeaks(findEdgesV(handles,sigNS,i));
%             maxs=maxs.*100/max(maxs);
%             for j=1:length(maxs)
%                 if maxs(j)>30
%                     params(Imaxs(j),i)=1;
%                 end
%             end
%          end
         
         colFlags=[colFlags1; colFlags2; colFlags3];
         nMap=zeros(sizeTh);
%          paramsIndex=zeros(sizeTh);
         m=1;
         for i=1:sizeTh(2)
%             if ~colFlags2(i) || ~colFlags3(i)
%                 for j=1:sizeTh(1)
%                     if handles.sigNS(j,i)>iceAverage(j)
%                         if j < LminIndex || j > RminIndex
%                             nMap(j,i)=1;
%                         else
%                             nMap(j,i)=2;
%                         end
%                     end
%                     if handles.sigNS(j,i)<iceAverage(j)
%                         if j > LminIndex && j < RminIndex
%                             nMap(j,i)=1;
%                         else
%                             nMap(j,i)=2;
%                         end
%                     end
%                 end
%             end
            if colFlags2(i)==1
                nMap(:,i)=1; %water
            end
            if colFlags3(i)==1
                nMap(:,i)=2; %ice
            end
         end
         j=1;        
         for i=1:sizeTh(2)
             if colFlags(3,i)~=0
                 LaNS(:,j)=handles.LaNS(:,i);
                 LoNS(:,j)=handles.LoNS(:,i);
                 j=j+1;
             end
            
         end
         oldnMap=nMap;
         %filling da flags
         
         k=1;
         for i = 1:sizeTh(1)
             BorderIndex=zeros(1,sizeTh(2));
           for j=1:sizeTh(2)
            if params(i,j) == 1
                BorderIndex(k)=j;
                k=k+1;
            end
           end
           BorderIndex=BorderIndex(1:k-1);
           BorderIndex=[1,BorderIndex,sizeTh(2)];
           k=1; iAm=0; zAm=0; wAm=0;
           for k=1:length(BorderIndex)-1
               for m=BorderIndex(k):BorderIndex(k+1)
                   if nMap(i,m) == 0
                     zAm=zAm+1;
                   end
                   if nMap(i,m) == 1
                     wAm=wAm+1;      
                   end
                   if nMap(i,m) == 2
                     iAm=iAm+1;          
                   end
               end
               Ams=[zAm,wAm,iAm];
               [maxAms,maxAmsIndex]=max(Ams);
               nMap(i,BorderIndex(k):BorderIndex(k+1))=maxAmsIndex-1;
               wAm=0;iAm=0;zAm=0;
           end
          
           k=1;
         end
  


         nMap=nMap+15*params; %paint borders with flags
         for i=1:sizeTh(2)
             for j=1:sizeTh(1)
                if nMap(j,i)>=14
                    nMap(j,i)=3;
                end
             end
            
         end
         cmap=[0 0 0.5 ; 0 1 1 ; 1 0 0];
         %strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\image*')))
         [A,R] = geotiffread(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\image.tif'))));
         figure('Position',[100 100 1600 900],'Color','white')
         geoshow(A,R)
         hold on
         h=geoshow(handles.LaNS,handles.LoNS,nMap,cmap);
         set(h,'FaceAlpha',0.5)
         xlim(R.LongitudeLimits)
         ylim(R.LatitudeLimits)
         iceFileName=handles.pathNS(length(handles.pathNS)-18:end);
         imPath=strcat(handles.pathNS(1:length(handles.pathNS)-18),'images\',iceFileName);
         export_fig(imPath,'-png','-q100')
         
         
         
%          figure
%          imagesc(params) %show borders
%          figure
%          imagesc(nMap)   %show icemap with borders
%         figure
%         imagesc(oldnMap)
%          figure
%          plot(iceAverage)
%          hold on
%          plot(waterAverage)
%          hold off
%          imagesc(fliplr(params1)+params)
%          imagesc(colFlags);       
         
        %show  basic ice map
%          figure
%          Boundries=[64, 168, 44, 132];
%          axesm('MapProjection','mercator','MapLatLimit',[Boundries(3) Boundries(1)],'MapLonLimit',[Boundries(4) Boundries(2)]);
%          LaNS=LaNS(:);
%          LoNS=LoNS(:);
%          geoshow(LaNS,LoNS)
%          scatterm(LaNS,LoNS,5,[0 0.6 0.9])
%          geoshow('landareas.shp', 'FaceColor',  [0.5 0.5 0.5]);
         
         function [edgeness]=findEdgesV(sigNS,rowNumber)
            tSizeNS=size(sigNS);
            y=rowNumber;
            sigma=6;
            x=-100:100;
            G=-x.*exp(-x.^2/(2*sigma^2));
            Gh=@(x,s) -x.*exp(-x.^2/(2*s^2));
            convd=conv(sigNS(:,floor(y)),G,'same');
           % convd=convd/max(convd)*max(handles.sigNS(floor(y),:));
            Gdx = diff([G 0]);
            datadx = diff([sigNS(:,floor(y));mean(sigNS(:,floor(y)))]);
            SNR=abs(convd)./sqrt(integral(@(x)(Gh(x,sigma)).^2,0,tSizeNS(2)));
            Loc=abs(conv(datadx,Gdx,'same'))./sqrt(integral(@(x)diff(([Gh(x,sigma) 0])).^2,0,1));
            edgeness=SNR.*Loc;  
%             edgeness=SNR; 
            
         function [edgeness]=findEdgesH(sigNS,lineNumber)
            tSizeNS=size(sigNS);
            y=lineNumber;
            sigma=6;
            x=-50:50;
            G=-x.*exp(-x.^2/(2*sigma^2));
            Gh=@(x,s) -x.*exp(-x.^2/(2*s^2));
            convd=conv(sigNS(floor(y),:),G,'same');
           % convd=convd/max(convd)*max(handles.sigNS(floor(y),:));
            Gdx = diff([G 0]);
            datadx = diff([sigNS(floor(y),:) mean(sigNS(floor(y),:))]);
            SNR=abs(convd)./sqrt(integral(@(x)(Gh(x,sigma)).^2,0,tSizeNS(2)));
            Loc=abs(conv(datadx,Gdx,'same'))./sqrt(integral(@(x)diff(([Gh(x,sigma) 0])).^2,0,tSizeNS(2)));
             %edgeness=SNR.*Loc;
              edgeness=SNR;
         

% --- Executes on button press in pointCutBtn.
function pointCutBtn_Callback(hObject, eventdata, handles)
% hObject    handle to pointCutBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mouse=1;
tSizeNS=size(handles.thetaNS);
tSizeMS=size(handles.thetaMS);
handles.KuHC.Title.FontWeight='bold';
handles.KuHC.YLabel.FontName='Helvetica';
handles.KuVC.Title.FontWeight='bold';
handles.KuVC.YLabel.FontName='Helvetica';
axes(handles.KuTrack)

 while mouse<3 %while RButton (mouse=3) is not pressed
    [x,y,mouse]=ginput(1);
    ax=gca;
    if strcmp(ax.Tag,'KuTrack')
        cla(handles.KuHC)
        cla(handles.KuVC)
        thN=handles.thetaNS(:,floor(x));
        for i=1:floor(tSizeNS(1)/2)
            thN(i)=-handles.thetaNS(i);
        end
        plot(handles.KuVC,thN,handles.sigNS(:,floor(x)));
        hold(handles.KuVC);
        scatter(handles.KuVC,thN(floor(y)),handles.sigNS(floor(y),floor(x)),'g','filled')
         
        sigNSNorm=10.^(handles.sigNS(:,floor(x))./10); % convert to normalized
         [paramNewH]=lsqcurvefit(@HypApp,[5 0 0],thN,handles.sigNS(:,floor(x)));
         [paramNewW]=lsqcurvefit(@WaterApp,[1 1],thN,sigNSNorm);
         WaterAppDB=10*log10(WaterApp(paramNewW,thN));
         stdW=sqrt(mean((handles.sigNS(:,floor(x))-WaterAppDB).^2));
         stdH=sqrt(mean((handles.sigNS(:,floor(x))-HypApp(paramNewH,thN)).^2));
         errW=100/(max(handles.sigNS(:,floor(x)))-min(handles.sigNS(:,floor(x))))*mean((handles.sigNS(:,floor(x))-WaterAppDB).^2);
         errH=100/(max(handles.sigNS(:,floor(x)))-min(handles.sigNS(:,floor(x))))*mean((handles.sigNS(:,floor(x))-HypApp(paramNewH,thN)).^2);
         plot(handles.KuVC,thN,HypApp(paramNewH,thN))
         if errW<1000
            plot(handles.KuVC,thN,WaterAppDB) 
         end
         
        hold(handles.KuVC,'off');
        plot(handles.KuHC,handles.sigNS(floor(y),:))
        hold(handles.KuHC);
        scatter(handles.KuHC,x,handles.sigNS(floor(y),floor(x)),'g','filled')
        
        %convolute with gauss's 1st derivative
        param=findEdgesH(handles.sigNS,y);
        param2=findEdgesV(handles.sigNS,x);
%         plot(handles.KuHC,convd/max(convd)*max(handles.sigNS(floor(y),:)))
        plot(handles.KuHC,param/max(param)*max(handles.sigNS(floor(y),:)))
        hold(handles.KuHC,'off');
        hold(handles.KuVC);
        plot(handles.KuVC,thN,param2/max(param2)*max(handles.sigNS(:,floor(x))))
        hold(handles.KuVC,'off');
        
        hold(handles.KuHC,'off');
        handles.KuVC.Title.String='Vertical-Cut';
        handles.wText.String=strcat('R(0)=',num2str(paramNewW(1)),'  s=',num2str(paramNewW(2)),'  err=',num2str(errW),'  std=',num2str(stdW));
        handles.iText.String=strcat('a=',num2str(paramNewH(1)),' b=',num2str(paramNewH(2)),' c=',num2str(paramNewH(3)),' err=',num2str(errH),'  std=',num2str(stdH));
        handles.KuVC.Title.String='Vertical-Cut';
        handles.KuHC.Title.String='Horizontal-Cut';
        handles.KuVC.YLabel.String='RCS-Db';
        handles.KuHC.YLabel.String='RCS-Db';
    end
        if strcmp(ax.Tag,'KaTrack')
        cla(handles.KaHC)
        cla(handles.KaVC)
        thM=handles.thetaMS(:,floor(x));
        for i=1:floor(tSizeMS(1)/2)
            thM(i)=-handles.thetaMS(i);
        end
        plot(handles.KaVC,thM,handles.sigMS(:,floor(x)));
        hold(handles.KaVC);
        scatter(handles.KaVC,thM(floor(y)),handles.sigMS(floor(y),floor(x)),'g','filled')
        hold(handles.KaVC,'off');
        plot(handles.KaHC,handles.sigMS(floor(y),:))
        hold(handles.KaHC);
        scatter(handles.KaHC,x,handles.sigMS(floor(y),floor(x)),'g','filled')
        hold(handles.KaHC,'off');
        handles.KaVC.Title.String='Vertical-Cut';
        handles.KaHC.Title.String='Horizontal-Cut';
        handles.KaVC.YLabel.String='RCS-Db';
        handles.KaHC.YLabel.String='RCS-Db';
        end
end


% --- Executes on button press in rectCutBtn.
function rectCutBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rectCutBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    cla(handles.KuHC)
    cla(handles.KuVC)
    axes(handles.KuTrack)
    handles.rectangle=imrect;
    drawHandle=@(pos) drawRectangle(pos,handles);
    drawRectangle(getPosition(handles.rectangle),handles);
    addNewPositionCallback(handles.rectangle,drawHandle);
    

% --- Executes on button press in LoadBtn.
function LoadBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LoadBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.path = uigetdir(handles.path);

    cla(handles.KuVC)
    cla(handles.KuHC)

handles.ind=[];
handles.ind=strfind(handles.path,'NS');
if isempty(handles.ind)
    handles.ind=strfind(handles.path,'MS');
    if isempty(handles.ind)
        error('Invalid directory');
    end
end
handles.DateText.String=handles.path(handles.ind:end);
handles.pathNS=strcat(handles.path(1:handles.ind-1),'NS',handles.path(handles.ind+2:end));
handles.pathMS=strcat(handles.path(1:handles.ind-1),'MS',handles.path(handles.ind+2:end));
handles.sigNS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\Sig*'))));
handles.LaNS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\La*'))));
handles.LoNS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\Lo*'))));
handles.LaMS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\La*'))));
handles.LoMS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\Lo*'))));
handles.thetaNS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\Inc*'))));
handles.sigMS = load(strcat(handles.pathMS,'\',ls(strcat(handles.pathMS,'\Sig*'))));
handles.thetaMS = load(strcat(handles.pathMS,'\',ls(strcat(handles.pathMS,'\Inc*'))));
% hold(handles.KuTrack)
axes(handles.KuTrack)
imagesc(handles.KuTrack,handles.sigNS);
set(gca,'Tag','KuTrack')
%handles.KuTrack.YTickLabel={num2str(min(handles.thetaNS)),num2str(max(handles.thetaNS))};
colorbar
% hold(handles.KuTrack,'off')
% hold(handles.KaTrack)
axes(handles.KaTrack)
imagesc(handles.KaTrack,handles.sigMS);
set(gca,'Tag','KaTrack')
colorbar
% hold(handles.KaTrack,'off')
plotMap(handles,handles.pathNS);
% set(handles.Map,'toolbar','figure');
updateTags(handles)
guidata(hObject, handles);


% --- Executes on button press in FlpBtn.
function FlpBtn_Callback(hObject, eventdata, handles)
% hObject    handle to FlpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=flipImage(handles);
hold(handles.KuTrack)
imagesc(handles.KuTrack,handles.sigNS);
%handles.KuTrack.YTickLabel={num2str(min(handles.thetaNS)),num2str(max(handles.thetaNS))};
colorbar
hold(handles.KuTrack,'off')
hold(handles.KaTrack)
imagesc(handles.KaTrack,handles.sigMS);
axes(handles.KaTrack)
colorbar
hold(handles.KaTrack,'off')
guidata(hObject, handles);


% --- Executes on button press in calcBtn.
function calcBtn_Callback(hObject, eventdata, handles)
% hObject    handle to calcBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
icePredict(handles);

% --- Executes on button press in SaveBtn.
function SaveBtn_Callback(hObject, eventdata, handles)
mouse=1;
% hObject    handle to SaveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
updateTags(handles)
while mouse<3
    
    [mouse]=ginput(1);
    ax=gca;
    name=ax.Tag;
    hh=figure;
    copyobj(ax,hh);
    ax=gca;
    ax.Position=[0.13 0.11 0.775 0.815];
    mkdir images
    path=strcat(cd,'\images\',name);
    if size(name)==(0)
        saveas(hh,strcat(cd,'\images\','NoTag'),'jpg');
    else
        saveas(hh,path,'jpg');
    end   
    close(gcf);
 
 end

