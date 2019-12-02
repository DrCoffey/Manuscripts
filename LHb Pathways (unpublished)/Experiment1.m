%% Code for: Chemogenetic inhibition of lateral habenula projections to the dorsal raphe nucleus reduces passive coping and perseverative reward seeking in rats
%% Kevin Coffey and Russell Marx (7/16/2019)
set(0,'defaultFigureVisible','On') %Sets Figures to invisible to prevent pop-up
close all;
clear all;

%% Directory For Data & Import
cd('.\hm4di FST data'); % Change to directory
fst_files=dir('*FST*'); %find FST data files

% Create column headers for the master array and blank master array
tmphead{1,1}='Animal ID';
tmphead{2,1}='#';
tmphead{1,2}='Trial Type';
tmphead{2,2}='Pre(0) Test(1)';
tmphead{1,3}='Treatment'; 
tmphead{2,3}='Veh(0) CNO(1)';
tmphead{1,4}='Projection'; 
tmphead{2,4}='Miss(0) DRn(1) VTA(2) RMTg(3)';
tmpdata=importdata(fst_files(1,1).name); % Import Data From File for column headers
ColHeaders=[tmphead tmpdata.textdata.Track0x2DArena10x2DSubject1(36:37,1:20)]; % Concatonate Trial Type Headers with Column Headers from Data File
All_Data=[];
clear tmphead tmpdata

c=1;
for i=1:length(fst_files) % Loop through FST data files and 
    tmpdata=importdata(fst_files(i,1).name); % Import Data From Tracking File
    
    %First Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2});
    DUMMY_ID{c,1}=tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2};
    DUMMY_ID{c,2}=c;
    animal_id(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=c; % Animal ID for Master Sheet
    trial_type(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=1; % Trial Type for Master Sheet
    trt=strcmp(tmpdata.textdata.Track0x2DArena10x2DSubject1{32,2}, 'CNO'); % Treatment for Master Sheet
    treatment(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=trt; % Treatment for Master Sheet
    reg=tmpdata.textdata.Track0x2DArena10x2DSubject1{33,2};
    AnimalName{c}=tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2};
    if strcmp(reg,'DRn')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=1; % Region Code
    elseif strcmp(reg,'VTA')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=2; % Region Code
    elseif strcmp(reg,'RMTg')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=3; % Region Code    
    elseif strcmp(reg,'Miss')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=0; % Region Code
    end
    Animal_Data=[animal_id trial_type treatment region tmpdata.data.Track0x2DArena10x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal C19= activity C18=Velocity
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id trial_type trt treatment reg region Animal_Data
    
    % Second Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena20x2DSubject1{34,2});
    DUMMY_ID{c,1}=tmpdata.textdata.Track0x2DArena20x2DSubject1{34,2};
    DUMMY_ID{c,2}=c;
    animal_id(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=c; % Animal ID for Master Sheet
    trial_type(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=1; % Trial Type for Master Sheet
    trt=strcmp(tmpdata.textdata.Track0x2DArena20x2DSubject1{32,2}, 'CNO'); % Treatment for Master Sheet
    treatment(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=trt; % Treatment for Master Sheet
    reg=tmpdata.textdata.Track0x2DArena20x2DSubject1{33,2};
    AnimalName{c}=tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2};
    if strcmp(reg,'DRn')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=1; % Region Code
    elseif strcmp(reg,'VTA')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=2; % Region Code
    elseif strcmp(reg,'RMTg')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=3; % Region Code    
    elseif strcmp(reg,'Miss')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=0; % Region Code
    end
    Animal_Data=[animal_id trial_type treatment region tmpdata.data.Track0x2DArena20x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id trial_type trt treatment reg region Animal_Data

end

% Smooth Nose Tracking data Calculate Distance and Velocity of Nose &
% Center Crossings
ColHeaders{2,16}='Crossings';
ColHeaders{2,15}='Vertical Distance';
animals=unique(All_Data(:,1));
for i=1:length(animals)
   disp(animals(i));
   tmp_track=All_Data((All_Data(:,1)==animals(i)),9:10); % Get Nose Tracking
   meanXY=nanmean(tmp_track); % Mean X and Y Position
   for j=1:length(tmp_track)-1
   X = tmp_track(j:j+1,:);
   tmp_Distance(j+1,1) = pdist(X,'euclidean'); %Calculate Distance Traveled 
   vert_Distance(j+1,1) = X(2,2)-X(1,2);
   end
   tmp_Distance(isnan(tmp_Distance))=nanmean(tmp_Distance); % Kill NAN
   tmp_Distance(tmp_Distance>.8)=nanmean(tmp_Distance); % Kill Outlier
   All_Data((All_Data(:,1)==animals(i)),17)=tmp_Distance; % Fill in Distance in Master Array
   tmp_Vel=tmp_Distance./.033; %Calculate Nose Velocity 
   All_Data((All_Data(:,1)==animals(i)),18)=tmp_Vel; % Fill in Velocity in Master Array
   for j=1:length(tmp_track)-1 % Calculates Center Crossings
       if tmp_track(j,1)<meanXY(1,1) & tmp_track(j+1,1)>meanXY(1,1)
          Cross(j+1,1)=1; 
       elseif tmp_track(j,1)>meanXY(1,1) & tmp_track(j+1,1)<meanXY(1,1)
          Cross(j+1,1)=1;
       else
          Cross(j+1,1)=0; 
       end
   end
   All_Data((All_Data(:,1)==animals(i)),16)=Cross; % Fill in Crossings in Master Array
   All_Data((All_Data(:,1)==animals(i)),15)=vert_Distance; % Fill in Vertical Distance in Master Array
   %cdfplot(fastsmooth(tmp_Distance,150, 3, 1)); 
   %hold on 
end
clear c Cross DUMMY_ID i j meanXY tmp_Distance tmp_track tmp_Vel tmpdata vert_Distance X

% Seperate Data into Groups
Miss_idx=All_Data(:,4)==0;
Miss_Data=All_Data(Miss_idx,:);
DRn_idx=All_Data(:,4)==1;
DRn_Data=All_Data(DRn_idx,:);
VTA_idx=All_Data(:,4)==2;
VTA_Data=All_Data(VTA_idx,:);
RMTg_idx=All_Data(:,4)==3;
RMTg_Data=All_Data(RMTg_idx,:);

%% Data Formatting For GRAMM Figures
% Inactivity VS Swimming Vs Climing
% Distance per 1 second
% CNO Animals
HM4Di_FST.Time=[];
HM4Di_FST.Treatment={};
HM4Di_FST.Behavior={};
HM4Di_FST.Region={};
HM4Di_FST2.Time=[];
HM4Di_FST2.Treatment={};
HM4Di_FST2.Session=[];
HM4Di_FST2.Region={};

for i=1:length(animals)
an_idx=All_Data(:,1)==animals(i);
trk=All_Data(an_idx,9:10);
tmp_dist=All_Data(an_idx,17);
vert_dist=All_Data(an_idx,15);
tmp_demos=All_Data(an_idx,1:4);

% Grab Animal Info
if tmp_demos(1,3)==0;
   treat={'Vehicle'};
else
    treat={'CNO'};
end

if tmp_demos(1,4)==0;
   reg={'Miss'};
elseif tmp_demos(1,4)==1;
    reg={'DRN'};
elseif tmp_demos(1,4)==2;
    reg={'VTA'};
elseif tmp_demos(1,4)==3;
    reg={'RMTg'};
end

c=0;
d=0;

for j=1:30:8970;
    c=c+1;
    DistPerSec(c,1)=sum(tmp_dist(j:j+30));
    VDistPerSec(c,1)=sum(vert_dist(j:j+30));
end
inact_idx=DistPerSec<=3;
inact_idx(300)=1;

for j=1:30:271;
    d=d+1;
    InactPer10Sec(1,d)=sum(inact_idx(j:j+29));
end

act_idx=DistPerSec>3;
vert_idx=abs(VDistPerSec)>=2;
vert_idx=vert_idx==1 & act_idx==1;

InactCount=sum(inact_idx);
SwimCount=sum(act_idx)-sum(vert_idx);
ClimbCount=sum(vert_idx);

tmpz.Time=[InactCount;SwimCount;ClimbCount];
tmpz.Treatment=[treat;treat;treat];
tmpz.Region=[reg;reg;reg];
tmpz.Behavior=[{'Immobility'};{'Swimming'};{'Climbing'}];

tmpzz.Time=InactPer10Sec(1,:)';
tmpzz.Treatment(1:10,1)=treat;
tmpzz.Region(1:10,1)=reg;
tmpzz.Session=(30:30:300)';

HM4Di_FST.Time=[HM4Di_FST.Time;tmpz.Time];
HM4Di_FST.Treatment=[HM4Di_FST.Treatment;tmpz.Treatment];
HM4Di_FST.Region=[HM4Di_FST.Region;tmpz.Region];
HM4Di_FST.Behavior=[HM4Di_FST.Behavior;tmpz.Behavior];

HM4Di_FST2.Time=[HM4Di_FST2.Time;tmpzz.Time];
HM4Di_FST2.Treatment=[HM4Di_FST2.Treatment;tmpzz.Treatment];
HM4Di_FST2.Session=[HM4Di_FST2.Session;tmpzz.Session];
HM4Di_FST2.Region=[HM4Di_FST2.Region;tmpzz.Region];


clear an_idx tmpzz tmpz InactPer10Sec
end

%% Plotting FST Behavior with GRAMM
HM4Di_FST.Behavior=categorical(HM4Di_FST.Behavior);
g=gramm('x',HM4Di_FST.Behavior,'y',HM4Di_FST.Time,'color',HM4Di_FST.Treatment,'subset',HM4Di_FST.Behavior=='Immobility');
g.facet_grid([],HM4Di_FST.Region);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'width',0,'type','sem','dodge',1);
g.axe_property('LineWidth',1.5,'FontSize',12);
g.axe_property('YLim',[0 150],'tickdir','out');
g.set_order_options('x',{'Immobility' 'Swimming' 'Climbing'},'color',{'Vehicle' 'CNO'},'column',{'DRN' 'VTA' 'RMTg' 'Miss'}); 
g.set_names('column',[],'x',[],'y','Time (s)','color',' ');
g.set_text_options('base_size',14,'interpreter','none');
g.set_color_options('map','lch','hue_range',[25 385]+180);
figure('Position',[1 1 750 300]);
g.draw();
for i=1:2:7
g.results.geom_jitter_handle(i).MarkerSize=4;
g.results.geom_jitter_handle(i).MarkerEdgeColor=[0.00,0.74,0.84];
g.results.geom_jitter_handle(i).MarkerFaceColor=[0.9,1,1];
end
for i=2:2:8
g.results.geom_jitter_handle(i).MarkerSize=4;
g.results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
g.results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
end

cd('..\raw figures');
g.export('file_name','HM4Di_FST','file_type','png');
close all

%% Set Up table for stats
stat=table(HM4Di_FST.Region,HM4Di_FST.Treatment,HM4Di_FST.Behavior,HM4Di_FST.Time);
stat.Var1=categorical(stat.Var1);
stat.Var2=categorical(stat.Var2);
stat=stat(stat.Var3=='Immobility',:);
stat.Properties.VariableNames = {'Region' 'Treatment' 'Behavior' 'Time'};
statarray = grpstats(stat,{'Region','Treatment'},{'mean','sem'},'DataVars','Time');

%% Stats Figure 1a-e
lme2 = fitlme(stat,'Time ~ Region*Treatment','DummyVarCoding','effects')
lmeAll=anova(lme2);
lmeDRN = anova(fitlme(stat(stat.Region=='DRN',:),'Time ~ Treatment','DummyVarCoding','effects'));
lmeVTA = anova(fitlme(stat(stat.Region=='VTA',:),'Time ~ Treatment','DummyVarCoding','effects'));
lmeRMTG = anova(fitlme(stat(stat.Region=='RMTg',:),'Time ~ Treatment','DummyVarCoding','effects'));
lmeMiss = anova(fitlme(stat(stat.Region=='Miss',:),'Time ~ Treatment','DummyVarCoding','effects'));

cd('..\');
% Sample size power analysis for review.
mD=mean(stat{stat.Region=='DRN' & stat.Treatment=='Vehicle',4});
sD=std(stat{stat.Region=='DRN' & stat.Treatment=='Vehicle',4});
mDCNO=mean(stat{stat.Region=='DRN' & stat.Treatment=='CNO',4});
nDRN = sampsizepwr('t',[mD sD],mDCNO,.9,[]);

mR=mean(stat{stat.Region=='RMTg' & stat.Treatment=='Vehicle',4});
sR=std(stat{stat.Region=='RTMg' & stat.Treatment=='Vehicle',4});
mRCNO=mean(stat{stat.Region=='RMTg' & stat.Treatment=='CNO',4});
nRMTG = sampsizepwr('t',[mD sD],mDCNO,.9,[]);

% Effect Size
dDRN = computeCohen_d(stat{stat.Region=='DRN' & stat.Treatment=='Vehicle',4},stat{stat.Region=='DRN' & stat.Treatment=='CNO',4}, 'independent');
dRMTG = computeCohen_d(stat{stat.Region=='RMTg' & stat.Treatment=='Vehicle',4},stat{stat.Region=='RMTg' & stat.Treatment=='CNO',4}, 'independent');
dVTA = computeCohen_d(stat{stat.Region=='VTA' & stat.Treatment=='Vehicle',4},stat{stat.Region=='VTA' & stat.Treatment=='CNO',4}, 'independent');
dMiss = computeCohen_d(stat{stat.Region=='Miss' & stat.Treatment=='Vehicle',4},stat{stat.Region=='Miss' & stat.Treatment=='CNO',4}, 'independent');

cd('.\stats');
save('Fig2abcd','lmeDRN','dDRN','lmeVTA','dVTA','lmeRMTG','dRMTG','lmeMiss','dMiss','lmeAll','statarray');
close all
cd('..\')

% Plotting FST Behavior with GRAMM
g=gramm('x',HM4Di_FST2.Session,'y',HM4Di_FST2.Time,'color',HM4Di_FST2.Treatment);
g.facet_grid([],HM4Di_FST2.Region);
g.set_stat_options('alpha',.325);
g.stat_smooth('geom','area');
g.axe_property('YLim',[0 17],'tickdir','out','LineWidth',1.5,'FontSize',12);
%g.stat_summary('geom','area','type','sem');
g.set_order_options('color',{'Vehicle' 'CNO'},'column',{'DRN' 'VTA' 'RMTg' 'Miss'}); 
g.set_names('column',[],'x','Session Time','y','Immobility Time (s)','lightness',' ');
g.set_text_options('base_size',14,'interpreter','none');
g.set_color_options('map','lch','hue_range',[25 385]+180);

figure('Position',[1 1 750 300]);
g.draw();
cd('.\raw figures');
g.export('file_name','HM4Di_FST_Time','file_type','png');
close all

%% FOR HM3Dq

%% Directory For Data & Import
cd('..\hm3dq FST data'); % Change to directory
fst_files=dir('*FST*'); %find FST data files

% Create column headers for the master array and blank master array
tmphead{1,1}='Animal ID';
tmphead{2,1}='#';
tmphead{1,2}='Trial Type';
tmphead{2,2}='Pre(0) Test(1)';
tmphead{1,3}='Treatment'; 
tmphead{2,3}='Veh(0) CNO(1)';
tmphead{1,4}='Projection'; 
tmphead{2,4}='Miss(0) DRn(1) VTA(2) RMTg(3)';
tmpdata=importdata(fst_files(1,1).name); % Import Data From File for column headers
ColHeaders=[tmphead tmpdata.textdata.Track0x2DArena10x2DSubject1(36:37,1:20)]; % Concatonate Trial Type Headers with Column Headers from Data File
All_Data=[];
clear tmphead tmpdata

c=1;
for i=1:length(fst_files) % Loop through FST data files and 
    tmpdata=importdata(fst_files(i,1).name); % Import Data From Tracking File
    
    %First Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2});
    DUMMY_ID{c,1}=tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2};
    DUMMY_ID{c,2}=c;
    animal_id(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=c; % Animal ID for Master Sheet
    trial_type(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=1; % Trial Type for Master Sheet
    trt=strcmp(tmpdata.textdata.Track0x2DArena10x2DSubject1{32,2}, 'CNO'); % Treatment for Master Sheet
    treatment(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=trt; % Treatment for Master Sheet
    reg=tmpdata.textdata.Track0x2DArena10x2DSubject1{33,2};
    AnimalName{c}=tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2};
    if strcmp(reg,'DRn')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=1; % Region Code
    elseif strcmp(reg,'VTA')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=2; % Region Code
    elseif strcmp(reg,'RMTg')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=3; % Region Code    
    elseif strcmp(reg,'Miss')
    region(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=0; % Region Code
    end
    Animal_Data=[animal_id trial_type treatment region tmpdata.data.Track0x2DArena10x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal C19= activity C18=Velocity
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id trial_type trt treatment reg region Animal_Data
    
    % Second Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena20x2DSubject1{34,2});
    DUMMY_ID{c,1}=tmpdata.textdata.Track0x2DArena20x2DSubject1{34,2};
    DUMMY_ID{c,2}=c;
    animal_id(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=c; % Animal ID for Master Sheet
    trial_type(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=1; % Trial Type for Master Sheet
    trt=strcmp(tmpdata.textdata.Track0x2DArena20x2DSubject1{32,2}, 'CNO'); % Treatment for Master Sheet
    treatment(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=trt; % Treatment for Master Sheet
    reg=tmpdata.textdata.Track0x2DArena20x2DSubject1{33,2};
    AnimalName{c}=tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2};
    if strcmp(reg,'DRn')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=1; % Region Code
    elseif strcmp(reg,'VTA')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=2; % Region Code
    elseif strcmp(reg,'RMTg')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=3; % Region Code    
    elseif strcmp(reg,'Miss')
    region(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=0; % Region Code
    end
    Animal_Data=[animal_id trial_type treatment region tmpdata.data.Track0x2DArena20x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id trial_type trt treatment reg region Animal_Data

end

% Smooth Nose Tracking data Calculate Distance and Velocity of Nose &
% Center Crossings
ColHeaders{2,16}='Crossings';
ColHeaders{2,15}='Vertical Distance';
animals=unique(All_Data(:,1));
for i=1:length(animals)
   disp(animals(i));
   tmp_track=All_Data((All_Data(:,1)==animals(i)),9:10); % Get Nose Tracking
   meanXY=nanmean(tmp_track); % Mean X and Y Position
   for j=1:length(tmp_track)-1
   X = tmp_track(j:j+1,:);
   tmp_Distance(j+1,1) = pdist(X,'euclidean'); %Calculate Distance Traveled 
   vert_Distance(j+1,1) = X(2,2)-X(1,2);
   end
   tmp_Distance(isnan(tmp_Distance))=nanmean(tmp_Distance); % Kill NAN
   tmp_Distance(tmp_Distance>.8)=nanmean(tmp_Distance); % Kill Outlier
   All_Data((All_Data(:,1)==animals(i)),17)=tmp_Distance; % Fill in Distance in Master Array
   tmp_Vel=tmp_Distance./.033; %Calculate Nose Velocity 
   All_Data((All_Data(:,1)==animals(i)),18)=tmp_Vel; % Fill in Velocity in Master Array
   for j=1:length(tmp_track)-1 % Calculates Center Crossings
       if tmp_track(j,1)<meanXY(1,1) & tmp_track(j+1,1)>meanXY(1,1)
          Cross(j+1,1)=1; 
       elseif tmp_track(j,1)>meanXY(1,1) & tmp_track(j+1,1)<meanXY(1,1)
          Cross(j+1,1)=1;
       else
          Cross(j+1,1)=0; 
       end
   end
   All_Data((All_Data(:,1)==animals(i)),16)=Cross; % Fill in Crossings in Master Array
   All_Data((All_Data(:,1)==animals(i)),15)=vert_Distance; % Fill in Vertical Distance in Master Array
   %cdfplot(fastsmooth(tmp_Distance,150, 3, 1)); 
   %hold on 
end
clear c Cross DUMMY_ID i j meanXY tmp_Distance tmp_track tmp_Vel tmpdata vert_Distance X

% Seperate Data into Groups
Miss_idx=All_Data(:,4)==0;
Miss_Data=All_Data(Miss_idx,:);
DRn_idx=All_Data(:,4)==1;
DRn_Data=All_Data(DRn_idx,:);
VTA_idx=All_Data(:,4)==2;
VTA_Data=All_Data(VTA_idx,:);
RMTg_idx=All_Data(:,4)==3;
RMTg_Data=All_Data(RMTg_idx,:);

%% Data Formatting For GRAMM Figures

% Inactivity VS Swimming Vs Climing
% Distance per 1 second
% CNO Animals
HM4Di_FST.Time=[];
HM4Di_FST.Treatment={};
HM4Di_FST.Behavior={};
HM4Di_FST.Region={};
HM4Di_FST2.Time=[];
HM4Di_FST2.Treatment={};
HM4Di_FST2.Session=[];
HM4Di_FST2.Region={};

for i=1:length(animals)
an_idx=All_Data(:,1)==animals(i);
trk=All_Data(an_idx,9:10);
tmp_dist=All_Data(an_idx,17);
vert_dist=All_Data(an_idx,15);
tmp_demos=All_Data(an_idx,1:4);

% Grab Animal Info
if tmp_demos(1,3)==0;
   treat={'Vehicle'};
else
    treat={'CNO'};
end

if tmp_demos(1,4)==0;
   reg={'Miss'};
elseif tmp_demos(1,4)==1;
    reg={'DRN'};
elseif tmp_demos(1,4)==2;
    reg={'VTA'};
elseif tmp_demos(1,4)==3;
    reg={'RMTg'};
end

c=0;
d=0;

for j=1:30:8970;
    c=c+1;
    DistPerSec(c,1)=sum(tmp_dist(j:j+30));
    VDistPerSec(c,1)=sum(vert_dist(j:j+30));
end
inact_idx=DistPerSec<=3;
inact_idx(300)=1;

for j=1:30:271;
    d=d+1;
    InactPer10Sec(1,d)=sum(inact_idx(j:j+29));
end

act_idx=DistPerSec>3;
vert_idx=abs(VDistPerSec)>=2;
vert_idx=vert_idx==1 & act_idx==1;

InactCount=sum(inact_idx);
SwimCount=sum(act_idx)-sum(vert_idx);
ClimbCount=sum(vert_idx);

tmpz.Time=[InactCount;SwimCount;ClimbCount];
tmpz.Treatment=[treat;treat;treat];
tmpz.Region=[reg;reg;reg];
tmpz.Behavior=[{'Immobility'};{'Swimming'};{'Climbing'}];

tmpzz.Time=InactPer10Sec(1,:)';
tmpzz.Treatment(1:10,1)=treat;
tmpzz.Region(1:10,1)=reg;
tmpzz.Session=(30:30:300)';

HM4Di_FST.Time=[HM4Di_FST.Time;tmpz.Time];
HM4Di_FST.Treatment=[HM4Di_FST.Treatment;tmpz.Treatment];
HM4Di_FST.Region=[HM4Di_FST.Region;tmpz.Region];
HM4Di_FST.Behavior=[HM4Di_FST.Behavior;tmpz.Behavior];

HM4Di_FST2.Time=[HM4Di_FST2.Time;tmpzz.Time];
HM4Di_FST2.Treatment=[HM4Di_FST2.Treatment;tmpzz.Treatment];
HM4Di_FST2.Session=[HM4Di_FST2.Session;tmpzz.Session];
HM4Di_FST2.Region=[HM4Di_FST2.Region;tmpzz.Region];


clear an_idx tmpzz tmpz InactPer10Sec
end

% Plotting FST Behavior with GRAMM
HM4Di_FST.Behavior=categorical(HM4Di_FST.Behavior);
g=gramm('x',HM4Di_FST.Behavior,'y',HM4Di_FST.Time,'color',HM4Di_FST.Treatment,'subset',HM4Di_FST.Behavior=='Immobility');
g.facet_grid([],HM4Di_FST.Region);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1);
g.stat_summary('geom',{'black_errorbar'},'width',0,'type','sem','dodge',1);
g.axe_property('LineWidth',1.5,'FontSize',12);
g.axe_property('YLim',[0 125],'tickdir','out');
g.set_order_options('x',{'Immobility' 'Swimming' 'Climbing'},'color',{'Vehicle' 'CNO'},'column',{'DRN' 'VTA' 'RMTg' 'Miss'}); 
g.set_names('column',[],'x',[],'y','Time (s)','color',' ');
g.set_text_options('base_size',14,'interpreter','none');
g.set_color_options('map','lch','hue_range',[0 350]);

figure('Position',[1 1 425 300]);
g.draw();

for i=1:2:3
g.results.geom_jitter_handle(i).MarkerSize=4;
g.results.geom_jitter_handle(i).MarkerEdgeColor=[1,0.335223870874423,0.630060848664357];
g.results.geom_jitter_handle(i).MarkerFaceColor=[1,.9,.9];
end
for i=2:2:4
g.results.geom_jitter_handle(i).MarkerSize=4;
g.results.geom_jitter_handle(i).MarkerEdgeColor=[0,0.735174873139987,0.564534786031040];
g.results.geom_jitter_handle(i).MarkerFaceColor=[.9,1,.9];
end

cd('..\raw figures');
g.export('file_name','HM3dq_FST','file_type','png');
close all

%% Set Up table for stats
stat=table(HM4Di_FST.Region,HM4Di_FST.Treatment,HM4Di_FST.Behavior,HM4Di_FST.Time);
stat.Var1=categorical(stat.Var1);
stat.Var2=categorical(stat.Var2);
stat=stat(stat.Var3=='Immobility',:);
stat.Properties.VariableNames = {'Region' 'Treatment' 'Behavior' 'Time'};

cd('..\');
dDRNq = computeCohen_d(stat{stat.Region=='DRN' & stat.Treatment=='Vehicle',4},stat{stat.Region=='DRN' & stat.Treatment=='CNO',4}, 'independent');

cd('.\stats');
% Effect Size
lmeDRNq = anova(fitlme(stat(stat.Region=='DRN',:),'Time ~ Treatment','DummyVarCoding','effects'));
save('Fig5a','lmeDRNq','dDRNq');
close all

% Plotting FST Behavior with GRAMM
g=gramm('x',HM4Di_FST2.Session,'y',HM4Di_FST2.Time,'color',HM4Di_FST2.Treatment);
g.facet_grid([],HM4Di_FST2.Region);
g.set_stat_options('alpha',.325);
g.stat_smooth('geom','area');
g.axe_property('YLim',[0 17],'tickdir','out','LineWidth',1.5,'FontSize',12);
%g.stat_summary('geom','area','type','sem');
g.set_order_options('color',{'Vehicle' 'CNO'},'column',{'DRN' 'VTA' 'RMTg' 'Miss'}); 
g.set_names('column',[],'x','Session Time','y','Immobility Time (s)','lightness',' ');
g.set_text_options('base_size',14,'interpreter','none');
g.set_color_options('map','lch','hue_range',[0 350]);

figure('Position',[1 1 450 300]);
g.draw();
cd('..\raw figures');
g.export('file_name','HM3dq_FST_Time','file_type','png');
close all
