%% GSEA for enrichment
fig_fold='Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\Figures';

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\Enrichment\Molecular Function Enrichment.xlsx")
enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend')
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend')

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 800 700],'DefaultAxesFontSize',14); 
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-2.5 2.5]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
set(gca,'LineWidth',1.5);

pngFileName = 'Enrichment MF GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 800 700],'DefaultAxesFontSize',14); 
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-2.5 2.5]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
set(gca,'LineWidth',1.5);

pngFileName = 'Enrichment MF GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


%% GSEA for Morphine IP
clear all
fig_fold='Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\Figures';


t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Ethenol v Air\Molecular Function ETOH v Air IP.xlsx")
enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend');
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend');
if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.Description{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.Description{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.Description{i};
    if length(cellContents)>30
       denr.Description{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.Description{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
set(gca,'LineWidth',1.5);
title({'ETOH IP Molecular Function';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP MF GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
set(gca,'LineWidth',1.5);
title({'ETOH IP Molecular Function';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP MF GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure



%% GSEA for Morphine IP 
clearvars -except fig_fold


t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Ethenol v Air\Reactome ETOH v Air IP.xlsx")
enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend');
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend');
if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.Description{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.Description{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.Description{i};
    if length(cellContents)>30
       denr.Description{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.Description{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
set(gca,'LineWidth',1.5);
title({'ETOH IP Reactome';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP RT GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
set(gca,'LineWidth',1.5);
title({'ETOH IP Reactome';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP RT GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


%% GSEA for ETOH IP
clearvars -except fig_fold

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Ethenol v Air\TF ETOH v Air IP.xlsx")
enr=t(t.NES>0,:);
try
enr = sortrows(enr,7,'ascend');
end
    
denr=t(t.NES<0,:);
try
denr = sortrows(denr,7,'ascend');
end

if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.GeneSet{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.GeneSet{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.GeneSet{i};
    if length(cellContents)>30
       denr.GeneSet{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.GeneSet{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
try
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
end
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.GeneSet; denr.GeneSet]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'ETOH IP Trancription Factors';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP TF GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
try
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
end
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.GeneSet; denr.GeneSet]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'ETOH IP Trancription Factors';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP TF GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


%% GSEA for Morphine IP
clearvars -except fig_fold

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Withdrawal v Ethenol\Molecular Function Withdrawal v ETOH IP.xlsx")
idx=t.FDR==0;
t.FDR(idx) = 10^-4./t.NES(idx);

enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend');
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend');
if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.Description{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.Description{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.Description{i};
    if length(cellContents)>30
       denr.Description{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.Description{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Molecular Function';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP MF GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Molecular Function';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP MF GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure



%% GSEA for Morphine IP 
clearvars -except fig_fold

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Withdrawal v Ethenol\Reactome Withdrawal v ETOH IP.xlsx")
idx=t.FDR==0;
t.FDR(idx) = 10^-4./t.NES(idx);

enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend');
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend');
if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.Description{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.Description{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.Description{i};
    if length(cellContents)>30
       denr.Description{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.Description{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Reactome';'FDR<.05'},'FontWeight','normal','FontSize',8);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP RT GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Reactome';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP RT GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


%% GSEA for Morphine IP
clearvars -except fig_fold

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Withdrawal v Ethenol\TF Withdrawal v ETOH IP.xlsx")
idx=t.FDR==0;
t.FDR(idx) = 10^-4./t.NES(idx);

enr=t(t.NES>0,:);
try
enr = sortrows(enr,7,'ascend');
end

denr=t(t.NES<0,:);
denr = sortrows(denr,7,'ascend');

if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.GeneSet{i};
    if length(cellContents)>30
       enr.GeneSet{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.GeneSet{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.GeneSet{i};
    if length(cellContents)>30
       denr.GeneSet{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.GeneSet{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
try
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
end
ylim([0 9]);
xlim([-3 3]);
hold on
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.GeneSet; denr.GeneSet]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Trancription Factors';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP TF GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
try
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
end
ylim([0 9]);
xlim([-3 3]);
hold on
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.GeneSet; denr.GeneSet]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Trancription Factors';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP TF GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

%% GSEA for Morphine IP 
clearvars -except fig_fold

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Withdrawal v Ethenol\Wiki Withdrawal v ETOH IP.xlsx")
idx=t.FDR==0;
t.FDR(idx) = 10^-4./t.NES(idx);

enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend');
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend');
if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.Description{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.Description{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.Description{i};
    if length(cellContents)>30
       denr.Description{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.Description{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end
% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 450 500],'DefaultAxesFontSize',12); 
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Wiki Pathways';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP Wiki GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12); 
bp=bubbleplot2(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot2(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Withdrawal IP Wiki Pathways';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Withdrawal IP Wiki GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

%% GSEA for Morphine IP
clearvars -except fig_fold

t=readtable("Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\GSEA\IP\Ethenol v Air\Wiki ETOH v Air IP.xlsx")
idx=t.FDR==0;
t.FDR(idx) = 10^-4./t.NES(idx);

enr=t(t.NES>0,:);
enr = sortrows(enr,8,'ascend');
denr=t(t.NES<0,:);
denr = sortrows(denr,8,'ascend');
if height(enr)>10 & height(denr)>10
   enr=enr(1:10,:);
   denr=denr(1:10,:);
elseif height(enr)>10 & height(enr)+height(denr)>20
   enr=enr(1:(20-height(denr)),:);
elseif height(denr)>10 & height(enr)+height(denr)>20  
   denr=denr(1:(20-height(enr)),:);
end

for i=1:height(enr)
    cellContents = enr.Description{i};
    if length(cellContents)>30
       enr.Description{i} = [cellContents(1:28) '... (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    else
       enr.Description{i} = [cellContents(1:end) ' (' num2str(enr.LeadingEdgeNumber(i)) ')']; 
    end
    
end

for i=1:height(denr)
    cellContents = denr.Description{i};
    if length(cellContents)>30
       denr.Description{i} = [cellContents(1:28) '... (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    else
       denr.Description{i} = [cellContents(1:end) ' (' num2str(denr.LeadingEdgeNumber(i)) ')']; 
    end
end

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12);
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Ethanol IP Wiki Pathways';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP Wiki GSEA Legend.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 500 500],'DefaultAxesFontSize',12);
bp=bubbleplot(enr.NES,-log(enr.FDR),[],enr.LeadingEdgeNumber, 1-(enr.FDR), [],'ColorMap',@plasma); 
ylim([0 9]);
xlim([-3 3]);
hold on
bp2=bubbleplot(denr.NES,-log(denr.FDR),[],denr.LeadingEdgeNumber, 1-(denr.FDR), [],'ColorMap',@plasma); 
plot([0 0],[0 9],'--k');
h=legend(gca,cellstr([enr.Description; denr.Description]),'Location','eastoutside');
h.Box='off';
xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
title({'Ethanol IP Wiki Pathways';'FDR<.05'},'FontWeight','normal','FontSize',10);
set(gca,'LineWidth',1.5);

pngFileName = 'Ethanol IP Wiki GSEA Order.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INPUT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Not enough Samples...