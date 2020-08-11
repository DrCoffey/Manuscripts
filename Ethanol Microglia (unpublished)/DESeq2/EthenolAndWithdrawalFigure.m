% Sets Directory For Data & Figures
directory=uigetdir('Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\DESeq2'); % Raw data
fig_fold='Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\DESeq2\Figures'; % Figure folder
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
f1=figure('color','w','position',[100 100 900 300]);
ha = tight_subplot(1,3,[.075 .075],[.2 .1],[.075 .075]) ;

for l=1:3
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
idx=(tmp.data(:,6))<.05;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),8,tmp.data(idx,6),'filled','o');

% scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),15,tmp.data(idx,6),'filled','v');
% %[Spectrum] = Spectromizer(256)

colormap(flipud(cmap))
caxis([0 .05])
ylim([-4 4]);
xlim([-5 15]);
%h = colorbar;
%set(get(h,'title'),'string','(FDR)');
% Create ylabel

if l==1
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'})
ylabel('log_2(Fold Change)');
text(-4,4,'Air 0h vs Air 8h','FontSize',12)
% Create xlabel
xlabel('log2(Mean TPM)','FontWeight','bold');
end


if l==2
text(-4,4,'Ethanol 0h vs All Air','FontSize',12)
xlabel('log2(Mean TPM)','FontWeight','bold');

end

if l==3
text(-4,4,'Ethanol 8h vs Ethanol 0h','FontSize',12)
xlabel('log2(Mean TPM)','FontWeight','bold');

end

if l==1
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'});
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
ylabel('log_2(Fold Change)');
% Create xlabel
xlabel('log_2(TPM)');
%text(-4,4,'Naloxone Alone Input','FontSize',12)

end

if l==2
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
%text(-4,4,'Morphine Input','FontSize',12)
end

if l==3
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
%text(-4,4,'Withdrawal Input','FontSize',12)
end

% Create title
%title('Ribotag^+ IP vs Ribotag^- IP');
% Set the remaining axes properties

% % Top 5 Index and Bottom 5 Index
% T=find(tmp.data(idx,2)>0);
% t5idx=T(1:1:30);
% % B=find(tmp.data(idx,2)<0);
% % b5idx=B(1:1:10);
% 
% nandata=tmp.data(idx,:);
% nantext=tmp.textdata(idx,:);
% 
% for i=1:30
%    h3(i)=scatter(log2(nandata(t5idx(i),1)),nandata(t5idx(i),2),75,'^','LineWidth',2); 
% end
% legendflex(h3,nantext(t5idx,1),'anchor', [3 1], ...
%     'buffer', [100 0], ...
%     'ncol', 1, ...
%     'fontsize', 12, ...
%     'xscale', 0.8, ...
%     'box', 'off');

% pngFileName = strjoin([G1_name ' ' G2_name ' DifferentialExpression.png']); % Set the File name 
% fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
% export_fig(fullFileName, '-m5'); % Save the Figure
% close all
clear G1_name G2_name
end
pngFileName = 'Ethanol and Withdrawal Differential Expression.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 900 300]);
ha = tight_subplot(1,3,[.075 .075],[.2 .1],[.075 .075]) ;
files = files(6:8,:);
for l=1:3
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
idx=(tmp.data(:,6))<.05;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),8,tmp.data(idx,6),'filled','o');

% scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),15,tmp.data(idx,6),'filled','v');
% %[Spectrum] = Spectromizer(256)

colormap(flipud(cmap))
caxis([0 .05])
ylim([-4 4]);
xlim([-5 15]);
%h = colorbar;
%set(get(h,'title'),'string','(FDR)');
% Create ylabel

if l==1
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'})
ylabel('log_2(Fold Change)');
text(-4,4,'Air 0h vs Air 8h','FontSize',12)
% Create xlabel
xlabel('log2(Mean TPM)','FontWeight','bold');
end


if l==2
text(-4,4,'Ethanol 0h vs All Air','FontSize',12)
xlabel('log2(Mean TPM)','FontWeight','bold');

end

if l==3
text(-4,4,'Ethanol 8h vs Ethanol 0h','FontSize',12)
xlabel('log2(Mean TPM)','FontWeight','bold');

end

if l==1
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'});
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
ylabel('log_2(Fold Change)');
% Create xlabel
xlabel('log_2(TPM)');
%text(-4,4,'Naloxone Alone Input','FontSize',12)

end

if l==2
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
%text(-4,4,'Morphine Input','FontSize',12)
end

if l==3
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
%text(-4,4,'Withdrawal Input','FontSize',12)
end

% Create title
%title('Ribotag^+ IP vs Ribotag^- IP');
% Set the remaining axes properties

% % Top 5 Index and Bottom 5 Index
% T=find(tmp.data(idx,2)>0);
% t5idx=T(1:1:30);
% % B=find(tmp.data(idx,2)<0);
% % b5idx=B(1:1:10);
% 
% nandata=tmp.data(idx,:);
% nantext=tmp.textdata(idx,:);
% 
% for i=1:30
%    h3(i)=scatter(log2(nandata(t5idx(i),1)),nandata(t5idx(i),2),75,'^','LineWidth',2); 
% end
% legendflex(h3,nantext(t5idx,1),'anchor', [3 1], ...
%     'buffer', [100 0], ...
%     'ncol', 1, ...
%     'fontsize', 12, ...
%     'xscale', 0.8, ...
%     'box', 'off');

% pngFileName = strjoin([G1_name ' ' G2_name ' DifferentialExpression.png']); % Set the File name 
% fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
% export_fig(fullFileName, '-m5'); % Save the Figure
% close all
clear G1_name G2_name
end
pngFileName = 'Ethanol and Withdrawal Differential Expression Adjusted.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure
%% IP Morphine v Withdrawal
tmp1=importdata(files(2).name); % Import seq data
filename1=strtok(files(2).name,'.')    
C1 = strsplit(filename,'_');
tmp1.textdata=tmp1.textdata(2:end,1);
[a i]=sort(tmp1.textdata);

tmp2=importdata(files(3).name); % Import seq data
filename2=strtok(files(3).name,'.')    
C2 = strsplit(filename,'_');
tmp2.textdata=tmp2.textdata(2:end,1);
[b i2]=sort(tmp2.textdata);

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 450 400]);
scatter(tmp1.data(i,2),tmp2.data(i2,2),8,[.5 .5 .5],'filled','o');
set(gca,'FontSize',12,'LineWidth',1.5,'TickDir','out');

x=tmp1.data(i,2);
y=tmp2.data(i2,2);
c=mean([tmp1.data(i,6) tmp2.data(i2,6)]')';
idx=(c<.10 );
hold on;
scatter(x(idx),y(idx),8,c(idx),'filled','o');
ylabel('Withdrawal IP log_2(Fold Change)');
xlabel('Ethanol Escalation IP log_2(Fold Change)');
xlim([-4 4])
ylim([-4 4])
l=lsline;
colormap(flipud(cmap))
caxis([0 .1])

plot([-4 4],[0 0],'--k');
plot([0 0],[-4 4],'--k');
r_squared = corr(x(idx),y(idx))^2
text(-3.8,3.8,strcat("Sig. Gene R^2 = ",num2str(r_squared)))

r_squared = corr(tmp1.data(i,2),tmp2.data(i2,2))^2
% text(-3.8,3.4,strcat("All Gene R^2 = ",num2str(r_squared)))
l(2).Visible="off";

pngFileName = 'Ethenol v Withdrawal.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

colorbar;


%% for Input
tmp1=importdata(files(5).name); % Import seq data
filename1=strtok(files(5).name,'.')    
C1 = strsplit(filename,'_');
tmp1.textdata=tmp1.textdata(2:end,1);
[a i]=sort(tmp1.textdata);

tmp2=importdata(files(6).name); % Import seq data
filename2=strtok(files(6).name,'.')    
C2 = strsplit(filename,'_');
tmp2.textdata=tmp2.textdata(2:end,1);
[b i2]=sort(tmp2.textdata);

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 450 400]);
scatter(tmp1.data(i,2),tmp2.data(i2,2),8,[.5 .5 .5],'filled','o');
set(gca,'FontSize',12,'LineWidth',1.5,'TickDir','out');

x=tmp1.data(i,2);
y=tmp2.data(i2,2);
c=mean([tmp1.data(i,6) tmp2.data(i2,6)]')';
idx=(c<.10 );
hold on;
scatter(x(idx),y(idx),8,c(idx),'filled','o');
ylabel('Withdrawal IN log_2(Fold Change)');
xlabel('Morphine Escalation IN log_2(Fold Change)');
xlim([-4 4])
ylim([-4 4])
l=lsline;
colormap(flipud(cmap))
caxis([0 .1])

plot([-4 4],[0 0],'--k');
plot([0 0],[-4 4],'--k');
r_squared = corr(x(idx),y(idx))^2
text(-3.8,3.8,strcat("Sig. Gene R^2 = ",num2str(r_squared)))
l(2).Visible="off";

pngFileName = 'Morphine v Withdrawal Input.png'; % Set the File name 
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

% Piechart
f1=figure('color','w','position',[100 100 1000 600]);
set(gca,'FontSize',16,'FontWeight','bold');
for l=1:4
tmp=importdata(files(l).name); % Import seq data
filename=strtok(files(l).name,'.');    
C = strsplit(filename,'_');
tmp.textdata=tmp.textdata(2:end,1);  
if l==1
   SFG=tmp.textdata(tmp.data(:,6)<=.2 & tmp.data(:,2)>0,1);
elseif l==2
   SMG=tmp.textdata(tmp.data(:,6)<=.2 & tmp.data(:,2)>0,1); 
elseif l==3
   UFG=tmp.textdata(tmp.data(:,6)<=.2 & tmp.data(:,2)>0,1);  
elseif l==4
   UMG=tmp.textdata(tmp.data(:,6)<=.2 & tmp.data(:,2)>0,1);   
end
end

AllGenes=[SFG;SMG;UFG;UFG];
UniqGenes=unique(AllGenes);
SFG_i=intersect(unique([SMG;UFG;UFG]),SFG);
SFG_un=length(SFG)-length(SFG_i);
SMG_i=intersect(unique([SFG;UFG;UFG]),SMG);
SMG_un=length(SMG)-length(SMG_i);
UFG_i=intersect(unique([SMG;SFG;UMG]),UFG);
UFG_un=length(UFG)-length(UFG_i);
UMG_i=intersect(unique([SMG;SFG;UFG]),UMG);
UMG_un=length(UMG)-length(UMG_i);
sumUnGenes=sum([SFG_un SMG_un UFG_un UMG_un]);
X=[(length(UniqGenes)-sumUnGenes), SFG_un, SMG_un, UFG_un, UMG_un];
h = pie(X);
colormap(jet(5));
hText = findobj(h,'Type','text'); % text object handles
percentValues = get(hText,'String'); % percent values
txt = {'Overlap (1761): ';'Stressed F (252): ';'Stressed M (245): ';'Unstressed F (46): ';'Unstressed M (307): '}; % strings
combinedtxt = strcat(txt,percentValues); % strings and percent values
oldExtents_cell = get(hText,'Extent');
oldExtents = cell2mat(oldExtents_cell); % numeric array
hText(1).String = combinedtxt(1);
hText(2).String = combinedtxt(2);
hText(3).String = combinedtxt(3);
hText(4).String = combinedtxt(4);
hText(5).String = combinedtxt(5);
newExtents_cell = get(hText,'Extent'); % cell array
newExtents = cell2mat(newExtents_cell); % numeric array 
width_change = newExtents(:,3)-oldExtents(:,3);
signValues = sign(oldExtents(:,1));
offset = signValues.*(width_change/2);
textPositions_cell = get(hText,{'Position'}); % cell array
textPositions = cell2mat(textPositions_cell); % numeric array
textPositions(:,1) = textPositions(:,1) + offset; % add offset 
hText(1).Position = textPositions(1,:);
hText(2).Position = textPositions(2,:);
hText(3).Position = textPositions(3,:);
hText(4).Position = textPositions(4,:);
hText(5).Position = textPositions(5,:);
set(hText,'FontWeight','bold','FontSize',13);
set(h,'LineWidth',2);
pngFileName = 'ControlPie.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

xlswrite('SignalGenes.xlsx',UniqGenes);