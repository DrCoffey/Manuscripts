% Sets Directory For Data & Figures
directory=uigetdir('Z:\Neumaier Lab\Pet1 RNAseq\Figure Creation Folders\Sex Differences Figure'); % Raw data
fig_fold='Z:\Neumaier Lab\Pet1 RNAseq\Figure Creation Folders\Sex Differences Figure'; % Figure folder
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
f1=figure('color','w','position',[100 100 700 600]);
ha = tight_subplot(2,2,[.075 .075],[.12 .12],[.12 .12]) ;

for l=1:4
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
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),8,tmp.data(idx,6),'filled','o');

% scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),15,tmp.data(idx,6),'filled','v');
% %[Spectrum] = Spectromizer(256)

colormap(flipud(cmap))
caxis([0 .1])
ylim([-2 4]);
xlim([-5 15]);
%h = colorbar;
%set(get(h,'title'),'string','(FDR)');
% Create ylabel

if l==1
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'})
ylabel('log_2(Fold Change)');
text(-4,4,'Stressed Input','FontSize',12)
% Create xlabel
%xlabel('log2(Mean TPM)','FontWeight','bold');
end


if l==2
text(-4,4,'Stressed IP','FontSize',12)
end

if l==3
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'});
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
ylabel('log_2(Fold Change)');
% Create xlabel
xlabel('log_2(TPM)');
text(-4,4,'Unstressed Input','FontSize',12)

end

if l==4
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
text(-4,4,'Unstressed IP','FontSize',12)
end

clear G1_name G2_name
end
pngFileName = 'Sex DifferentialExpression.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting colorbar Expression 
f2=figure('color','w','position',[100 100 300 800]);
set(gca,'FontSize',16,'FontWeight','bold','LineWidth',2,'TickDir','out');
h = colorbar;
colormap(flipud(jet))
set(get(h,'title'),'string','(FDR)');
pngFileName = 'Colorbar.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

