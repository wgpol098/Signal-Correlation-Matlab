function varargout = signal(varargin)
% SIGNAL MATLAB code for signal.fig
%      SIGNAL, by itself, creates a new SIGNAL or raises the existing
%      singleton*.
%
%      H = SIGNAL returns the handle to a new SIGNAL or the handle to
%      the existing singleton*.
%
%      SIGNAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNAL.M with the given input arguments.
%
%      SIGNAL('Property','Value',...) creates a new SIGNAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signal

% Last Modified by GUIDE v2.5 02-Jul-2020 20:53:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signal_OpeningFcn, ...
                   'gui_OutputFcn',  @signal_OutputFcn, ...
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


% --- Executes just before signal is made visible.
function signal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signal (see VARARGIN)

% Choose default command line output for signal
%default values 
handles.signaltype1 = 1;
handles.noise1flag = false;
handles.noise2flag = false;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a1_Callback(hObject, eventdata, handles)
handles.a1 = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1 as text
%        str2double(get(hObject,'String')) returns contents of a1 as a double


% --- Executes during object creation, after setting all properties.
function a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f1_Callback(hObject, eventdata, handles)
handles.f1 = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f1 as text
%        str2double(get(hObject,'String')) returns contents of f1 as a double


% --- Executes during object creation, after setting all properties.
function f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate1.
function generate1_Callback(hObject, eventdata, handles)
a1 = handles.a1;
f1 = handles.f1;
fs = handles.fs;
period = handles.period;
signal = handles.signaltype1;
%signal 1 - sinus
%signal 2 - sawtooth
%signal 3 - square
%signal 4 - noise
if signal == 1
    t = 0:1/fs:period*1/f1+1/fs;% seconds
    u = a1*cos(2*pi*f1*t);
elseif signal == 2
    t = 0:1/fs:period*1/f1+1/fs;
    u = sawtooth(2*pi*f1*t)*a1;
elseif signal == 3
    t = 0:1/fs:period*1/f1+1/fs;
    u = square(2*pi*f1*t)*a1;
elseif signal == 4
    t = 0:1/fs:period*1/f1+1/fs;
    for i = 1:length(t)
        u(i) = 0 % make a deviation 
    end
end

%white noise
if handles.noise1flag == true | signal == 4
    for i = 1:length(u)
        u(i) = u(i) + randn
    end
end

handles.x1 = t
handles.y1 = u

%plot
axes(handles.axes1);
plot(t,u);
xlabel('time (in seconds)');
    
guidata(hObject, handles);
% hObject    handle to generate1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in signaltype1.
function signaltype1_Callback(hObject, eventdata, handles)
handles.signaltype1 = get(hObject,'Value');
guidata(hObject, handles);
% hObject    handle to signaltype1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns signaltype1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signaltype1


% --- Executes during object creation, after setting all properties.
function signaltype1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signaltype1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fs_Callback(hObject, eventdata, handles)
handles.fs = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fs as text
%        str2double(get(hObject,'String')) returns contents of fs as a double


% --- Executes during object creation, after setting all properties.
function fs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function period_Callback(hObject, eventdata, handles)
handles.period = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of period as text
%        str2double(get(hObject,'String')) returns contents of period as a double


% --- Executes during object creation, after setting all properties.
function period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save1.
function save1_Callback(hObject, eventdata, handles)
filter = {'*.mat';'*.txt';'*.csv';'*.*'};
[file, path] = uiputfile(filter);
file1 = fopen (strcat(path,file),'w');
fprintf(file1,'%8.5f,%8.5f\n',[handles.x1;handles.y1]);
fclose(file1);
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load1.
function load1_Callback(hObject, eventdata, handles)
filter = {'*.mat';'*.txt';'*.csv';'*.*'};
[file,path] = uigetfile(filter);
file = load(strcat(path,file))

%plot
axes(handles.axes1);
plot(file(:,1),file(:,2));
xlabel('time (in seconds)');

%handles
handles.x1 = file(:,1)
handles.y1 = file(:,2)

%f1 for one period
%l = file(:,1)


guidata(hObject, handles);
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in whitenoise1.
function whitenoise1_Callback(hObject, eventdata, handles)
handles.noise1flag = get(hObject,'Value')

guidata(hObject, handles);
% hObject    handle to whitenoise1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of whitenoise1
