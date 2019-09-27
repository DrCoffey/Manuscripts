%%% Coded by Kevin Coffey for Forces Swim Analysis
set(0,'defaultFigureVisible','On') %Sets Figures to invisible to prevent pop-up
close all;
clear all;

%% Directory For Data & Import
D=uigetdir('Z:\Neumaier Lab\Pet1 RNAseq\Behavior All');
cd(D); % Change to directory
fst_files=dir('*Raw*'); %find FST data files

% Create column headers for the master array and blank master array
tmphead{1,1}='Animal ID';
tmphead{1,2}='Sex';
tmphead{1,3}='Swim Number';
tmphead{1,4}='Treatment';
tmpdata=importdata(fst_files(1,1).name); % Import Data From File for column headers
ColHeaders=[tmphead tmpdata.textdata.Track0x2DArena10x2DSubject1(37,1:19)]; % Concatonate Trial Type Headers with Column Headers from Data File
All_Data=[];
clear tmphead tmpdata

c=1;
for i=1:length(fst_files) % Loop through FST data files and 
    tmpdata=importdata(fst_files(i,1).name); % Import Data From Tracking File
    
    %First Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena10x2DSubject1{32,2});
    animal_id(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena10x2DSubject1{32,2}); % Animal ID for Master Sheet
    sex(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena10x2DSubject1{34,2},'Male'); % Sex for Master Sheet
    swim(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena10x2DSubject1{33,2}); % Swim Number
    treat(1:length(tmpdata.data.Track0x2DArena10x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena10x2DSubject1{35,2},'Nbni'); % Treatment
    Animal_Data=[animal_id sex swim treat tmpdata.data.Track0x2DArena10x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal C19= activity C18=Velocity
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id sex swim Animal_Data treat
    
    if length(fields(tmpdata.textdata))>1
    %Second Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena20x2DSubject1{32,2});
    animal_id(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena20x2DSubject1{32,2}); % Animal ID for Master Sheet
    sex(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena20x2DSubject1{34,2},'Male'); % Sex for Master Sheet
    swim(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena20x2DSubject1{33,2}); % Swim Number
    treat(1:length(tmpdata.data.Track0x2DArena20x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena20x2DSubject1{35,2},'Nbni'); % Treatment
    Animal_Data=[animal_id sex swim treat tmpdata.data.Track0x2DArena20x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal C19= activity C18=Velocity
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id sex swim Animal_Data treat
    end
    
    if length(fields(tmpdata.textdata))>2
    %Third Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena30x2DSubject1{32,2});
    animal_id(1:length(tmpdata.data.Track0x2DArena30x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena30x2DSubject1{32,2}); % Animal ID for Master Sheet
    sex(1:length(tmpdata.data.Track0x2DArena30x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena30x2DSubject1{34,2},'Male'); % Sex for Master Sheet
    swim(1:length(tmpdata.data.Track0x2DArena30x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena30x2DSubject1{33,2}); % Swim Number
    treat(1:length(tmpdata.data.Track0x2DArena30x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena30x2DSubject1{35,2},'Nbni'); % Treatment
    Animal_Data=[animal_id sex swim treat tmpdata.data.Track0x2DArena30x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal C19= activity C18=Velocity
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id sex swim Animal_Data treat
    end
    
    if length(fields(tmpdata.textdata))>3
    %Fourth Spreadsheet
    disp(tmpdata.textdata.Track0x2DArena40x2DSubject1{32,2});
    animal_id(1:length(tmpdata.data.Track0x2DArena40x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena40x2DSubject1{32,2}); % Animal ID for Master Sheet
    sex(1:length(tmpdata.data.Track0x2DArena40x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena40x2DSubject1{34,2},'Male'); % Sex for Master Sheet
    swim(1:length(tmpdata.data.Track0x2DArena40x2DSubject1),1)=str2num(tmpdata.textdata.Track0x2DArena40x2DSubject1{33,2}); % Swim Number
    treat(1:length(tmpdata.data.Track0x2DArena40x2DSubject1),1)=strcmp(tmpdata.textdata.Track0x2DArena40x2DSubject1{35,2},'Nbni'); % Treatment
    Animal_Data=[animal_id sex swim treat tmpdata.data.Track0x2DArena40x2DSubject1(:,1:19)]; % Data from the Currently Proccessing Animal C19= activity C18=Velocity
    All_Data=[All_Data
    Animal_Data]; % Concatonate the Master Array
    c=c+1;
    clear animal_id sex swim Animal_Data treat
    end
end

% Seperate Data into Groups
Animals=unique(All_Data(:,1));

% Distance Standardization
All_Data_Scaled=[];
for i=1:length(Animals)
an_idx=All_Data(:,1)==Animals(i);
tmpdata=All_Data(an_idx,:);
nose=tmpdata(tmpdata(:,3)==1,9:10);
if i==1
nose=nose(1000:6000,1:2);
xn=nose(isnan(nose(:,1))==0,1);
yn=nose(isnan(nose(:,2))==0,2);
[R,C,Xb]=ExactMinBoundCircle([xn yn]);
Radius(i)=R;
disp(i);    
Scaling=9/R;
tmpdata(:,17)=tmpdata(:,17)*Scaling;
elseif i==10
nose=nose(1000:6000,1:2);
xn=nose(isnan(nose(:,1))==0,1);
yn=nose(isnan(nose(:,2))==0,2);
[R,C,Xb]=ExactMinBoundCircle([xn yn]);
Radius(i)=R;
disp(i); 
Scaling=9/R;
tmpdata(:,17)=tmpdata(:,17)*Scaling;
else
nose=nose(50:6000,1:2);
xn=nose(isnan(nose(:,1))==0,1);
yn=nose(isnan(nose(:,2))==0,2);
[R,C,Xb]=ExactMinBoundCircle([xn yn]);
Radius(i)=R;
disp(i);
Scaling=9/R;
tmpdata(:,17)=tmpdata(:,17)*Scaling;
end
% figure('Color',[1 1 1],'Position',[0 0 600 600]);
% plot(nose(:,1),nose(:,2))
% hold on
th = 0:pi/50:2*pi;
xunit = R * cos(th) + C(1);
yunit = R * sin(th) + C(2);
h = plot(xunit, yunit);
Scaling=9/R;
All_Data_Scaled=[All_Data_Scaled
    tmpdata];
end

% All Distance Over Sessions
for i=1:length(Animals)
    an_idx=All_Data_Scaled(:,1)==Animals(i);
    Dist_An(i,1)=Animals(i);
    An_Data=All_Data_Scaled(an_idx,:);
    An_Sex(i,1)=An_Data(1,2);
    An_treat(i,1)=An_Data(1,4);
    for j=1:4
        day_idx=An_Data(:,3)==j;
        Dist_mean(i,j)=nansum(An_Data(day_idx,17));
    end
end

% Immobility Over Sessions
for i=1:length(Animals)
    an_idx=All_Data(:,1)==Animals(i);
    Dist_An(i,1)=Animals(i);
    An_Data=All_Data(an_idx,:);
    Dist_An(i,2)=An_Data(1,2);
    for j=1:4
        day_idx=An_Data(:,3)==j;
        tmp_dist=(An_Data(day_idx,17));
        c=0;
        for z=1800:30:8800;
        c=c+1;
        DistPerSec(c,1)=sum(tmp_dist(z:z+30));
        end
        inact_idx=DistPerSec<=2.5;
        Inactivity(i,j)=nansum(inact_idx);
    end
end


%% Lets Use Gramm 
Males=An_Sex==1;
Females=An_Sex==0;
nBNI=An_treat==1;
Veh=An_treat==0;

AnimalID=Dist_An(:,1);
AnimalID=[AnimalID;AnimalID;AnimalID;AnimalID];
Sex(Males,1)=categorical({'Male'});
Sex(Females,1)=categorical({'Female'});
Sex=[Sex;Sex;Sex;Sex];
Treatment(nBNI,1)=categorical({'nBNI'});
Treatment(Veh,1)=categorical({'Vehicle'});
Treatment=[Treatment;Treatment;Treatment;Treatment];
SwimNumber=[repmat(1,[1 40])';repmat(2,[1 40])';repmat(3,[1 40])';repmat(4,[1 40])'];
Inactivity=[Inactivity(:,1);Inactivity(:,2);Inactivity(:,3);Inactivity(:,4)];
Distance=[Dist_mean(:,1);Dist_mean(:,2);Dist_mean(:,3);Dist_mean(:,4)];

MasterTable=table(AnimalID,Sex,Treatment,SwimNumber,Inactivity,Distance);
VehTable=MasterTable(MasterTable.Treatment=='Vehicle',:);

g=gramm('x',MasterTable.SwimNumber,'y',MasterTable.Inactivity,'color',MasterTable.Sex,'subset',MasterTable.Treatment=='Vehicle');

g.stat_summary('type','sem','geom',{'point','errorbar'},'dodge',.25,'width',1);
%g.geom_point('dodge',.5);
g.set_point_options('base_size',6);
%These functions can be called on arrays of gramm objects
g.set_names('x','Swim Number','y','Immobility (s)','color','Sex');

% Draw!
figure('Position',[100 100 300 400]);
g.axe_property('xLim',[.75 4.25]);
g.axe_property('yLim',[0 215]);
g.draw();
export_fig('Immobility.png','-m3');


g=gramm('x',MasterTable.SwimNumber,'y',MasterTable.Distance,'color',MasterTable.Sex,'subset',MasterTable.Treatment=='Vehicle');

g.stat_summary('type','sem','geom',{'point','errorbar'},'dodge',.25,'width',1);
%g.geom_point('dodge',.5);
g.set_point_options('base_size',6);
%These functions can be called on arrays of gramm objects
g.set_names('x','Swim Number','y','Distance (cm)','color','Sex');

% Draw!
figure('Position',[100 100 300 400]);
g.axe_property('xLim',[.75 4.25]);
g.axe_property('yLim',[300 1500]);
g.draw();
export_fig('Distance.png','-m3');

%% Repeated Measures ANOVA & Contrasts

% lm = fitlme(VehTable,'Inactivity ~ Sex*SwimNumber + (SwimNumber|AnimalID)','DummyVarCoding','effects');
% DistanceANOVA = anova(lm,'DFMethod','satterthwaite');

t = unstack(VehTable,{'Distance' 'Inactivity'},'SwimNumber');
Meas = table([1 2 3 4]','VariableNames',{'Measurements'});
rm = fitrm(t,'Distance_x1-Distance_x4~Sex','WithinDesign',Meas);
DistanceANOVA = ranova(rm)
save('Stats_Fig1_Dist','DistanceANOVA')

Meas = table([1 2 3 4]','VariableNames',{'Measurements'});
rm = fitrm(t,'Inactivity_x1-Inactivity_x4~Sex','WithinDesign',Meas);
InactivityANOVA = ranova(rm)
save('Stats_Fig1_Immobility','InactivityANOVA')


%% Activity Heatmaps
for i=1:4
scaledpoints=[];    
D_idx=All_Data_Scaled(:,3)==i;
tmp= [All_Data_Scaled(D_idx,1) All_Data_Scaled(D_idx,9) All_Data_Scaled(D_idx,10)];
animals=unique(tmp(:,1));
for j=1:length(animals)
    dx=tmp(:,1)==animals(j) & ~isnan(tmp(:,2));
    tmp2=tmp(dx,2);
    tmp3=tmp(dx,3);
    tmp2=zscore(tmp2);
    tmp3=zscore(tmp3);
    scaledpoints=[scaledpoints;[tmp2 tmp3]];
end


[n,c]=hist3(scaledpoints,[100 100])
imagesc(c{1},c{2},(n))
colormap(cubehelix);
caxis([15 300]);
colorbar
export_fig(['Day ' num2str(i) ' Heatmap.png'], '-m5');
close all

end

%% Activity Line Drawings
for i=1:length(Animals)
an_idx=All_Data_Scaled(:,1)==Animals(i);
tmpdata=All_Data_Scaled(an_idx,:);
sex=tmpdata(1,2);
for j=1:4
nose=tmpdata(tmpdata(:,3)==j,9:10);
xn=nose(isnan(nose(:,1))==0,1);
yn=nose(isnan(nose(:,2))==0,2);

if sex==1
figure('Color',[1 1 1],'Position',[0 0 600 600]);
plot(xn,yn,'LineWidth',2,'Color',[0 0.447058826684952 0.74117648601532])
hold on
export_fig([num2str(i) '-' num2str(j) '-Track.png'], '-m5')
close all
else
figure('Color',[1 1 1],'Position',[0 0 600 600]);
plot(xn,yn,'LineWidth',2,'Color',[1 0.600000023841858 0.7843137383461])
hold on
export_fig([num2str(i) '-' num2str(j) '-Track.png'], '-m5')
close all
end

end

end













