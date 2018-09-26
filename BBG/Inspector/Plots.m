function varargout = Plots(varargin)
% PLOTS MATLAB code for Plots.fig
%      PLOTS, by itself, creates a new PLOTS or raises the existing
%      singleton*.
%
%      H = PLOTS returns the handle to a new PLOTS or the handle to
%      the existing singleton*.
%
%      PLOTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTS.M with the given input arguments.
%
%      PLOTS('Property','Value',...) creates a new PLOTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Plots_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Plots_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Plots

% Last Modified by GUIDE v2.5 25-Sep-2018 20:00:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Plots_OpeningFcn, ...
                   'gui_OutputFcn',  @Plots_OutputFcn, ...
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


% --- Executes just before Plots is made visible.
function Plots_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Plots (see VARARGIN)

handles.output = hObject;
handles.path='';
guidata(hObject, handles);

% UIWAIT makes Plots wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Plots_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in MultiPlot.
function MultiPlot_Callback(hObject, eventdata, handles)
% hObject    handle to MultiPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles
mouse=1;
b=1;
 while mouse<3 %while RButton (mouse=3) is not pressed
     
     [x,y,mouse]=ginput(1);
     hold(handles.HC,'on')
     plot(handles.HC,handles.sigNS(floor(y),:))
     str{b} = ['b = ',num2str(y)];
     legend(handles.HC,str)
     
     
     yy=smooth(handles.sigNS(floor(y),:),10);
     plot(handles.SmoothHC,yy);
     legend(handles.SmoothHC,str)    
     hold(handles.SmoothHC,'on')
     b=b+1;
 end




% --- Executes on button press in LoadBtn.
function LoadBtn_Callback(hObject, eventdata, handles)
% hObject    handle to LoadBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.path = uigetdir(handles.path);

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
handles
imagesc(handles.Track,handles.sigNS)
guidata(hObject, handles);


% --- Executes on button press in copy.
function copy_Callback(hObject, eventdata, handles)
% hObject    handle to copy (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
mouse=1;
while mouse<3
    
    [mouse]=ginput(1);
    ax=handles.SmoothHC;
    ay=handles.Track;
%     name=ax.Tag;
    hh=figure;
    copyobj(ax,hh);
    copyobj(ay,hh);
%     HC.Position=[4.8 28 1600 900];
    
 
 end



    
      
