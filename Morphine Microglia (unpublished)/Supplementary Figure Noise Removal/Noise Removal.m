%% Non Specific RNA Removal from IP Transcripts
clear all

rna_neg=5.98;
rna_t=readtable('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Negative Control\RNA Quantity 2.xlsx');

d1=dir('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Transcript Quantification\IP')
d2=dir('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Transcript Quantification\Input')
d3='Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Transcript Quantification\IP_Minus';

for i=3:length(d1)
    tmpip=readtable(fullfile(d1(i).folder,d1(i).name),'FileType','text','Delimiter','tab');
    tmpin=readtable(fullfile(d2(i).folder,d2(i).name),'FileType','text','Delimiter','tab');
    neg_prop=rna_neg/rna_t.RNA(i-2);
    tmpip.TPM=tmpip.TPM-(tmpin.TPM*neg_prop);
    tmpip.TPM(tmpip.TPM<1)=0;
    writetable(tmpip,fullfile(d3,d1(i).name),'FileType','text','Delimiter','tab');
end

%% Non Specific RNA Removal from IP Genes
clear all

rna_neg=5.98;
rna_t=readtable('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Negative Control\RNA Quantity 2.xlsx');

d1=dir('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Gene Quantification\IP')
d2=dir('Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Gene Quantification\Input')
d3='Z:\Neumaier Lab\Morphine Grant\RNA Seq 2\Gene Quantification\IP_Minus';

for i=3:length(d1)
    tmpip=readtable(fullfile(d1(i).folder,d1(i).name),'FileType','text','Delimiter','tab');
    tmpin=readtable(fullfile(d2(i).folder,d2(i).name),'FileType','text','Delimiter','tab');
    neg_prop=rna_neg/rna_t.RNA(i-2);
    tmpip.TPM=tmpip.TPM-(tmpin.TPM*neg_prop);
    tmpip.TPM(tmpip.TPM<1)=0;
    writetable(tmpip,fullfile(d3,d1(i).name),'FileType','text','Delimiter','tab');
end