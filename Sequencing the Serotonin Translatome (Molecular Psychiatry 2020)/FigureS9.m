% FKBP5 IHC 3D analysis From Imaris - Coded by Kevin Coffey 20180730

close all 
clear all

Animals=readtable("Z:\Neumaier Lab\Pet1 RNAseq\IHC Timecourse\Animals.xlsx");
folders=dir('Z:\Neumaier Lab\Pet1 RNAseq\IHC Timecourse\Stats');
folders=folders(3:end);

for f=1:length(folders)
    % Extracting Names and Shit
    s=strsplit(folders(f).name,' ');
    s1=strsplit(s{3},'_');
    s2=strsplit(s{5},'_');
    ID(f)=s1(3);
    if strcmp(s2{1},'Spots');
        c(f)={'Nucleus'};
    else
        c(f)={'Cell Body'};
    end
    clear s s1 s2
    
    % Extracting Data and Shit
    files=dir([folders(f).folder '\' folders(f).name]);
    
    if mod(f,2)==0   % Even  number
        a=readtable([folders(f).folder '\' folders(f).name '\' files(3).name]);
        in=readtable([folders(f).folder '\' folders(f).name '\' files(25).name]);       
    else
        a=readtable([folders(f).folder '\' folders(f).name '\' files(3).name]);
        in=readtable([folders(f).folder '\' folders(f).name '\' files(27).name]);
    end
    
    idx=categorical(Animals.Animal)==categorical(ID(f));
    Animal(1:height(in),1)=ID(f);
    Sex(1:height(in),1)=Animals.Sex(idx);
    Hour(1:height(in),1)=Animals.Hour(idx);
    Compartment(1:height(in),1)=c(f);
    Area=a.Area;
    FKBP5=in.IntensitySum;
    NormFKBP5=FKBP5./Area;
    
    if f==1
        MasterTable=table(Animal,Sex,Hour,Compartment,Area,FKBP5,NormFKBP5);
    else
        MasterTable=[MasterTable; table(Animal,Sex,Hour,Compartment,Area,FKBP5,NormFKBP5)];
    end
  
    clear Animal Sex Hour Compartment Area FKBP5 NormFKBP5
end

MasterTable.Animal=categorical(MasterTable.Animal);
MasterTable.Sex=categorical(MasterTable.Sex);
MasterTable.Compartment=categorical(MasterTable.Compartment);
t=MasterTable;

sa = grpstats(MasterTable,{'Animal','Hour','Compartment'},'mean','DataVars',{'Area','FKBP5','NormFKBP5'})

clear g
g(1,1)=gramm('x',sa.Hour,'y',sa.mean_NormFKBP5,'color',sa.Compartment);

%Boxplots
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g.axe_property('YLim',[0 1000],'LineWidth',1,'FontSize',10);
g(1,1).set_names('x','Hours Post Stress','y','FKBP5 Intensity / um^2','color','Cellular Compartment');
figure('Position',[100 100 500 350]);
g.draw();

for i=1:6
g.results.geom_jitter_handle(i).MarkerEdgeColor=[0 0 0];
g.results.stat_boxplot(i).box_handle.FaceAlpha=.25;
end
export_fig('FKBP5 IHC.png','-m5');
