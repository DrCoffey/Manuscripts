function output = get_openfield_data(fst_files)
output = [];

% folder=uigetdir('\\NEUMAIERDRIVE\LabPeople\Kevin\LHb Grant\Aim 2\Data\Open_Field', 'Choose Directory');

for i=1:length(fst_files) % Loop through FST data files and 
tmpdata=importdata([fst_files(i,1).folder '\' fst_files(i,1).name]); % Import Data From Tracking File
disp(fst_files(i,1).name)
ID = tmpdata.textdata{34,2};
treatment = tmpdata.textdata{33,2};
region = tmpdata.textdata{32,2};

grouping = table(repmat({ID},length(tmpdata.data(:,1:20)),1),...
    repmat({treatment},length(tmpdata.data(:,1:20)),1),...
    repmat({region},length(tmpdata.data(:,1:20)),1),...
    'VariableNames',{'ID' 'treatment' 'region'});

tempdata = array2table([tmpdata.data(:,1:20)],'VariableNames',genvarname(tmpdata.textdata(36,1:20)));
temptable = [grouping tempdata];
output = [output; temptable];
end