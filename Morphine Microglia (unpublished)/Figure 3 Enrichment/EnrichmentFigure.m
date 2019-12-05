%% DeSeq Graphing Figures for Enrichment
% Sets Directory For Data & Figures
clear all close all

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
tmp=importdata('DESeq2_9_IP Adj_IN.xlsx'); % Import seq data
filename=strtok('DESeq2_9_IP Adj_IN.xlsx','.')    
C = strsplit(filename,'_');
tmp.textdata=tmp.textdata(2:end,1);
axes(gca);
set(gca,'FontSize',12,'LineWidth',1.5,'TickDir','out');
hold on;
scatter(log2(tmp.data(:,1)),tmp.data(:,2),6,[.5 .5 .5],'filled','o');
idx=(tmp.data(:,6))<.10 & (tmp.data(:,4))>0;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),6,tmp.data(idx,6),'filled','o','markerfacealpha',.6);
colormap(flipud(cmap))
caxis([0 .1])
ylim([-4 8]);
xlim([-5 15]);
yticks([-4 -2 0 2 4 6 8])
yticklabels({'-4','-2','0','2','4','6','8'})
ylabel('log_2(Fold Change)');
text(0,8,'Enrichment','FontSize',12)
xlabel('log_2(TPM)');
colorbar;

% Adding Bubble Plot
[B,index] = sortrows(tmp.data,4,'descend');
sgene=tmp.textdata(index);
idx=isnan(B(:,4))==0;
B=B(idx,:);
sgene=sgene(idx);
B=B(1:25,:);
sgene=sgene(1:25);
hold on
bp=bubbleplot(log2(B(:,1)),B(:,2), [],(B(:,4)), flipud([1:1:25]'), [],'ColorMap',@spring); 
h=legend(bp,cellstr(sgene),'Location','eastoutside');
h.Box='off';
export_fig('Enrichment IP Adj.png', '-m5'); % Save the Figure


%% GSEA for enrichment

t=readtable("MolecularFunctionENR_ADJ.xlsx")
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
[h,icons]=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');

% Find the 'line' objects
icons = findobj(icons,'Type','line');
% Find lines that use a marker
icons = findobj(icons,'Marker','none','-xor');
% Resize the marker in the legend
for i=1:length(icons)
set(icons(i),'MarkerSize',8);
end

export_fig('Enrichment MF GSEA Adj.png', '-m5'); % Save the Figure