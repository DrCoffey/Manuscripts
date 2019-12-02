function a = openfield_stats(RawData,misses)
%% Compute rat-level variables from open field tracks
RawData = RawData(any(RawData{:,18:23},2),:);
RawData = RawData(RawData.Elongation < .94,:);

a = table();

for id = unique(RawData.ID)'
idx = RawData.ID == id;
ID = unique(RawData.ID(idx));
region = unique(RawData.region(idx));
    if ismember(ID,misses)
        region = {'Miss'};
    end
    
treatment = unique(RawData.treatment(idx));

body_center = RawData.InZone0x28Center0x2FCenter0x2Dpoint0x29(idx);
nose_rearing = RawData.InZone0x28Rearing0x2FNose0x2Dpoint0x29(idx);
nose_edge = RawData.InZone0x28Edges0x2FNose0x2Dpoint0x29(idx);
nose_center = RawData.InZone0x28Center0x2FNose0x2Dpoint0x29(idx);
tim = RawData.RecordingTime(idx);


nose_time_rearing = nanmean(nose_rearing)*100;
nose_time_edge = nanmean(nose_edge)*100;
nose_time_center = nanmean(nose_center)*100;

%Smooth center crossings
crosses = body_center(1:end);
crosses = crosses(~isnan(crosses));
smoothedcrossings = movmean(crosses,30,'omitnan');
center_crosses = sum((smoothedcrossings(1:end-1) >= .4) .* (smoothedcrossings(2:end) < .4));

% smooth rearings
rearings = nose_rearing(1:end);
rearings = rearings(~isnan(rearings));
smoothedrearings = movmean(rearings,10,'omitnan');
rears = sum((smoothedrearings(1:end-1) >= .4) .* (smoothedrearings(2:end) < .4));

speed = nanmean(RawData.Velocity(idx));
distance = nansum(RawData.DistanceMoved(idx));
dist = vecnorm(RawData{idx,8:9}');


a = [a; table(ID, region, treatment,nose_time_rearing,nose_time_edge,nose_time_center,center_crosses,rears,speed,distance,{tim},{dist},...
    'variablenames',{'ratID' 'region' 'treatment' 'nose_time_rearing' 'nose_time_edge' 'nose_time_center' 'center_crosses' 'rears' 'speed' 'distance' 'time' 'dist'})];
end



