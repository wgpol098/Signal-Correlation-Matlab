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

% Last Modified by GUIDE v2.5 02-Aug-2020 11:44:53

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
handles.signaltype2 = 1;
handles.noise1flag = false;
handles.noise2flag = false;
handles.spectrum1flag = false;
handles.spectrum2flag = false;
handles.generatedflag = false;
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
    t = 0:1/fs:period*1/f1+1/fs; %seconds
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

handles.x1 = t;
handles.y1 = u;
handles.generatedflag = true;

set(handles.spectrum1,'Value',0);

%plot
axes(handles.axes1);
plot(t,u);
xlabel('Time (in seconds)');
ylabel('Amplitude (in amperes)');
    
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
if handles.generatedflag == true
    filter = {'*.txt';'*.csv';'*.*'};
    [file, path] = uiputfile(filter);
    file1 = fopen (strcat(path,file),'w');
    fprintf(file1,'%8.5f,%8.5f\n',[handles.x1;handles.y1]);
    fclose(file1);
else
    errordlg('You cannot save a blank plot!','Error');
end
% hObject    handle to save1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load1.
function load1_Callback(hObject, eventdata, handles)
filter = {'*.txt';'*.csv';'*.*'};
[file,path] = uigetfile(filter);
file = load(strcat(path,file));

%plot
axes(handles.axes1);
plot(file(:,1),file(:,2));
xlabel('Time (in seconds)');
ylabel('Amplitude (in amperes)');

%handles
handles.x1 = file(:,1);
handles.y1 = file(:,2);
handles.generatedflag = true;

%f1 for one period
%l = file(:,1)


guidata(hObject, handles);
% hObject    handle to load1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in whitenoise1.
function whitenoise1_Callback(hObject, eventdata, handles)
handles.noise1flag = get(hObject,'Value');

guidata(hObject, handles);
% hObject    handle to whitenoise1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of whitenoise1


% --- Executes on button press in spectrum1.
function spectrum1_Callback(hObject, eventdata, handles)
handles.spectrum1flag = get(hObject,'Value')

if handles.spectrum1flag == true 
    fs = handles.fs;
    y = fftshift(fft(handles.y1));
    n = length(handles.y1); 
    f = -fs/2:fs/n:fs/2-fs/n; 
    power = abs(y)*2/n;
    
    %plot
    axes(handles.axes1);
    plot(f,power);
    xlabel('Frequency (in hertz)');
    ylabel('Power (in amperes)');
else
    axes(handles.axes1);
    plot(handles.x1,handles.y1);
    xlabel('Time (in seconds)');
    ylabel('Amplitude (in amperes)');
end
guidata(hObject, handles);
% hObject    handle to spectrum1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spectrum1


% --- Executes on button press in spectrum2.
function spectrum2_Callback(hObject, eventdata, handles)
handles.spectrum2flag = get(hObject,'Value')

if handles.spectrum2flag == true 
    fs2 = handles.fs2;
    y2 = fftshift(fft(handles.y2));
    n2 = length(handles.y2); 
    f2 = -fs2/2:fs2/n2:fs2/2-fs2/n2; 
    power2 = abs(y2)*2/n2;
    
    %plot
    axes(handles.axes2);
    plot(f2,power2);
    xlabel('Frequency (in hertz)');
    ylabel('Power (in amperes)');
else
    axes(handles.axes2);
    plot(handles.x2,handles.y2);
    xlabel('Time (in seconds)');
    ylabel('Amplitude (in amperes)');
end
guidata(hObject, handles);

% hObject    handle to spectrum2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of spectrum2



function a2_Callback(hObject, eventdata, handles)
% hObject    handle to a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2 as text
%        str2double(get(hObject,'String')) returns contents of a2 as a double
handles.a2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f2_Callback(hObject, eventdata, handles)
handles.f2 = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f2 as text
%        str2double(get(hObject,'String')) returns contents of f2 as a double


% --- Executes during object creation, after setting all properties.
function f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load2.
function load2_Callback(hObject, eventdata, handles)
filter2 = {'*.txt';'*.csv';'*.*'};
[file2,path2] = uigetfile(filter2);
file2 = load(strcat(path2,file2));

%plot
axes(handles.axes2);
plot(file2(:,1),file2(:,2));
xlabel('Time (in seconds)');
ylabel('Amplitude (in amperes)');

%handles
handles.x2 = file2(:,1);
handles.y2 = file2(:,2);
handles.generatedflag2 = true;

%f1 for one period2
%l = file(:,1)


guidata(hObject, handles);
% hObject    handle to load2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save2.
function save2_Callback(hObject, eventdata, handles)
if handles.generatedflag2 == true
    filter2 = {'*.txt';'*.csv';'*.*'};
    [file2, path2] = uiputfile(filter2);
    file2_2 = fopen (strcat(path2,file2),'w');
    fprintf(file2_2,'%8.5f,%8.5f\n',[handles.x2;handles.y2]);
    fclose(file2_2);
else
    errordlg('You cannot save a blank plot!','Error');
end
% hObject    handle to save2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in generate2.
function generate2_Callback(hObject, eventdata, handles)
a2 = handles.a2;
f2 = handles.f2;
fs2 = handles.fs2;
period2 = handles.period2;
signal2 = handles.signaltype2;
%signal 1 - sinus
%signal 2 - sawtooth
%signal 3 - square
%signal 4 - noise
if signal2 == 1
    t2 = 0:1/fs2:period2*1/f2+1/fs2; %seconds
    u2 = a2*cos(2*pi*f2*t2);
elseif signal2 == 2
    t2 = 0:1/fs2:period2*1/f2+1/fs2;
    u2 = sawtooth(2*pi*f2*t2)*a2;
elseif signal2 == 3
    t2 = 0:1/fs2:period2*1/f2+1/fs2;
    u2 = square(2*pi*f2*t2)*a2;
elseif signal2 == 4
    t2 = 0:1/fs2:period2*1/f2+1/fs2;
    for i = 1:length(t2)
        u2(i) = 0 % make a deviation 
    end
end

%white noise
if handles.noise2flag == true | signal2 == 4
    for i = 1:length(u2)
        u2(i) = u2(i) + randn
    end
end

handles.x2 = t2;
handles.y2 = u2;
handles.generatedflag2 = true;

set(handles.spectrum2,'Value',0);

%plot
axes(handles.axes2);
plot(t2,u2);
xlabel('Time (in seconds)');
ylabel('Amplitude (in amperes)');
    
guidata(hObject, handles);

% hObject    handle to generate2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in signaltype2.
function signaltype2_Callback(hObject, eventdata, handles)
% hObject    handle to signaltype2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns signaltype2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signaltype2
handles.signaltype2 = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function signaltype2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signaltype2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in whitenoise2.
function whitenoise2_Callback(hObject, eventdata, handles)
handles.noise2flag = get(hObject,'Value');

guidata(hObject, handles);
% hObject    handle to whitenoise2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of whitenoise2



function fs2_Callback(hObject, eventdata, handles)
handles.fs2 = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to fs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fs2 as text
%        str2double(get(hObject,'String')) returns contents of fs2 as a double


% --- Executes during object creation, after setting all properties.
function fs2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function period2_Callback(hObject, eventdata, handles)
handles.period2 = str2double(get(hObject,'String'));
guidata(hObject, handles);
% hObject    handle to period2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of period2 as text
%        str2double(get(hObject,'String')) returns contents of period2 as a double


% --- Executes during object creation, after setting all properties.
function period2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to period2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in Process.
function Process_Callback(hObject, eventdata, handles)
axes(handles.axes3);
xc=handles.x2;
yc1=handles.y1;
yc2=handles.y2;
r=xcorr(yc1,yc2);
s=size(xc);
if s(1) == 1
    st=s(2)
else
    st=s(1)
end
r=r(1:st);
%r = max(r,0)
axes(handles.axes3);
plot(xc,r)
%bar(xc,r)
% hObject    handle to Process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
