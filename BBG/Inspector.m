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

% Last Modified by GUIDE v2.5 17-Jul-2018 20:51:43

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
handles.file='Hydro\NS\m06y2016\d20m06y2016S023634';
handles.sig = load(strcat(handles.file,'\SigKu.txt'));
handles.theta=load(strcat(handles.file,'\IncKu.txt'));

imagesc(handles.KuTrack,handles.sig);
%plotMap(handles,handles.file);
% Update handles structure
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


% --- Executes during object creation, after setting all properties.
function dataInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%  Mfuncs  %%%%%%%%%%%%%%
    function []=plotMap(handles,file)
        MainFile=load(strcat(file,'\areaKu.txt')); %load areaKu file in
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
          
          geoshow('landareas.shp', 'FaceColor',  [0.5 0.5 0.5]); %show the map 
            scatterm(LaNew,LoNew,5,cmap,'filled')
            colorbar
%         colorbar('YTickLabel',...
%              {num2str(minz),num2str(minz+(maxz-minz)/5),num2str(minz+2*(maxz-minz)/5),num2str(minz+3*(maxz-minz)/5),...
%               num2str(minz+4*(maxz-minz)/5),num2str(minz+5*(maxz-minz)/5)});
%      


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mouse=1;
tSize=size(handles.theta);
axes(handles.KuTrack)
 while mouse<3 %while RButton (mouse=3) is not pressed
    axes(handles.KuTrack)
    [x,y,mouse]=ginput(1);
    th0=handles.theta(:,floor(x));
    for i=1:floor(tSize(1)/2)
        th0(i)=-handles.theta(i);
    end
    plot(handles.KuHC,th0,handles.sig(:,floor(x)));
    axes(handles.KuHC)
    ylabel('RCS-Db')
    title('Vertical-Cut')
    plot(handles.KuVC,handles.sig(floor(y),:))
    axes(handles.KuVC)
    title('Horizontal-Cut')
    ylabel('RCS-Db')
 end


% --- Executes on button press in LoadBtn.
function LoadBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LoadBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.date=get(handles.dataInput,'String');
set(handles.popupmenu1,'String',handles.date);


function dataInput_Callback(hObject, eventdata, handles)
% hObject    handle to dataInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataInput as text
%        str2double(get(hObject,'String')) returns contents of dataInput as a double


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
