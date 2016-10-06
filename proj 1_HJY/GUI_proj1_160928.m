function varargout = GUI_proj1_160928(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_proj1_160928_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_proj1_160928_OutputFcn, ...
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


% --- Executes just before GUI_proj1_160928 is made visible.
function GUI_proj1_160928_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles.output = hObject;
handle1 = gcf;
setappdata(0,'handle1',handle1);
setappdata(handle1,'PlotAxes',handles.axes1);
SampleRate = 1;
setappdata(handle1,'SampleRate',SampleRate);
% === %
FileNum = 0;
setappdata(handle1,'FileNum',FileNum);
SignalSave = [];
setappdata(handle1,'SignalSave',SignalSave);
z = 1;
setappdata(handle1,'Zoom',z);
% set(handles.figure1, 'DeleteFcn', {@DeleteFcn});
% === %
h = line;
set(h,'Marker','*','LineStyle','none');
h.Parent = handles.axes1;
setappdata(handle1,'LineHandle',h);
% === %
% set(handles.Srate_Reset, 'Enable','off');
% set(handles.Start_Rec, 'Enable','off');
% set(handles.Stop_Rec, 'Enable','off');
% set(handles.Plus, 'Enable','off');
% set(handles.Minus, 'Enable','off');
% === %

% --- Outputs from this function are returned to the command line.
function varargout = GUI_proj1_160928_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function RateInput_Callback(hObject, eventdata, handles)
% hObject    handle to RateInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RateInput as text
%        str2double(get(hObject,'String')) returns contents of RateInput as a double


% --- Executes during object creation, after setting all properties.
function RateInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RateInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartButton.
% ======================================================================= %
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handle1 = getappdata(0,'handle1');
SampleRate = get(handles.RateInput,'string');
SampleRate = str2num(SampleRate);
setappdata(handle1,'SampleRate',SampleRate);
setappdata(0,'SampleRate',SampleRate);
h = getappdata(handle1,'LineHandle');
set(h,'XData',[],'YData',[]);
% set(handles.Stop_Rec, 'Enable','on');
% set(handles.Start_Rec, 'Enable','off');
PointNum = 0;
setappdata(handle1,'PointNum',PointNum);
z = 1;
setappdata(handle1,'Zoom',z);
InstantAI();




% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%stop(t);
%delete(t);




%==================================================%
% function TimerCallback(obj, event, instantAiCtrl, startChannel, ...
%     channelCount, data)
% DataFile = fopen('1.txt','w'); % open the file "1.txt" in order to write data
% for j=0:(channelCount - 1)
%     fprintf(DataFile , data.Get(j));
% end


% --- Executes on button press in ContinueButton.
function ContinueButton_Callback(hObject, eventdata, handles)
% hObject    handle to ContinueButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ExitButton.
function ExitButton_Callback(hObject, eventdata, handles)
% hObject    handle to ExitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t = getappdata(0,'t_');
stop(t);
delete(t);
instantAiCtrl = getappdata(0,'instantAiCtrl_');
instantAiCtrl.Dispose();
msgbox('Sampling Stopped!');
