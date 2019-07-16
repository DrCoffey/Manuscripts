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
            lickertype = name(index+1:end);
            
            switch name(1)
                case 'R'
                    region = 'RMTg';
                case 'D'
                    region = 'DRN';
                case 'V'
                    region = 'VTA';
                otherwise
                    region = 'Error';
            end
            
            
            
            if ismember(ratID,misses)
                region = 'Miss';
            end
            
            condition = file(5:end-4);
            
            
            if strcmp(condition,'CV2')
                ratNum = regexp(ratID,'\d*','Match');
                ratNum = str2num(ratNum{:});
                if mod(ratNum,2)
                    condition = 'C';
                else
                    condition = 'V';
                end
            end
            if strcmp(condition,'VC1')
                ratNum = regexp(ratID,'\d*','Match');
                ratNum = str2num(ratNum{:});
                if mod(ratNum,2)
                    condition = 'V';
                else
                    condition = 'C';
                end
            end
            if strcmp(condition,'RO')
                ratNum = regexp(ratID,'\d*','Match');
                ratNum = str2num(ratNum{:});
                if mod(ratNum,2)
                    condition = 'ROV';
                else
                    condition = 'ROC';
                end
            end
            
            switch condition
                case 'ROV'
                    treatment = 'Veh';
                case 'ROC'
                    treatment = 'CNO';
                case 'V'
                    treatment = 'Veh';
                case 'C'
                    treatment = 'CNO';
                otherwise
                    treatment = 'None';
            end
            
            condition = repmat(categorical({condition}),length(IntervalData),1);
            region = repmat(categorical({region}),length(IntervalData),1);
            group = repmat(categorical({file(2)}),length(IntervalData),1);
            wave = repmat(categorical({file(4)}),length(IntervalData),1);
            ratID = repmat(categorical({ratID}),length(IntervalData),1);
            lickertype = repmat(categorical({lickertype}),length(IntervalData),1);
            IntervalNumber = (1:length(minute(:,k))).';
            Treatment = repmat(categorical({treatment}),length(IntervalData),1);
            
            T = table(ratID,region,condition,wave,IntervalNumber,lickertype,IntervalData,Treatment,'VariableNames',{'ratID' 'region' 'condition' 'wave' 'IntervalNumber' 'lickertype' 'Licks' 'treatment'});
            AllData = [AllData; T];
        end
    end
end
output = unstack(AllData,'Licks','lickertype');
end















