function varargout = signal(varargin)
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


function signal_OpeningFcn(hObject, eventdata, handles, varargin)
handles.signaltype1 = 1;
handles.signaltype2 = 1;
handles.noise1flag = false;
handles.noise2flag = false;
handles.spectrum1flag = false;
handles.spectrum2flag = false;
handles.spectrum3flag = false;
handles.generatedflag = false;
handles.generatedflag2 = false;
handles.generatedflag3 = false;
handles.output = hObject;

%default values in guide
handles.a1 = 0;
handles.a2 = 0;
handles.f1 = 0;
handles.f2 = 0;
handles.period = 0;
handles.period2 = 0;
handles.fs = 0;
handles.signaltype1 = 1;


guidata(hObject, handles); % Update handles structure


function varargout = signal_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function a1_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.a1 = str2double(tempstr);
guidata(hObject, handles);


function a1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function f1_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.f1 = str2double(tempstr);
guidata(hObject, handles);


function f1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function generate1_Callback(hObject, eventdata, handles)
a1 = handles.a1;
f1 = handles.f1;
fs = handles.fs;
period = handles.period;
signal = handles.signaltype1;
noSamples = handles.noSamples

if a1 == 0 || f1 == 0 || fs == 0 || isempty(a1) || isempty(f1) || isempty(fs)
    errordlg('Cant generate with bad value!','Error');
    return
end

%signal 1 - sinus
%signal 2 - sawtooth
%signal 3 - square
%signal 4 - noise
if signal == 1
    numSeconds = noSamples / fs
    t = linspace(0, numSeconds, noSamples);
    %t = 0:1/fs:period*1/f1+1/fs; %seconds
    u = a1*sin(2*pi*f1*t);
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


function signaltype1_Callback(hObject, eventdata, handles)
handles.signaltype1 = get(hObject,'Value');
guidata(hObject, handles);


function signaltype1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fs_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.fs = str2double(tempstr);
guidata(hObject, handles);


function fs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function period_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.period = str2double(tempstr);
guidata(hObject, handles);


function period_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


function whitenoise1_Callback(hObject, eventdata, handles)
handles.noise1flag = get(hObject,'Value');
guidata(hObject, handles);


function spectrum1_Callback(hObject, eventdata, handles)
handles.spectrum1flag = get(hObject,'Value')

if handles.generatedflag == true
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
end
guidata(hObject, handles);


function spectrum2_Callback(hObject, eventdata, handles)
handles.spectrum2flag = get(hObject,'Value')

if handles.generatedflag2 == true
if handles.spectrum2flag == true 
    fs = handles.fs;
    y2 = fftshift(fft(handles.y2));
    n2 = length(handles.y2); 
    f2 = -fs/2:fs/n2:fs/2-fs/n2; 
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
end
guidata(hObject, handles);


function a2_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.a2 = str2double(tempstr);
guidata(hObject, handles);


function a2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function f2_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.f2 = str2double(tempstr);
guidata(hObject, handles);


function f2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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


function generate2_Callback(hObject, eventdata, handles)
a2 = handles.a2;
f2 = handles.f2;
fs = handles.fs;
period2 = handles.period2;
signal2 = handles.signaltype2;
noSamples = handles.noSamples;

if a2 == 0 || f2 == 0 || fs == 0 || isempty(a2) || isempty(f2) || isempty(fs)
    errordlg('Cant generate with bad value!','Error');
    return
end

%signal 1 - sinus
%signal 2 - sawtooth
%signal 3 - square
%signal 4 - noise
if signal2 == 1
    numSeconds = noSamples / fs
    t2 = linspace(0, numSeconds, noSamples);
    %t2 = 0:1/fs:period2*1/f2+1/fs; %seconds
    u2 = a2*sin(2*pi*f2*t2);
elseif signal2 == 2
    t2 = 0:1/fs:period2*1/f2+1/fs;
    u2 = sawtooth(2*pi*f2*t2)*a2;
elseif signal2 == 3
    t2 = 0:1/fs:period2*1/f2+1/fs;
    u2 = square(2*pi*f2*t2)*a2;
elseif signal2 == 4
    t2 = 0:1/fs:period2*1/f2+1/fs;
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


function signaltype2_Callback(hObject, eventdata, handles)
handles.signaltype2 = get(hObject,'Value');
guidata(hObject, handles);


function signaltype2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function whitenoise2_Callback(hObject, eventdata, handles)
handles.noise2flag = get(hObject,'Value');
guidata(hObject, handles);


function fs2_Callback(hObject, eventdata, handles)
handles.fs2 = str2double(get(hObject,'String'));
guidata(hObject, handles);


function fs2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function period2_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.period2 = str2double(tempstr);
guidata(hObject, handles);


function period2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function spectrum3_Callback(hObject, eventdata, handles)
% TO DO JAK B�DZIE KORELACJA
handles.spectrum3flag = get(hObject, 'Value');

if handles.generatedflag3 == true
end

guidata(hObject, handles);


function save3_Callback(hObject, eventdata, handles)
if handles.generatedflag3 == true
    filter3 = {'*.txt';'*.csv';'*.*'};
    [file2, path2] = uiputfile(filter3);
    file3_3 = fopen (strcat(path3,file3),'w');
    fprintf(file3_3,'%8.5f,%8.5f\n',[handles.x3;handles.y3]);
    fclose(file3_3);
else
    errordlg('You cannot save a blank plot!','Error');
end


function load3_Callback(hObject, eventdata, handles)
filter3 = {'*.txt';'*.csv';'*.*'};
[file3,path3] = uigetfile(filter3);
file3 = load(strcat(path3,file3));

%plot
axes(handles.axes3);
plot(file3(:,1),file3(:,2));
xlabel('Time (in seconds)');
ylabel('Amplitude (in amperes)');

%handles
handles.x3 = file3(:,1);
handles.y3 = file3(:,2);
handles.generatedflag3 = true;
guidata(hObject, handles);

function Process_Callback(hObject, eventdata, handles)

function Number = RemoveLetters(StringWithLetters)
    Number = StringWithLetters;
    LettersInString = isletter(StringWithLetters);
    Number(LettersInString)=[];
    if strlength(Number) == 0
        Number = "0";
    end



function NoSamples_Callback(hObject, eventdata, handles)
tempstr = RemoveLetters(get(hObject,'String'));
handles.noSamples = str2double(tempstr);
guidata(hObject, handles);

function NoSamples_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
