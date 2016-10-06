% InstantAI.m

function InstantAI()
    handle1 = getappdata(0,'handle1');
    
    BDaq = NET.addAssembly('Automation.BDaq4');
    deviceDescription = 'DemoDevice,BID#0'; 
    startChannel = int32(0);
    channelCount = int32(1); 
    % === %
    global Data
    Data = [];
    instantAiCtrl = Automation.BDaq.InstantAiCtrl();
    instantAiCtrl.SelectedDevice = Automation.BDaq.DeviceInformation(...
        deviceDescription);
    data = NET.createArray('System.Double', channelCount);
    
    SampleRate =getappdata(handle1,'SampleRate');
    % errorCode = Automation.BDaq.ErrorCode();
    setappdata(handle1,'instantAiCtrl',instantAiCtrl); 
    t = timer('TimerFcn', {@TimerCallback, instantAiCtrl, startChannel, ...
        channelCount, data}, 'period',round(1000/SampleRate)/1000, 'executionmode', 'fixedrate', ...
        'StartDelay', 1);
    start(t);
    setappdata(handle1,'TimerHandle',t);

end

% function result = BioFailed(errorCode)
% 
% result =  errorCode < Automation.BDaq.ErrorCode.Success && ...
%     errorCode >= Automation.BDaq.ErrorCode.ErrorHandleNotValid;
% 
% end

function TimerCallback(obj, event, instantAiCtrl, startChannel, ...
    channelCount, data)
  handle1 = getappdata(0,'handle1');
  DataNow = data.Get(0);

  instantAiCtrl.Read(startChannel, channelCount, data);
  
  global Data % the datas are stored in the array Data[]
  Data = [Data,data.Get(0)];

  SampleRate = getappdata(handle1,'SampleRate');
  PointNum = getappdata(handle1,'PointNum');
  TimeNum = PointNum ./ SampleRate;
  Y = [TimeNum;DataNow];
  SignalSave = getappdata(handle1,'SignalSave');
  SignalSave = [SignalSave,Y];
  FileNum = getappdata(handle1,'FileNum');
  PlotAxes = getappdata(handle1,'PlotAxes');
  h = getappdata(handle1,'LineHandle');
  z = getappdata(handle1,'Zoom');
  XTmp = get(h,'XData');
  YTmp = get(h,'YData');
  if (length(XTmp)==1024*1024)
      XTmp = XTmp(1024*512:1024*1024);
      YTmp = YTmp(1024*512:1024*1024);
  end
  if (length(SignalSave)<20)
      set(h,'XData',[XTmp,TimeNum],'YData',[YTmp,DataNow]);
      set(PlotAxes,'Xlim',[TimeNum-10*z,TimeNum+1*z],'Ylim',[-15,15],'XTick',[round(TimeNum-10*z):z:round(TimeNum+1*z)]);
      setappdata(handle1,'SignalSave',SignalSave);
  else  
      set(h,'XData',[XTmp,TimeNum],'YData',[YTmp,DataNow]);
      set(PlotAxes,'Xlim',[TimeNum-10*z,TimeNum+1*z],'Ylim',[-15,15],'XTick',[round(TimeNum-10*z):z:round(TimeNum+1*z)]);
%       save(['Signal',int2str(FileNum)],'SignalSave');
      SignalSave = [];
      FileNum = FileNum+1;
      setappdata(handle1,'SignalSave',SignalSave);
      setappdata(handle1,'FileNum',FileNum);
  end
  PointNum = PointNum + 1;
  setappdata(handle1,'PointNum',PointNum);
end
