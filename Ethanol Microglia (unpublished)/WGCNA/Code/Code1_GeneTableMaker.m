clear all
w = WGCNA;

% Enter Directory of Salmon Gene Quantification for IP
directory='Z:\Russell\WGCNA - EtOH\Salmon\IP';

% File Type and Data Columns [Gene TPM]
f_type='*.tabular';
d_cols = [1 3];

% Import Samples
[MasterSheet, Genes, Headers, GeneTable] = Import_Seq(directory,f_type,d_cols);

% Enrichment Filtering
w.loadDESEQ("Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Enrichment\DESeq2_IP_Input - Wave 2.xlsx");
t=w.deseqTable;
E_Genes=t.GeneID(t.P_adj<.05 & t.Wald_Stats>0);
[C,ia,ib]=intersect(E_Genes,GeneTable.Genes);
GeneTableEnriched=GeneTable(ib,:);

% Mean Filtering log2(X)>2;
GeneTableMean=GeneTable(mean(log2(MasterSheet+1)')'>2,:);

% Variance Filtering
GeneTableVariance=GeneTable(var(log2(MasterSheet+1)')'>.25,:);

% Set Data Folder and Fraction Name
cd('Z:\Russell\WGCNA - EtOH\DataSheets');
writetable(GeneTable,'GeneTableIP_fresh.csv')
writetable(GeneTableVariance,'GeneTableIP_Variance.csv')
writetable(GeneTableMean,'GeneTableIP_Mean.csv')
writetable(GeneTableEnriched,'GeneTableIP_Enr.csv')

% Enter Directory of Salmon Gene Quantification for Input
directory='Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Gene Quantification\Input';

% File Type and Data Columns [Gene TPM]
f_type='*.tabular';
d_cols = [1 4];

% Import Samples
[MasterSheet, Genes, Headers, GeneTable] = Import_Seq(directory,f_type,d_cols);

% Mean Filtering log2(X)>2;
GeneTableMean=GeneTable(mean(log2(MasterSheet+1)')'>2,:);

% Variance Filtering
GeneTableVariance=GeneTable(var(log2(MasterSheet+1)')'>.25,:);

% Set Data Folder and Fraction Name
cd('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\WGCNA Final Pipeline\Data Sheets');
writetable(GeneTable,'GeneTableIN.csv')
writetable(GeneTableVariance,'GeneTableIN_Variance.csv')
writetable(GeneTableMean,'GeneTableIN_Mean.csv')

%% Read Depth Statistics

% Enter Directory of Salmon Gene Quantification for IP
directory='Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\Salmon\Transcript Quantification\IP';

% File Type and Data Columns [Gene TPM]
f_type='*.tabular';
d_cols = [1 4];

% Import Samples
[MasterSheet, Genes, Headers, GeneTable] = Import_Seq(directory,f_type,d_cols);
s=sum(GeneTable{:,2:25});
mReads=mean(s);
seReads=std(s)/sqrt(24);

clear MasterSheet Genes Headers GeneTable directory
cd('Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\WGCNA\Code');
% Enter Directory of Salmon Gene Quantification for IP
directory='Z:\Neumaier Lab\Ethanol Microglia Project\RNA Seq\Salmon\Transcript Quantification\Input';

% File Type and Data Columns [Gene TPM]
f_type='*.tabular';
d_cols = [1 4];

% Import Samples
[MasterSheet, Genes, Headers, GeneTable] = Import_Seq(directory,f_type,d_cols);
Is=sum(GeneTable{:,2:5});
ImReads=mean(Is);
IseReads=std(Is)/sqrt(4);
