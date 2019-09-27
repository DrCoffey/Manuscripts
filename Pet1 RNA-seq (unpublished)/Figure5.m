

FigureFolder = 'Z:\Neumaier Lab\Pet1 RNAseq\SAFit2\Round 2\Sucrose Preference\Safit Sucrose';
cd(FigureFolder);

% Safit
Safit = [{'101455'} {'101530'} {'101546'} {'101567'} {'101452'} {'101526'} {'101547'} {'101565'}];

%% Get Lickometer Data
files = [];
folder= 'Z:\Neumaier Lab\Pet1 RNAseq\SAFit2\Round 2\Sucrose Preference\Safit Sucrose';
files = [files; dir([folder '\*.csv'])];

lickometer = get_licker_data(files,Safit);
lt=lickometer;


%% Gramm Plotting
% Sucrose Licks
sa = grpstats(lickometer,{'ratID' 'treatment' 'condition'},{'mean','sum'},'DataVars',{'S' 'H'});

figure('Position',[100 100 400 400]);
g=gramm('x',sa.condition,'y',sa.sum_S,'color',sa.treatment);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g.set_order_options('color',[2 1]);
g.set_names('y',{'Sucrose Licks'},'x','');
g.axe_property('YLim',[-1 6000],'LineWidth',1.5,'FontSize',12);
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.draw

xticklabels(g.facet_axes_handles,{'Pre Stress' 'Post Stress'});
g.export('file_name','Sucrose','file_type','png');


a=sa.sum_S(sa.treatment=='Vehicle' & sa.condition=='E');
b=sa.sum_S(sa.treatment=='Vehicle' & sa.condition=='T');
[h,p,ci,stats] = ttest(b,a);
save('Stats_fig6a_Veh','h','p','ci','stats')


a=sa.sum_S(sa.treatment=='Safit2' & sa.condition=='E');
b=sa.sum_S(sa.treatment=='Safit2' & sa.condition=='T');
[h,p,ci,stats] = ttest(b,a)
save('Stats_fig6a_Safit','h','p','ci','stats')


% Water Licks
figure('Position',[100 100 400 400]);
g=gramm('x',sa.condition,'y',sa.sum_H,'color',sa.treatment);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g.set_order_options('color',[2 1]);
g.set_names('y',{'Water Licks'},'x','');
g.axe_property('YLim',[-1 600],'LineWidth',1.5,'FontSize',12);
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.draw

xticklabels(g.facet_axes_handles,{'Pre Stress' 'Post Stress'});
g.export('file_name','Water','file_type','png');

a=sa.sum_H(sa.treatment=='Vehicle' & sa.condition=='E');
b=sa.sum_H(sa.treatment=='Vehicle' & sa.condition=='T');
[h,p,ci,stats] = ttest(b,a)
save('Stats_fig6b_Veh','h','p','ci','stats')

a=sa.sum_H(sa.treatment=='Safit2' & sa.condition=='E');
b=sa.sum_H(sa.treatment=='Safit2' & sa.condition=='T');
[h,p,ci,stats] = ttest(b,a)
save('Stats_fig6b_Safit','h','p','ci','stats')

% Over time
figure('Position',[100 100 400 400]);
g=gramm('x',lt.IntervalNumber,'y',lt.S,'color',lt.treatment,'subset', lt.condition=='T');
g.stat_smooth();
g.set_order_options('color',[2 1]);
g.axe_property('YLim',[0 3.5],'LineWidth',1.5,'FontSize',12);
g.set_names('y',{'Sucrose Licks'},'x','Time (m)');
g.draw;
xticklabels({'0' '40' '80' '120' '160'});
g.export('file_name','SucroseOverTime','file_type','png');


%% 
sae=sa(sa.condition=='E',:);
sat=sa(sa.condition=='T',:);

sat.Change=(sat.sum_S-sae.sum_S);
% Sucrose Licks
figure('Position',[100 100 400 400]);
g=gramm('x',sat.treatment,'y',sat.Change,'color',sat.treatment);
%g.stat_summary('geom',{'bar','black_errorbar'});
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g.set_order_options('color',{'Vehicle' 'Safit2'},'x',{'Vehicle' 'Safit2'});
g.set_names('y',{'Change in Sucrose Licks After Stress'},'x','');
g.axe_property('LineWidth',1.5,'FontSize',12);
g.set_color_options('map','lch','hue_range',[25 385]+180);

g.draw

g.export('file_name','Sucrose Change','file_type','png');

a=sat.Change(sat.treatment=='Vehicle');
b=sat.Change(sat.treatment=='Safit2');
[h,p,ci,stats] = ttest2(b,a)
save('Stats_fig6c','h','p','ci','stats')

function [output] = get_licker_data(files,misses)
% Created by Russell Marx, September 2017
%% Reads data from Lafayette saccharin preferece chambers, ouputs a table with summarized results
%     Place raw .csv data files into a folder. The folder must not contain other .csv files
%     Data files must be named as follows:
%       G#W#Condition
%       e.g., G1W4P2, indicates group 1, wave 4, pretest 2.
%       group and wave numbers must be single digits.
%       only the last character of condition is read
%% Counter / Animal ID must be in the following format:;
%       Ri4_H
%       region = R
%       ID = 4
%       Licker = S, for saccharin
if nargin == 1
    misses = ' ';
end

%% Open directory
AllData = table();

for i = 1:size(files,1)
    
    file = files(i).name;
    disp(file)
    
    
    [numbers, strings] = xlsread([files(i).folder '\' file]); %create variables with numbers and strings
    
    
    %% Get Names
    allnames = strings(16,2:end); % location in csv where names are stored
    allnames = strtrim(allnames); % remove spaces
    
    minute = numbers(4:4:end,1:length(allnames)); %licks at each minute
    
    for k = 1:length(allnames)
        if ~(isempty(allnames{k}))
            name = allnames{k};
            [~, index] = regexp(name,'_*','Match');
            
            IntervalData = minute(:,k);
            ratID = name(1:index-1);
            %ratID = name(1:2);

            lickertype = name(end);
            
%             switch name(1)
%                 case 'R'
%                     region = 'RMTg';
%                 case 'D'
%                     region = 'DRN';
%                 case 'V'
%                     region = 'VTA';
%                 otherwise
%                     region = 'Error';
%             end
%             
            
            
            if ismember(ratID,misses)
                treatment = 'Safit2';
            else
                treatment = 'Vehicle';
            end
            
            condition = file(2);
            
            
            
            
            condition = repmat(categorical({condition}),length(IntervalData),1);
            treatment = repmat(categorical({treatment}),length(IntervalData),1);
            ratID = repmat(categorical({ratID}),length(IntervalData),1);
            lickertype = repmat(categorical({lickertype}),length(IntervalData),1);
            IntervalNumber = (1:length(minute(:,k))).';
            
            T = table(ratID,treatment,condition,IntervalNumber,lickertype,IntervalData,'VariableNames',{'ratID' 'treatment' 'condition' 'IntervalNumber' 'lickertype' 'Licks'});
            AllData = [AllData; T];
        end
    end
end
output = unstack(AllData,'Licks','lickertype');
end















