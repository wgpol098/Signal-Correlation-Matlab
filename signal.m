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
handles.f3 = 0;
handles.period = 0;
handles.period2 = 0;
handles.fs = 0;
handles.noSamples = 0;
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
signal = handles.signaltype1;
noSamples = handles.noSamples

if a1 == 0 || f1 == 0 || fs == 0 || noSamples == 0 || isempty(a1) || isempty(f1) || isempty(fs) || isempty(noSamples)
    errordlg('Cant generate with bad value!','Error');
    return
end

numSeconds = noSamples / fs;
t = linspace(0, numSeconds, noSamples);
%signal 1 - sinus
%signal 2 - sawtooth
%signal 3 - square
%signal 4 - noise
if signal == 1
    u = a1*sin(2*pi*f1*t);
elseif signal == 2
    u = sawtooth(2*pi*f1*t)*a1;
elseif signal == 3
    u = square(2*pi*f1*t)*a1;
elseif signal == 4
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
if file ~= 0
    file = load(strcat(path,file));

    %plot
    axes(handles.axes1);
    plot(file(:,1),file(:,2));
    xlabel('Time (in seconds)');
    ylabel('Amplitude (in amperes)');

    %handles
    handles.x1 = transpose(file(:,1));
    handles.y1 = transpose(file(:,2));
    handles.generatedflag = true;
    set(handles.spectrum1,'Value',0);
    guidata(hObject, handles);
end

function whitenoise1_Callback(hObject, eventdata, handles)
handles.noise1flag = get(hObject,'Value');
guidata(hObject, handles);


function spectrum1_Callback(hObject, eventdata, handles)
handles.spectrum1flag = get(hObject,'Value')

if handles.generatedflag == true
    if handles.spectrum1flag == true
        y = fft(handles.y1);
        n = length(handles.y1);          % number of samples
        f = (0:n-1)*(handles.fs/n);     % frequency range
        power = abs(y)*2/n;
        axes(handles.axes1);
        if (sum(f) ~= 0)
            bar(f,power);
            xlabel('Frequency (in hertz)');
            ylabel('Power (in amperes)');
        else
            errordlg('You need to complete the "fp" field!','Error');
            set(handles.spectrum1,'Value',0);
        end
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
        y = fft(handles.y2);
        n = length(handles.y2);          % number of samples
        f = (0:n-1)*(handles.fs/n);     % frequency range
        power = abs(y)*2/n;
        axes(handles.axes2);
        if (sum(f) ~= 0)
            bar(f,power);
            xlabel('Frequency (in hertz)');
            ylabel('Power (in amperes)');
        else
            errordlg('You need to complete the "fp" field!','Error');
            set(handles.spectrum2,'Value',0);
        end
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
if file2 ~= 0
    file2 = load(strcat(path2,file2));

    %plot
    axes(handles.axes2);
    plot(file2(:,1),file2(:,2));
    xlabel('Time (in seconds)');
    ylabel('Amplitude (in amperes)');

    %handles
    handles.x2 = transpose(file2(:,1));
    handles.y2 = transpose(file2(:,2));
    handles.generatedflag2 = true;
    set(handles.spectrum2,'Value',0);
    guidata(hObject, handles);
end

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
signal2 = handles.signaltype2;
noSamples = handles.noSamples;

if a2 == 0 || f2 == 0 || fs == 0 || noSamples == 0 || isempty(a2) || isempty(f2) || isempty(fs) || isempty(noSamples)
    errordlg('Cant generate with bad value!','Error');
    return
end
numSeconds = noSamples / fs;
t2 = linspace(0, numSeconds, noSamples);
    
%signal 1 - sinus
%signal 2 - sawtooth
%signal 3 - square
%signal 4 - noise
if signal2 == 1
    u2 = a2*sin(2*pi*f2*t2);
elseif signal2 == 2
    u2 = sawtooth(2*pi*f2*t2)*a2;
elseif signal2 == 3
    u2 = square(2*pi*f2*t2)*a2;
elseif signal2 == 4
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


function spectrum3_Callback(hObject, eventdata, handles)
handles.spectrum3flag = get(hObject,'Value')
if handles.generatedflag3 == true
if handles.spectrum3flag == true 
        y = fft(handles.y3);
        n = length(handles.y3);          % number of samples
        f = (0:n-1)*(handles.fs/n);     % frequency range
        power = abs(y)*2/n;
        axes(handles.axes3);
        if (sum(f) ~= 0)
            bar(f,power);
            xlabel('Frequency (in hertz)');
            ylabel('Power (in amperes)');
        else
            errordlg('You need to complete the "fp" field!','Error');
            set(handles.spectrum3,'Value',0);
        end
else
    axes(handles.axes3);
    plot(handles.x3,handles.y3);
    xlabel('Time (in seconds)');
    ylabel('Amplitude (in amperes)');
end
end
guidata(hObject, handles);



function save3_Callback(hObject, eventdata, handles)
if handles.generatedflag3 == true
    filter3 = {'*.txt';'*.csv';'*.*'};
    [file3, path3] = uiputfile(filter3);
    file3_3 = fopen (strcat(path3,file3),'w');
    fprintf(file3_3,'%8.5f,%8.5f\n',[handles.x3;handles.y3]);
    fclose(file3_3);
else
    errordlg('You cannot save a blank plot!','Error');
end


function load3_Callback(hObject, eventdata, handles)
filter3 = {'*.txt';'*.csv';'*.*'};
[file3,path3] = uigetfile(filter3);

if file3 ~= 0
    file3 = load(strcat(path3,file3));

    %plot
    axes(handles.axes3);
    plot(file3(:,1),file3(:,2));
    xlabel('Time (in seconds)');
    ylabel('Amplitude (in amperes)');

    %handles
    handles.x3 = transpose(file3(:,1));
    handles.y3 = transpose(file3(:,2));
    handles.generatedflag3 = true;
    guidata(hObject, handles);
end

function Process_Callback(hObject, eventdata, handles)
if handles.generatedflag == true && handles.generatedflag2 == true
    r=xcorr(handles.y1,handles.y2);
    s=max(size(handles.x1));
    maxr=max(r)
    r=(r/maxr)*(max(handles.y1)*max(handles.y2))/2;
    axes(handles.axes3);
    x3=1:max(size(r));
    plot(x3,r);
    xlabel('No. Samples');
    ylabel('Amplitude (in amperes)');
    handles.y3=r;
    handles.x3=x3;
    handles.generatedflag3 = true;
    set(handles.spectrum3,'Value',0);
    guidata(hObject, handles);
else
    errordlg('You cannot generate correlation!','Error');
end

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
