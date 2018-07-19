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

% Last Modified by GUIDE v2.5 19-Jul-2018 02:57:26

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
            
            %         colorbar('AxisLocation','in','FontSize',9,...
            %             'Ticks',[minz,maxz])%minz+(maxz-minz)/5,minz+2*(maxz-minz)/5,...
            %minz+3*(maxz-minz)/5,minz+4*(maxz-minz)/5,minz+5*(maxz-minz)/5])%,...
            %             'TickLabels',{num2str(minz),num2str(minz+(maxz-minz)/5),...
            %             num2str(minz+2*(maxz-minz)/5),num2str(minz+3*(maxz-minz)/5),...
            %             num2str(minz+4*(maxz-minz)/5),num2str(minz+5*(maxz-minz)/5)});
            %
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
             
         function drawRectangle(position,handles)
%           position=getPosition(handles.rectangle);
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
          plot(handles.KuHC,position(1):position(1)+position(3),sigNSH(position(1):position(1)+position(3)))
          plot(handles.KuVC,thNS(position(2):position(2)+position(4)),sigNSV(position(2):position(2)+position(4)))
          %hold(handles.KuVC);
%     scatter(handles.KuVC,th0(floor(y)),handles.sigNS(floor(y),floor(x)),'g','filled')
%     hold(handles.KuVC,'off');
%     plot(handles.KuHC,handles.sigNS(floor(y),:))
%     hold(handles.KuHC);
%     scatter(handles.KuHC,x,handles.sigNS(floor(y),floor(x)),'g','filled')
%     hold(handles.KuHC,'off');
    handles.KuVC.Title.String='Horizontal-Summmed';
    handles.KuHC.Title.String='Vertical-Summed';
    handles.KuVC.YLabel.String='RCS-Db';
    handles.KuHC.YLabel.String='RCS-Db';
% end

        

% --- Executes on button press in pointCutBtn.
function pointCutBtn_Callback(hObject, eventdata, handles)
% hObject    handle to pointCutBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mouse=1;
tSize=size(handles.thetaNS);
handles.KuHC.Title.FontWeight='bold';
handles.KuHC.YLabel.FontName='Helvetica';
handles.KuVC.Title.FontWeight='bold';
handles.KuVC.YLabel.FontName='Helvetica';
axes(handles.KuTrack)
 while mouse<3 %while RButton (mouse=3) is not pressed
    [x,y,mouse]=ginput(1);
    cla(handles.KuHC)
    cla(handles.KuVC)
    th0=handles.thetaNS(:,floor(x));
    for i=1:floor(tSize(1)/2)
        th0(i)=-handles.thetaNS(i);
    end
    plot(handles.KuVC,th0,handles.sigNS(:,floor(x)));
    hold(handles.KuVC);
    scatter(handles.KuVC,th0(floor(y)),handles.sigNS(floor(y),floor(x)),'g','filled')
    hold(handles.KuVC,'off');
    plot(handles.KuHC,handles.sigNS(floor(y),:))
    hold(handles.KuHC);
    scatter(handles.KuHC,x,handles.sigNS(floor(y),floor(x)),'g','filled')
    hold(handles.KuHC,'off');
    handles.KuVC.Title.String='Vertical-Cut';
    handles.KuHC.Title.String='Horizontal-Cut';
    handles.KuVC.YLabel.String='RCS-Db';
    handles.KuHC.YLabel.String='RCS-Db';
end


% --- Executes on button press in rectCutBtn.
function rectCutBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rectCutBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% mouse=1;
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
handles.thetaNS = load(strcat(handles.pathNS,'\',ls(strcat(handles.pathNS,'\Inc*'))));
handles.sigMS = load(strcat(handles.pathMS,'\',ls(strcat(handles.pathMS,'\Sig*'))));
handles.thetaMS = load(strcat(handles.pathMS,'\',ls(strcat(handles.pathMS,'\Inc*'))));
axes(handles.KuTrack)
imagesc(handles.KuTrack,handles.sigNS);
%handles.KuTrack.YTickLabel={num2str(min(handles.thetaNS)),num2str(max(handles.thetaNS))};
colorbar
imagesc(handles.KaTrack,handles.sigMS);
axes(handles.KaTrack)
colorbar
plotMap(handles,handles.pathNS);

guidata(hObject, handles);


% --- Executes on button press in FlpBtn.
function FlpBtn_Callback(hObject, eventdata, handles)
% hObject    handle to FlpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=flipImage(handles);
axes(handles.KuTrack)
imagesc(handles.KuTrack,handles.sigNS);
colorbar
imagesc(handles.KaTrack,handles.sigMS);
axes(handles.KaTrack)
colorbar
guidata(hObject, handles);
