%% ORA for Turquise
fig_fold='\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Figures';
t=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Turquoise Blue.xlsx");

t = sortrows(t,5,'descend');
t.FDR(t.FDR==0)=min(t.FDR(t.FDR>0));
t2=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Turquoise Full Results.xlsx");
[c,ia,ib]=intersect(t2.geneSet,t.GeneSet,'stable');
t.Size(ib)=t2.overlap(ia);
for i=1:height(t)
    cellContents = t.Description{i};
    if length(cellContents)~=0
    if length(cellContents)>40
       t.Description{i} = [cellContents(1:37) '... (' num2str(t.Size(i)) ')']; 
    else
       t.Description{i} = [cellContents(1:end) ' (' num2str(t.Size(i)) ')']; 
    end
    end
end
t.GeneSet=categorical(t.GeneSet);
t.Description=categorical(t.Description);
t.Description(isundefined( t.Description ))=t.GeneSet(isundefined(t.Description ))

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 900 300]);
bp=bubbleplot(t.Ratio,-log(t.FDR),[],(t.Size), 1-(t.FDR), [],'ColorMap',@plasma); 
ylim([0 20]);
box off;
xlim([0 8]);
hold on
set(gca,'linewidth',1.5)
h=legend(gca,cellstr([t.Description; t.Description]),'Location','eastoutside');
h.Box='off';

xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
pngFileName = 'Turquise ORA.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure


%% ORA for Outer Space
fig_fold='\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Figures';
t=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Outer Space.xlsx")

t = sortrows(t,5,'descend');
t.FDR(t.FDR==0)=min(t.FDR(t.FDR>0));
t2=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Outer Space Full Results.xlsx");
[c,ia,ib]=intersect(t2.geneSet,t.GeneSet,'stable');
t.Size(ib)=t2.overlap(ia);
for i=1:height(t)
    cellContents = t.Description{i};
    if length(cellContents)~=0
    if length(cellContents)>40
       t.Description{i} = [cellContents(1:37) '... (' num2str(t.Size(i)) ')']; 
    else
       t.Description{i} = [cellContents(1:end) ' (' num2str(t.Size(i)) ')']; 
    end
    end
end
t.GeneSet=categorical(t.GeneSet);
t.Description=categorical(t.Description);
t.Description(isundefined( t.Description ))=t.GeneSet(isundefined(t.Description ))
 
% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 900 300]);
bp=bubbleplot(t.Ratio,-log(t.FDR),[],(t.Size), 1-(t.FDR), [],'ColorMap',@plasma); 
ylim([0 20]);
box off;
xlim([0 20]);
hold on
set(gca,'linewidth',1.5)
h=legend(gca,cellstr([t.Description; t.Description]),'Location','eastoutside');
h.Box='off';

xlabel('Normalized Enrichment');
ylabel('-log(FDR)');

pngFileName = 'Outer Space ORA.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

%% ORA for Orange yellow
fig_fold='\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Figures';
t=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Orange Yellow.xlsx")

t = sortrows(t,5,'descend');
t.FDR(t.FDR==0)=min(t.FDR(t.FDR>0));
t2=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Orange Yellow Full Results.xlsx");
[c,ia,ib]=intersect(t2.geneSet,t.GeneSet,'stable');
t.Size(ib)=t2.overlap(ia);
for i=1:height(t)
    cellContents = t.Description{i};
    if length(cellContents)~=0
    if length(cellContents)>40
       t.Description{i} = [cellContents(1:37) '... (' num2str(t.Size(i)) ')']; 
    else
       t.Description{i} = [cellContents(1:end) ' (' num2str(t.Size(i)) ')']; 
    end
    end
end
t.GeneSet=categorical(t.GeneSet);
t.Description=categorical(t.Description);
t.Description(isundefined( t.Description ))=t.GeneSet(isundefined(t.Description ))

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 900 300]);
bp=bubbleplot(t.Ratio,-log(t.FDR),[],(t.Size), 1-(t.FDR), [],'ColorMap',@plasma); 
ylim([0 20]);
box off;
xlim([0 15]);
hold on
set(gca,'linewidth',1.5)
h=legend(gca,cellstr([t.Description; t.Description]),'Location','eastoutside');
h.Box='off';

xlabel('Normalized Enrichment');
ylabel('-log(FDR)');

pngFileName = 'Orange Yellow ORA.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure

%% ORA for Dandelion
fig_fold="\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Figures";
t=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Dandelion.xlsx")

t = sortrows(t,7,'ascend');
t.FDR(t.FDR==0)=min(t.FDR(t.FDR>0));
t2=readtable("\\128.95.12.244\kcoffey\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Module ORA\Dandelion Full Results.xlsx");
[c,ia,ib]=intersect(t2.geneSet,t.GeneSet,'stable');
t.Size(ib)=t2.overlap(ia);
for i=1:height(t)
    cellContents = t.Description{i};
    if length(cellContents)~=0
    if length(cellContents)>40
       t.Description{i} = [cellContents(1:37) '... (' num2str(t.Size(i)) ')']; 
    else
       t.Description{i} = [cellContents(1:end) ' (' num2str(t.Size(i)) ')']; 
    end
    end
end
t.GeneSet=categorical(t.GeneSet);
t.Description=categorical(t.Description);
t.Description(isundefined( t.Description ))=t.GeneSet(isundefined(t.Description ))

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 900 300]);
bp=bubbleplot(t.Ratio,-log(t.FDR),[],(t.Size), 1-(t.FDR), [],'ColorMap',@plasma); 
ylim([0 20]);
box off;
xlim([0 20]);
hold on
set(gca,'linewidth',1.5)
h=legend(gca,cellstr([t.Description; t.Description]),'Location','eastoutside');
h.Box='off';

xlabel('Normalized Enrichment');
ylabel('-log(FDR)');
pngFileName = 'Dandelion ORA.png'; % Set the File name 
fullFileName = fullfile(fig_fold, pngFileName); % Add Figure Path
export_fig(fullFileName, '-m5'); % Save the Figure
