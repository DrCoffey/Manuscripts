
clear all
close all

path='Z:\Neumaier Lab\Pet1 RNAseq\WildType RNA Scope\Images';
files=dir(path);
figpath='Z:\Neumaier Lab\Pet1 RNAseq\WildType RNA Scope';
% Pixels per Square Millimeter = 600000
files=files(3:end,:);

for i=1:length(files)
disp(['Image: ' num2str(i)]);
tmp=strsplit(files(i).name,'-');

% Image Info
Sample(i)=tmp(1,1);
tmp=strsplit(tmp{1,2},'_');
Slide(i)=tmp(1,1);
Slice(i)=tmp(1,2);

% Image Read
img=imread(fullfile(path,files(i).name));

% DAPI Cell Segmentation
imgblue = img(:,:,3) ; % blue, nuclei only signal
background = imopen(imgblue,strel('disk',15));
imgblue = imgblue - background;
bw_blue = imbinarize(imgblue);
bw_blue = bwareaopen(bw_blue, 50);
cc_blue = bwconncomp(bw_blue, 8);

% Create Dapi Centroids & Remove centroids touching the border
radius = 30;
s = regionprops(cc_blue,'centroid');
centroids = cat(1, s.Centroid);
NotAtBorder = centroids(:,1) < size(img,2) - (radius + 1) &...
centroids(:,1) > radius + 1 &...
centroids(:,2) < size(img,1) - (radius + 1) &...
centroids(:,2) > radius + 1;
centroids = centroids(NotAtBorder,:);  
cell_radious(1:length(centroids),1)=30;

% % Show Cell Identification
% % figure;
% % imshow(imgblue)
% % hold on
% % plot(centroids(:,1),centroids(:,2), 'b*')
% % hold on
% % viscircles(centroids,cell_radious,'LineStyle','--','LineWidth',1);

% Red Segmentation
imgred = img(:,:,1) ; % red, neuron only signal
background = imopen(imgred,strel('disk',15));
imgred=imgred-background;
%imgred = imadjust(imgred);
imgred = imbinarize(imgred,.1);
%imgred = bwareaopen(imgred, 50);

% % Show Red Channel Segmentation
% % figure;
% % imshow(imgred);

% Green Channel Segmentation
imggreen = img(:,:,2);
background = imopen(imggreen,strel('disk',15));
imggreen=imggreen-background;
%imggreen = imadjust(imggreen);
imggreen = imbinarize(imggreen,.1);

% % Show Red Channel Segmentation
% % figure;
% % imshow(imggreen);

% Green & Red per Cell
SE = strel('disk',radius,0);
circle = find(SE.Neighborhood);
[I,J] = ind2sub(size(SE.Neighborhood),circle);
I = I - radius - 1;
J = J - radius - 1;
dist = sqrt(J.^2 + I.^2);
[dist,distIdx] = sort(dist,'ascend');
I = I(distIdx);
J = J(distIdx);
FEV_size = zeros(length(centroids),1);
FKBP5_Size = zeros(length(centroids),1);
FEV = zeros(length(centroids),length(I),'uint16');
FKBP5 = zeros(length(centroids),length(I),'uint16');

for j=1:length(centroids)
cellIndex = sub2ind(size(imgred),round(centroids(j,2)) + I,round(centroids(j,1)) + J);
FEV(j,:) = imgred(cellIndex);
FKBP5(j,:)= imggreen(cellIndex);
FEV_size(j) = sum(imgred(cellIndex));
FKBP5_Size(j)=sum(imggreen(cellIndex));
end

% Threshold Cells
RedCellThresh = 100;
GreenCellThresh = 100;
MergeCells=sum(FEV_size>RedCellThresh & FKBP5_Size>GreenCellThresh);
FKBP5Cells=sum(FKBP5_Size>GreenCellThresh & FEV_size<RedCellThresh);
FEVCells=sum(FEV_size>RedCellThresh & FKBP5_Size<GreenCellThresh);

% Final Numbers
PercentMergeCells(i,1)=MergeCells/(MergeCells+FEVCells);
FKBP5perFEVCell(i,1)=mean(FKBP5_Size(FEV_size>RedCellThresh));
FKBP5perOtherCell(i,1)=mean(FKBP5_Size(FEV_size<RedCellThresh));
FEVCellCounts(i,1)=(MergeCells+FEVCells);
FKBP5CellCounts(i,1)=FKBP5Cells;

% % Insert Circles
% I=insertShape(img,'circle',[centroids(FKBP5_Size>GreenCellThresh & FEV_size<RedCellThresh,:) cell_radious(FKBP5_Size>GreenCellThresh & FEV_size<RedCellThresh)],'Color','green','LineWidth',2);
% I=insertShape(I,'circle',[centroids(FEV_size>RedCellThresh & FKBP5_Size<GreenCellThresh,:) cell_radious(FEV_size>RedCellThresh & FKBP5_Size<GreenCellThresh)],'Color','red','LineWidth',2);
% I=insertShape(I,'circle',[centroids(FEV_size>RedCellThresh & FKBP5_Size>GreenCellThresh,:) cell_radious(FEV_size>RedCellThresh & FKBP5_Size>GreenCellThresh)],'Color','yellow','LineWidth',2);
% imwrite(I,fullfile(figpath,['Raw ' files(i).name]));

clear Final img imggreen imgred imgblue;
end

% Save Data Analysis
save('RNASCAOPE');
Sample=Sample';
Slide=Slide';
Slice=Slice';
MasterTable  = table(Sample,Slide,Slice,PercentMergeCells,FKBP5perFEVCell,FKBP5perOtherCell,FEVCellCounts,FKBP5CellCounts);
truth=readtable("Z:\Neumaier Lab\Pet1 RNAseq\WildType RNA Scope\Sample Truth Sheet.xlsx");
for i=1:height(MasterTable)
    IndexC = strfind(truth.WildTypeStressRNAScope3_13_2018, MasterTable.Sample(i));
    Index = find(not(cellfun('isempty', IndexC)));
    Animal(i,1)=truth.Var2(Index(1,1));
    Stress(i,1)=truth.Var3(Index(1,1));
end
Order=([1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3])';
MasterTable  = table(Sample,Slide,Slice,PercentMergeCells,FKBP5perFEVCell,FKBP5perOtherCell,FEVCellCounts,FKBP5CellCounts,Animal,Stress,Order);
writetable(MasterTable,fullfile(figpath,'FKBP5_Analysis.xlsx'));
MasterTable.Sample=categorical(MasterTable.Sample);

% Read Master Table
MasterTable=readtable("Z:\Neumaier Lab\Pet1 RNAseq\WildType RNA Scope\FKBP5_Analysis.xlsx");
sa = grpstats(MasterTable,{'Animal','Stress'},'mean','DataVars',{'PercentMergeCells','FKBP5perFEVCell','FKBP5perOtherCell'})
sa.Stress=categorical(sa.Stress);
MasterTable.Stress=categorical(MasterTable.Stress);
for i=1:height(sa);
if sa.Stress(i)=='FU' |  sa.Stress(i)=='MU'  
Stress1(i)=categorical({'US'});
else
Stress1(i)=categorical({'S'});    
end
if sa.Stress(i)=='FU' |  sa.Stress(i)=='FS'  
Sex(i)=categorical({'F'});
else
Sex(i)=categorical({'M'});    
end
end
sa.Stress1=(Stress1');
sa.Sex=Sex';
for i=1:height(MasterTable);
if MasterTable.Stress(i)=='FU' |  MasterTable.Stress(i)=='MU'  
Stress1(i)=categorical({'US'});
else
Stress1(i)=categorical({'S'});    
end
end
MasterTable.Stress1=(Stress1');

%% Final Plotting

% Fig 5c and 5d
g=gramm('x',sa.Stress1,'y',sa.mean_PercentMergeCells,'color',sa.Stress1);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);

figure('Position',[100 100 300 300]);
g.set_names('x','','y','% of Pet1 Cells w/ FKBP5');
g.axe_property('YLim',[0 1],'LineWidth',1.5,'FontSize',12,'TickDir','out');
g.set_order_options('x',{'US','S'});
g.draw();
g.export('file_name','Fig1c','file_type','png');

g=gramm('x',sa.Stress1,'y',sa.mean_FKBP5perFEVCell,'color',sa.Stress1);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);

figure('Position',[100 100 300 300]);
g.set_names('x','','y','FKBP5 Signal /Pet1 Cell');
g.axe_property('YLim',[0 600],'LineWidth',1.5,'FontSize',12,'TickDir','out');
g.set_order_options('x',{'US','S'});
g.draw();
g.export('file_name','Fig1d','file_type','png');

% Fig 5e
g=gramm('x',sa.Stress1,'y',sa.mean_FKBP5perOtherCell,'color',sa.Stress1);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);

figure('Position',[100 100 300 300]);
g.set_names('x','','y','FKBP5 Signal /FKBP5 Cell');
g.axe_property('YLim',[0 200],'LineWidth',1.5,'FontSize',12,'TickDir','out');
g.set_order_options('x',{'US','S'});
g.draw();
g.export('file_name','Fig1e','file_type','png');

% Fig 5f 
g=gramm('x',sa.Sex,'y',sa.mean_PercentMergeCells,'color',sa.Stress1);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);

figure('Position',[100 100 300 300]);
g.set_names('x','','y','% of Pet1 Cells w/ FKBP5');
g.axe_property('YLim',[0 1],'LineWidth',1.5,'FontSize',12,'TickDir','out');
g.set_order_options('x',{'F','M'},'color',{'US','S'});
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.draw();
g.export('file_name','Fig1f','file_type','png');

%fig 5g
g=gramm('x',sa.Sex,'y',sa.mean_FKBP5perFEVCell,'color',sa.Stress1);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);

figure('Position',[100 100 300 300]);
g.set_names('x','','y','FKBP5 Signal /Pet1 Cell');
g.axe_property('YLim',[0 600],'LineWidth',1.5,'FontSize',12,'TickDir','out');
g.set_order_options('x',{'F','M'},'color',{'US','S'});
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.draw();
g.export('file_name','Fig1g','file_type','png');

% Positional Effects Fig 5h
g=gramm('x',MasterTable.Order,'y',MasterTable.FKBP5perFEVCell,'color',MasterTable.Stress1);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);

figure('Position',[100 100 300 300]);
g.set_names('x','','y','FKBP5 Signal /Pet1 Cell');
g.axe_property('YLim',[0 800],'LineWidth',1.5,'FontSize',12,'TickDir','out');
g.set_order_options('x',{1 2 3},'color',{'US','S'});
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.draw();
g.export('file_name','Fig1h','file_type','png');



