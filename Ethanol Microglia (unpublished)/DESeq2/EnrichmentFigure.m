% Sets Directory For Data & Figures
clear all close all
directory=uigetdir("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\DESeq2\4 DESeq2 All IP vs All IN.xlsx"); % Raw data
fig_fold="Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\DESeq2\Figures"; % Figure folder
cd(directory);
files=dir('*DESeq2*'); %find FST data files
%load('DRGenes.mat');

% Generate cmap
% lightness, chroma, hue range
lightness = [65, 65];
chroma = [75, 75];
hue = [205 385];

% colormap resolution
n = 20;
LHC = [
    linspace(lightness(1),lightness(2),n)
    linspace(chroma(1),chroma(2),n)
    linspace(hue(1),hue(2),n)
    ]';
cmap = pa_LCH2RGB(LHC);


% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 800 600]);
% title('Ribotag^+ IP vs Ribotag^- IP')
% set(gca,'Color','white')

for l=4
tmp=importdata(files(l).name); % Import seq data
filename=strtok(files(l).name,'.')    
C = strsplit(filename,'_');
tmp.textdata=tmp.textdata(2:end,1);
% G1_name=C(2);
% G2_name=C(3);
% tmp.data(isnan(tmp.data(:,6)),6)=1;


axes(gca);
set(gca,'FontSize',12,'LineWidth',1.5,'TickDir','out');
hold on;
scatter(log2(tmp.data(:,1)),tmp.data(:,2),6,[.5 .5 .5],'filled','o');
idx=(tmp.data(:,6))<.10 & (tmp.data(:,4))>0;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),6,tmp.data(idx,6),'filled','o','markerfacealpha',.6);

% scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),15,tmp.data(idx,6),'filled','v');
% %[Spectrum] = Spectromizer(256)

colormap(flipud(cmap))
caxis([0 .1])
ylim([-4 8]);
xlim([-5 15]);
%h = colorbar;
%set(get(h,'title'),'string','(FDR)');
% Create ylabel

if l==9
yticks([-4 -2 0 2 4 6 8])
yticklabels({'-4','-2','0','2','4','6','8'})
ylabel('log_2(Fold Change)');
text(0,8,'Enrichment','FontSize',12)
xlabel('log_2(TPM)');
% Create xlabel
%xlabel('log2(Mean TPM)','FontWeight','bold');
end


end
colorbar;

[B,index] = sortrows(tmp.data,4,'descend');
sgene=tmp.textdata(index);
idx=isnan(B(:,4))==0;
B=B(idx,:);
sgene=sgene(idx);
B=B(1:25,:);
sgene=sgene(1:25);

hold on
bp=bubbleplot(log2(B(:,1)),B(:,2), [],(B(:,4)), flipud([1:1:25]'), [],'ColorMap',@plasma); 
h=legend(bp,cellstr(sgene),'Location','eastoutside');
h.Box='off';

pngFileName = 'Enrichment IP.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

figure;
bubbleplot(log2(B(:,1)),B(:,2), [],B(:,4), categorical(sgene), [],'ColorMap',@hsv); 
h=legend(cellstr(sgene),'Location','eastoutside');
clickableLegend(h, unique(cellstr(sgene)), 'groups', cellstr(sgene));


%% GSEA for enrichment

t=readtable("Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\GSEA\Enrichment\MolecularFunctionENR.xlsx")
enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend')
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend')

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 800 700]);
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.Size, 1-(enr.FDR), [],'ColorMap',@spring); 
ylim([0 8]);
xlim([-2.5 2.5]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.Size, (denr.FDR), [],'ColorMap',@cool); 
plot([0 0],[0 8],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');

pngFileName = 'Enrichment MF GSEA.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

%% Between Experiment Comparison
opts=detectImportOptions("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\DESeq2\4 DESeq2 All IP vs All IN.xlsx")
etoh=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\DESeq2\4 DESeq2 All IP vs All IN.xlsx",opts);
morph=readtable("Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Enrichment\DESeq2_IP_Input - Wave 2.xlsx",opts);

[c ia ib]=intersect(morph.GeneID,etoh.GeneID);
% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 400 350]);
box off;
set(gca,'LineWidth',1.5);
hold on;
plot([-6 8],[-6 8],'--k');
scatter((morph.log2_FC_(ia)),(etoh.log2_FC_(ib)),6,'o','filled');

% Individual Significance
msig=morph(morph.P_adj<.05 & morph.log2_FC_>0,:);
esig=etoh(etoh.P_adj<.05 & etoh.log2_FC_>0,:);

[c ia ib]=intersect(msig.GeneID,etoh.GeneID);
scatter((msig.log2_FC_(ia)),(etoh.log2_FC_(ib)),6,'o','filled');

[c ia ib]=intersect(morph.GeneID,esig.GeneID);
scatter((morph.log2_FC_(ia)),(esig.log2_FC_(ib)),6,'o','filled');

[c ia ib]=intersect(msig.GeneID,esig.GeneID);
scatter((msig.log2_FC_(ia)),(esig.log2_FC_(ib)),6,'o','filled');

legend({'Ref Line','All Genes','Morphine Enrichment','ETOH Enrichment','Both'});
xlabel('Morphine Microglia Enrichment [log2(FC)]', 'FontSize',12);
ylabel('ETOH Microglia Enrichment [log2(FC)]','FontSize',12);

export_fig('Morphine vs ETOH Microglia Enrichment.png','-m3');

both_sig=esig(ib,:);
c=0;
for i=0:.5:6.5
    c=c+1;
    propsig(c)=sum(both_sig.log2_FC_ > i & both_sig.log2_FC_ < i+.5)/sum(esig.log2_FC_ > i & esig.log2_FC_ < i+.5)
end

f1=figure('color','w','position',[100 100 400 350]);
box off;
set(gca,'LineWidth',1.5);
hold on;
plot([.5:.5:7],propsig*100,'-b','LineWidth',2);
plot([.5,7],[(height(both_sig)/height(esig)*100) (height(both_sig)/height(esig)*100)],'--k','LineWidth',1);
ylim([0 100]);

xlabel('ETOH Microglia Enrichment [log2(FC)]', 'FontSize',12);
ylabel('Between Experiment Concordance (%)','FontSize',12);

export_fig('Morphine vs ETOH Microglia Enrichment Percent.png','-m3');
