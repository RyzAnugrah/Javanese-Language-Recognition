function varargout = aksara(varargin)
% AKSARA MATLAB code for aksara.fig
%      AKSARA, by itself, creates a new AKSARA or raises the existing
%      singleton*.
%
%      H = AKSARA returns the handle to a new AKSARA or the handle to
%      the existing singleton*.
%
%      AKSARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AKSARA.M with the given input arguments.
%
%      AKSARA('Property','Value',...) creates a new AKSARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aksara_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aksara_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aksara

% Last Modified by GUIDE v2.5 26-May-2020 17:15:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aksara_OpeningFcn, ...
                   'gui_OutputFcn',  @aksara_OutputFcn, ...
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


% --- Executes just before aksara is made visible.
function aksara_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aksara (see VARARGIN)

% Choose default command line output for aksara
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aksara wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aksara_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bStart.
function bStart_Callback(hObject, eventdata, handles)
% hObject    handle to bStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%sesuaikan dengan metode yang dipilih 
vid = videoinput('winvideo', 1, 'YUY2_320x240');
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';
triggerconfig(vid, 'manual');
vidRes = get(vid, 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes (2);
nBands = get(vid, 'NumberOfBands');
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.aPreview);
preview(vid, hImage);
handles.vid = vid;
guidata(hObject, handles);

% --- Executes on button press in bCapture.
function bCapture_Callback(hObject, eventdata, handles)
% hObject    handle to bCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isfield(handles, 'vid')
    warndlg('Start camera terlebih dahulu!');
    return
end

vid = handles.vid;
src = getselectedsource(vid);
vid.FramesPerTrigger = 1;
vid.ReturnedColorspace = 'rgb';
triggerconfig(vid, 'manual');
vidRes = get(vid, 'VideoResolution');
imWidth = vidRes(1);
imHeight = vidRes (2);
nBands = get(vid, 'NumberOfBands');
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.aPreview); 
preview(vid, hImage);

start(vid);
pause(3);
trigger(vid);
stoppreview(vid);
capt1 = getdata (vid);
imwrite(capt1, 'captured.png');
warndlg('Done!');
