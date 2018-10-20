% 	This script will read data avaiable from arduino on serial port and will segregate it into 3 values 
%	i.e. Yaw, Pitch, Roll. This values then will be used to plot a real time graph. Warning will be issued
%	if vibrartions in any of the direction exceeds given threshold value.
clear all;
close all;
Fig = figure('Position',[5 9 800 1014],'ToolBar','none');
Ax = axes('Position',[0.06 .1 0.88 .8]);grid;hold on;
title('MACHINE VIBRATIONS');
xlabel('Time (Sec)');
ylabel('Angles (Degrees)');


for k = 1:3
    H(k) = plot(0,0);
end 

% Open serial port on COM8 to read data; baudrate : 250000
s=serial('COM8','BaudRate',250000);
fopen(s);

Tmax = 60;Ts = 0.02; i = 1;ata = 0;t = 0;

% Start timer
tic 
T(i)=0;
FLAG_CASTING = false;
CubH = [];Angles=zeros(1,3);
Flag_Initializing = true;

% Wait for intialization of MPU6050 module
while(Flag_Initializing)

    while(strcmp(s.TransferStatus,'read'))
        pause(0.01);
    end  
    
    % Read data from serial port asynchronously
    readasync(s);
    sms = fscanf(s);
   
    if ~strcmp(sms(1:3),'ypr')
        fprintf(sms)
    else
        Flag_Initializing = false;
    end
end
  
% MPU is now intialized; read values and segragate them in Y, P and R 
while T(end) <= 5000
    T(end+1)=T(end)+1;
    sms='a';
    idx = [];
    Angles = [0];
    while isempty(idx) || numel(Angles)~=3
         sms = fscanf(s);
         l=length(sms)
 
% length of input message is used as condition if vibration exceeds the threshold	
 if(l>40)
  % Calling warning function to show warning popup
 issue_warning();
 break;
 else
        idx = find(sms=='r');
        if ~isempty(idx)
            idx = idx(end)+1;
	     % Read angles in array
            Angles = sscanf(sms(idx:end),'%f %f %f');
        end
 end
    
    end
    if(l>40)
        break;
    else
     % Plot Y, P and R on graph in realtime
     k = 1;        
    vY = get(H(k),'YData');vX = get(H(k),'XData');
    set(H(k),'YData',[vY,Angles(k)]);set(H(k),'XData',[vX,T(end)]); 

    k = 2;
    vY = get(H(k),'YData');vX = get(H(k),'XData');
    set(H(k),'YData',[vY,Angles(k)]);set(H(k),'XData',[vX,T(end)]); 

    k = 3;
    vY = get(H(k),'YData');vX = get(H(k),'XData');
    set(H(k),'YData',[vY,Angles(k)]);set(H(k),'XData',[vX,T(end)]); 
    % Refresh graph
    drawnow;
    end
   
end
fclose(s);
