% Sets Directory For Data & Figures
directory=uigetdir('D:\Neumaier Lab\Pet1 RNAseq\Figure Creation Folders\For Combined'); % Raw data
fig_fold='D:\Neumaier Lab\Pet1 RNAseq\Figure Creation Folders\For Combined'; % Figure folder
cd(directory);
files=dir('*DESeq2*'); %find FST data files
%load('DRGenes.mat');


% Generate cmap
% lightness, chroma, hue range
lightness = [65, 65];
chroma = [75, 75];
hue = [205 385];

% colormap resolution
n = 100;
LHC = [
    linspace(lightness(1),lightness(2),n)
    linspace(chroma(1),chroma(2),n)
    linspace(hue(1),hue(2),n)
    ]';
cmap = pa_LCH2RGB(LHC);


% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 1000 600]);
ha = tight_subplot(2,3,[.05 .05],[.12 .12],[.12 .12]) ;

for l=1:6
tmp=importdata(files(l).name); % Import seq data
filename=strtok(files(l).name,'.')    
C = strsplit(filename,'_');
tmp.textdata=tmp.textdata(2:end,1);
% G1_name=C(2);
% G2_name=C(3);
% tmp.data(isnan(tmp.data(:,6)),6)=1;


axes(ha(l));
set(ha,'FontSize',12,'LineWidth',1,'TickDir','out');
hold on;
scatter(log2(tmp.data(:,1)),tmp.data(:,2),6,[.5 .5 .5],'filled','o');
idx=(tmp.data(:,6))<.20;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),12,tmp.data(idx,6),'filled','o');

colormap(flipud(cmap))
caxis([0 .2])
ylim([-1.5 1.5]);
xlim([-5 15]);

if l==1
yticks([-1 0 1 ])
yticklabels({'-1','0','1'})
ylabel('log_2(Fold Change)');
text(-4,1.5,'Male IP','FontSize',12)
% Create xlabel
%xlabel('log2(Mean TPM)','FontWeight','bold');
end

if l==2
    yticks([-1 0 1 ])
text(-4,1.5,'Female IP','FontSize',12)
end

if l==3
    yticks([-1 0 1 ])
text(-4,1.5,'All IP','FontSize',12)
end


if l==4
yticks([-1 0 1])
yticklabels({'-1','0','1'})
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
ylabel('log_2(Fold Change)');
% Create xlabel
xlabel('log_2(TPM)');
text(-4,1.5,'Male Input','FontSize',12)
end

if l==5
xticks([-5 0 5 10 15])
yticks([-1 0 1 ])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
text(-4,1.5,'Female Input','FontSize',12)
end

if l==6
xticks([-5 0 5 10 15])
yticks([-1 0 1 ])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
text(-4,1.5,'All Input','FontSize',12)
end

clear G1_name G2_name
end

pngFileName = 'Stress DifferentialExpression.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting colorbar Expression 
f2=figure('color','w','position',[100 100 300 600]);
set(gca,'FontSize',12,'LineWidth',1,'TickDir','out');
h = colorbar('Box','off');
caxis([0 .2]);
colormap(flipud(cmap))
set(get(h,'title'),'string','FDR');pngFileName = 'Colorbar.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure