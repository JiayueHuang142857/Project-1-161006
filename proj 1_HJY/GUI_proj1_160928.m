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
guidata(hObject, handles);
handles.output = hObject;
handle1 = gcf;
setappdata(0,'handle1',handle1);
setappdata(handle1,'PlotAxes',handles.axes1);
SampleRate = 1;
setappdata(handle1,'SampleRate',SampleRate);
FileNum = 0;
setappdata(handle1,'FileNum',FileNum);
SignalSave = [];
setappdata(handle1,'SignalSave',SignalSave);
z = 2;
setappdata(handle1,'Zoom',z);
% set(handles.figure1, 'DeleteFcn', {@DeleteFcn});
% === %
h = line;
set(h,'Marker','*','LineStyle','none');
h.Parent = handles.axes1;
setappdata(handle1,'LineHandle',h);
% =============== Buttons Settings =============== %
set(handles.ConfirmButton, 'Enable','on');
set(handles.StartButton, 'Enable','off');
set(handles.StopButton, 'Enable','off');
set(handles.ContinueButton, 'Enable','off');
set(handles.ExitButton, 'Enable','on');
set(handles.Xadd, 'Enable','off');
set(handles.Xminus, 'Enable','off');
set(handles.Yadd, 'Enable','off');
set(handles.Yminus, 'Enable','off');
% ================================================ %

% --- Outputs from this function are returned to the command line.
function varargout = GUI_proj1_160928_OutputFcn(hObject, eventdata, handles) 
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
% =============== Buttons Settings =============== %
set(handles.ConfirmButton, 'Enable','off');
set(handles.StartButton, 'Enable','off');
set(handles.StopButton, 'Enable','on');
set(handles.ContinueButton, 'Enable','off');
set(handles.ExitButton, 'Enable','on');
set(handles.Xadd, 'Enable','on');
set(handles.Xminus, 'Enable','on');
set(handles.Yadd, 'Enable','on');
set(handles.Yminus, 'Enable','on');
% ================================================ %
handle1 = getappdata(0,'handle1');
SampleRate = get(handles.RateInput,'string');
SampleRate = str2num(SampleRate);
setappdata(handle1,'SampleRate',SampleRate);
setappdata(0,'SampleRate',SampleRate);
h = getappdata(handle1,'LineHandle');
set(h,'XData',[],'YData',[]);
PointNum = 0;
setappdata(handle1,'PointNum',PointNum);
z = 1;
setappdata(handle1,'Zoom',z);
InstantAI();




% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% =============== Buttons Settings =============== %
set(handles.ConfirmButton, 'Enable','off');
set(handles.StartButton, 'Enable','off');
set(handles.StopButton, 'Enable','off');
set(handles.ContinueButton, 'Enable','on');
set(handles.ExitButton, 'Enable','on');
set(handles.Xadd, 'Enable','off');
set(handles.Xminus, 'Enable','off');
set(handles.Yadd, 'Enable','off');
set(handles.Yminus, 'Enable','off');
% ================================================ %
handle1 = getappdata(0,'handle1');
SignalSave = getappdata(handle1,'SignalSave');
FileNum = getappdata(handle1,'FileNum');
save(['Signal',int2str(FileNum)],'SignalSave');
SignalSave = [];
FileNum = FileNum+1;
setappdata(handle1,'SignalSave',SignalSave);
setappdata(handle1,'FileNum',FileNum);

t = getappdata(handle1,'TimerHandle');
stop(t);
delete(t);

instantAiCtrl = getappdata(handle1,'instantAiCtrl');
instantAiCtrl.Dispose();






% --- Executes on button press in ContinueButton.
function ContinueButton_Callback(hObject, eventdata, handles)
% =============== Buttons Settings =============== %
set(handles.ConfirmButton, 'Enable','off');
set(handles.StartButton, 'Enable','off');
set(handles.StopButton, 'Enable','on');
set(handles.ContinueButton, 'Enable','off');
set(handles.ExitButton, 'Enable','on');
set(handles.Xadd, 'Enable','on');
set(handles.Xminus, 'Enable','on');
set(handles.Yadd, 'Enable','on');
set(handles.Yminus, 'Enable','on');
% ================================================ %

% --- Executes on button press in ExitButton.
function ExitButton_Callback(hObject, eventdata, handles)
% =============== Buttons Settings =============== %
set(handles.ConfirmButton, 'Enable','off');
set(handles.StartButton, 'Enable','off');
set(handles.StopButton, 'Enable','off');
set(handles.ContinueButton, 'Enable','off');
set(handles.ExitButton, 'Enable','on');
set(handles.Xadd, 'Enable','off');
set(handles.Xminus, 'Enable','off');
set(handles.Yadd, 'Enable','off');
set(handles.Yminus, 'Enable','off');
% ================================================ %
close;




% --- Executes on button press in ConfirmButton.
function ConfirmButton_Callback(hObject, eventdata, handles)
% =============== Buttons Settings =============== %
set(handles.ConfirmButton, 'Enable','off');
set(handles.StartButton, 'Enable','on');
set(handles.StopButton, 'Enable','off');
set(handles.ContinueButton, 'Enable','off');
set(handles.ExitButton, 'Enable','on');
set(handles.Xadd, 'Enable','off');
set(handles.Xminus, 'Enable','off');
set(handles.Yadd, 'Enable','off');
set(handles.Yminus, 'Enable','off');
% ================================================ %

% --- Executes on button press in Yadd.
function Yadd_Callback(hObject, eventdata, handles)
% hObject    handle to Yadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Yminus.
function Yminus_Callback(hObject, eventdata, handles)
% hObject    handle to Yminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Xadd.
function Xadd_Callback(hObject, eventdata, handles)
% hObject    handle to Xadd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Xminus.
function Xminus_Callback(hObject, eventdata, handles)
% hObject    handle to Xminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
