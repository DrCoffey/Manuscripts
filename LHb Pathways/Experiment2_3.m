%% Make every figure related to aim 2
close all
clear all
FigureFolder = 'Z:\Neumaier Lab\LHb Grant\Aim 2\Figures\Newest Figures';

% Misses
misses = [{'Vi9'} {'Di7'} {'Di10'} {'Ri11'} {'Vi16'} {'Di11'} {'Di12'} {'Di13'} {'Di14'},...
    {'Dq5'} {'Dq8'} {'Dq9'} {'Dq13'}];

%% Get Lickometer Data
files = [];
folder= 'C:\Users\Kevin\Desktop\LHb Pathways\Saccharin_Preference';
files = [files; dir([folder '\*.csv'])];
lickometer = get_licker_data2(files,misses);
lickometer = lickometer(lickometer.S < 235,:); % exclude rows where counting up for whole interval
lickometer = lickometer(lickometer.H < 235,:); % exclude rows where counting up for whole interval
lickometer = lickometer(lickometer.ratID ~= 'Vi13',:); % Broken Lickometer Counter


%% Calculate Preference and Group
func = @(h,s,IntervalNumber) deal(sum(h),sum(s),sum(h>10),sum(s>10),{IntervalNumber},{s});
groupvars = {'ratID' 'condition' 'wave' 'region' 'treatment'};
inputvars = {'H' 'S' 'IntervalNumber'};
outputvars = {'H_licks' 'S_licks' 'H_licks_M' 'S_licks_M' 'xData' 'yData'};
t = rowfun(func,lickometer,'InputVariables',inputvars,'GroupingVariables',groupvars,'OutputVariableNames',outputvars,'SeparateInputs',1);
t.sacc_pref = t.S_licks ./ (t.S_licks + t.H_licks);
t.sacc_pref_M = t.S_licks_M ./ (t.S_licks_M + t.H_licks_M);
t = t(t.condition ~= 'RO1',:);
t.condition = removecats(t.condition);
t.condition = reordercats(t.condition,{'P1' 'P2' 'P3' 'P4' 'V' 'C' 'ROV' 'ROC'});
t.dreadd = categorical(contains(cellstr(t.ratID),'i'),[1 0],[{'hM4Di'} {'hM3Dq'}]);
t.RO = categorical(t.condition == 'ROV' | t.condition == 'ROC',[1 0],[{'Reward Omission'} {'Saccharin'}]);
t=t(t.GroupCount>115,:);

%% Get Open Field Data
DataFolder= 'C:\Users\Kevin\Desktop\LHb Pathways\Open_Field\G2\';
files = dir([DataFolder '\*.xlsx']);
DataFolder= 'C:\Users\Kevin\Desktop\LHb Pathways\Open_Field\G3\';
files = [files; dir([DataFolder '\*.xlsx'])];
DataFolder= 'C:\Users\Kevin\Desktop\LHb Pathways\Open_Field\G4\';
files = [files; dir([DataFolder '\*.xlsx'])];
RawData = get_openfield_data(files);
RawData.CenterDist = vecnorm([RawData.XCenter, RawData.YCenter],2,2);
RawData.ID = categorical(RawData.ID);
RawData.region = categorical(RawData.region);
RawData.treatment = categorical(RawData.treatment);
% Create Table
a = openfield_stats(RawData,misses);
a.dreadd = categorical(contains(cellstr(a.ratID),'i'),[1 0],[{'hM4Di'} {'hM3Dq'}]);
a{a.region == 'DRn',{'region'}} = categorical({'DRN'});

%% Make Figures

close all
folder = 'C:\Users\Kevin\Desktop\LHb Pathways\raw figures\';
saccplot2(a,t,'licks',folder)
saccplot2(a,t,'openfield',folder)
close all
