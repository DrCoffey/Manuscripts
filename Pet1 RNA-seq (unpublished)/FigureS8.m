%% qPCR Data Graphing for Pet-1 Cre Ribotag (Kevin Coffey - 2018)
close all
clear all

cd('Z:\Neumaier Lab\Pet1 RNAseq\qPCR Data\IP');
files=dir;
files=files(3:end,:);

for i=1:length(files)
    
    tmp=importdata(files(i).name);
    filename=strtok(files(i).name,'.');
    C = strsplit(filename,' ');
    Gene=repmat(categorical(C(1)),[sum(sum(~isnan(tmp.data))) 1]);
    RSTQ=tmp.data(~isnan(tmp.data));
    t=tmp.textdata{1};
    t(regexp(t,'["]'))=[];
    Group(1,1:2)=strsplit(t,' ');
    t=tmp.textdata{2};
    t(regexp(t,'["]'))=[];
    Group(2,1:2)=strsplit(t,' ');
    t=tmp.textdata{3};
    t(regexp(t,'["]'))=[];
    Group(3,1:2)=strsplit(t,' ');
    t=tmp.textdata{4};
    t(regexp(t,'["]'))=[];
    Group(4,1:2)=strsplit(t,' ');
    
    Sex=[repmat(categorical(Group(1,1)),[sum(~isnan(tmp.data(:,1))) 1])
        repmat(categorical(Group(2,1)),[sum(~isnan(tmp.data(:,2))) 1])
        repmat(categorical(Group(3,1)),[sum(~isnan(tmp.data(:,3))) 1])
        repmat(categorical(Group(4,1)),[sum(~isnan(tmp.data(:,4))) 1])
        ];
    
    Stress=[repmat(categorical(Group(1,2)),[sum(~isnan(tmp.data(:,1))) 1])
        repmat(categorical(Group(2,2)),[sum(~isnan(tmp.data(:,2))) 1])
        repmat(categorical(Group(3,2)),[sum(~isnan(tmp.data(:,3))) 1])
        repmat(categorical(Group(4,2)),[sum(~isnan(tmp.data(:,4))) 1])
        ];
    
   Fraction=[repmat(categorical({'IP'}),[sum(~isnan(tmp.data(:,1))) 1])
        repmat(categorical({'IP'}),[sum(~isnan(tmp.data(:,2))) 1])
        repmat(categorical({'IP'}),[sum(~isnan(tmp.data(:,3))) 1])
        repmat(categorical({'IP'}),[sum(~isnan(tmp.data(:,4))) 1])
        ];
    
    if i==1
        MasterTable=table(Gene,RSTQ,Sex,Stress,Fraction);
    else
        MasterTable=[MasterTable;table(Gene,RSTQ,Sex,Stress,Fraction)];
    end
end

cd('Z:\Neumaier Lab\Pet1 RNAseq\qPCR Data\Input');
files=dir;
files=files(3:end,:);

for i=1:length(files)
    
    tmp=importdata(files(i).name);
    filename=strtok(files(i).name,'.');
    C = strsplit(filename,' ');
    Gene=repmat(categorical(C(1)),[sum(sum(~isnan(tmp.data))) 1]);
    RSTQ=tmp.data(~isnan(tmp.data));
    t=tmp.textdata{1};
    t(regexp(t,'["]'))=[];
    Group(1,1:2)=strsplit(t,' ');
    t=tmp.textdata{2};
    t(regexp(t,'["]'))=[];
    Group(2,1:2)=strsplit(t,' ');
    t=tmp.textdata{3};
    t(regexp(t,'["]'))=[];
    Group(3,1:2)=strsplit(t,' ');
    t=tmp.textdata{4};
    t(regexp(t,'["]'))=[];
    Group(4,1:2)=strsplit(t,' ');
    
    Sex=[repmat(categorical(Group(1,1)),[sum(~isnan(tmp.data(:,1))) 1])
        repmat(categorical(Group(2,1)),[sum(~isnan(tmp.data(:,2))) 1])
        repmat(categorical(Group(3,1)),[sum(~isnan(tmp.data(:,3))) 1])
        repmat(categorical(Group(4,1)),[sum(~isnan(tmp.data(:,4))) 1])
        ];
    
    Stress=[repmat(categorical(Group(1,2)),[sum(~isnan(tmp.data(:,1))) 1])
        repmat(categorical(Group(2,2)),[sum(~isnan(tmp.data(:,2))) 1])
        repmat(categorical(Group(3,2)),[sum(~isnan(tmp.data(:,3))) 1])
        repmat(categorical(Group(4,2)),[sum(~isnan(tmp.data(:,4))) 1])
        ];
    
   Fraction=[repmat(categorical({'Input'}),[sum(~isnan(tmp.data(:,1))) 1])
        repmat(categorical({'Input'}),[sum(~isnan(tmp.data(:,2))) 1])
        repmat(categorical({'Input'}),[sum(~isnan(tmp.data(:,3))) 1])
        repmat(categorical({'Input'}),[sum(~isnan(tmp.data(:,4))) 1])
        ];
    
        MasterTable=[MasterTable;table(Gene,RSTQ,Sex,Stress,Fraction)];
end

cd('Z:\Neumaier Lab\Pet1 RNAseq\qPCR Data\Figures')
writetable(MasterTable,'qpcrTable.xlsx');

g(1,1)=gramm('x',MasterTable.Fraction,'y',MasterTable.RSTQ,'lightness',MasterTable.Stress,'color',MasterTable.Sex,'subset',MasterTable.Gene=='FKBP5' & MasterTable.Fraction=='IP');
g(1,2)=gramm('x',MasterTable.Fraction,'y',MasterTable.RSTQ,'lightness',MasterTable.Stress,'color',MasterTable.Sex,'subset',MasterTable.Gene=='FKBP5' & MasterTable.Fraction=='Input');

g(1,1).stat_summary('type','sem','geom',{'bar','black_errorbar'},'width',.5);
%g.geom_point('dodge',.25)
g(1,1).set_order_options('color',{'Female' 'Male'},'lightness',{'US' 'Stress'});

g(1,2).stat_summary('type','sem','geom',{'bar','black_errorbar'},'width',.5);
%g.geom_point('dodge',.25)
g(1,2).set_order_options('color',{'Female' 'Male'},'lightness',{'US' 'Stress'});


%These functions can be called on arrays of gramm objects
g(1,1).set_names('x','Fraction','y','RSTQ of FKBP5','lightness','Stress');
g(1,2).set_names('x','Fraction','y','RSTQ of FKBP5','lightness','Stress');

figure('Position',[100 100 600 300]);
g(1,1).axe_property('YLim',[0 15]);
g(1,2).axe_property('YLim',[0 70]);
g.draw();

export_fig('rstq_FKBP5_Sex.png','-m3');

g=gramm('x',MasterTable.Gene,'y',MasterTable.RSTQ,'color',MasterTable.Stress,'subset',MasterTable.Fraction=='IP');
g.stat_summary('type','sem','geom',{'bar','black_errorbar'},'width',.5);
%g.geom_point('dodge',.25)
g.set_order_options('color',{'US' 'Stress'});
g.set_title('qPCR for IP Samples');
%These functions can be called on arrays of gramm objects
g.set_names('x','Gene','y','RSTQ','lightness','Stress');
figure('Position',[100 100 1000 300]);

g.axe_property('YLim',[0 14]);
g.draw();

export_fig('rstq_IP.png','-m3');

g=gramm('x',MasterTable.Gene,'y',MasterTable.RSTQ,'color',MasterTable.Stress,'subset',MasterTable.Fraction=='Input');
g.stat_summary('type','sem','geom',{'bar','black_errorbar'},'width',.5);
%g.geom_point('dodge',.25)
g.set_order_options('color',{'US' 'Stress'});
g.set_title('qPCR for Input Samples');
%These functions can be called on arrays of gramm objects
g.set_names('x','Gene','y','RSTQ','lightness','Stress');
figure('Position',[100 100 1000 300]);

g.axe_property('YLim',[0 60]);
g.draw();

export_fig('rstq_Input.png','-m3');


%% With 24 Hour
cd('Z:\Neumaier Lab\Pet1 RNAseq\qPCR Data\Figures');
t=readtable('qpcrTableHours.xlsx');
t.Gene=categorical(t.Gene);
t.Fraction=categorical(t.Fraction);
t.Stressed=categorical(t.Stressed);
t.Sex=categorical(t.Sex);
t.Hour=categorical(t.Hour);

ZRSTQ(1:34,1)=zscore(t.RSTQ(1:34));
ZRSTQ(35:68,1)=zscore(t.RSTQ(35:68));
ZRSTQ(69:102,1)=zscore(t.RSTQ(69:102));
ZRSTQ(103:136,1)=zscore(t.RSTQ(103:136));
ZRSTQ(137:170,1)=zscore(t.RSTQ(137:170));
ZRSTQ(171:136,1)=zscore(t.RSTQ(171:136));
ZRSTQ(103:204,1)=zscore(t.RSTQ(103:204));
ZRSTQ(205:238,1)=zscore(t.RSTQ(205:238));
ZRSTQ(239:272,1)=zscore(t.RSTQ(239:272));
ZRSTQ(273:306,1)=zscore(t.RSTQ(273:306));
ZRSTQ(307:340,1)=zscore(t.RSTQ(307:340));
ZRSTQ(341:374,1)=zscore(t.RSTQ(341:374));
ZRSTQ(375:408,1)=zscore(t.RSTQ(375:408));
ZRSTQ(409:442,1)=zscore(t.RSTQ(409:442));
ZRSTQ(443:468,1)=zscore(t.RSTQ(443:468));
ZRSTQ(469:502,1)=zscore(t.RSTQ(469:502));
ZRSTQ(503:513,1)=zscore(t.RSTQ(503:513));
ZRSTQ(514:524,1)=zscore(t.RSTQ(514:524));
ZRSTQ(525:535,1)=zscore(t.RSTQ(525:535));
ZRSTQ(536:546,1)=zscore(t.RSTQ(536:546));
ZRSTQ(547:557,1)=zscore(t.RSTQ(547:557));
ZRSTQ(558:568,1)=zscore(t.RSTQ(558:568));
ZRSTQ(569:579,1)=zscore(t.RSTQ(569:579));
ZRSTQ(580:590,1)=zscore(t.RSTQ(580:590));

t=[t table(ZRSTQ)];

clear g
g=gramm('x',t.Hour,'y',t.RSTQ,'color',t.Stressed,'subset',t.Fraction=='IP' & (t.Gene=='Plin4' | t.Gene=='FKBP5' | t.Gene=='Cdkn1a'));
g.set_order_options('x',0,'color',{'Unstressed' 'Stressed'});
g.stat_boxplot('width',.5);
g.geom_jitter('width',.15,'dodge',.65);
g.facet_wrap(t.Gene,'ncol',3,'scale','independent');
%g.geom_point('dodge',.25)
g.set_title(['qPCR on IP Samples']);
%These functions can be called on arrays of gramm objects
g.set_names('x','Time after Stress','y','Normalized RSTQ','Color','Stress','column','');
figure('Position',[100 100 600 300]);
g.set_limit_extra([.05 .05],[0 .05]);
g.draw
for i=1:6
g.results.geom_jitter_handle(i).MarkerEdgeColor=[0 0 0];
g.results.geom_jitter_handle(i).MarkerSize=3;
g.results.stat_boxplot(i).box_handle.FaceAlpha=.25;
end
export_fig('IP 24h_qpcr.png','-m3');

clear g
g=gramm('x',t.Hour,'y',t.RSTQ,'color',t.Stressed,'subset',t.Fraction=='Input' & (t.Gene=='Plin4' | t.Gene=='FKBP5' | t.Gene=='Cdkn1a'));

g.set_order_options('x',0,'color',{'Unstressed' 'Stressed'});
g.stat_boxplot('width',.5,'notch',0);
g.geom_jitter('width',.15,'dodge',.65);
g.facet_wrap(t.Gene,'ncol',4,'scale','independent');
%g.geom_point('dodge',.25)
g.set_title(['qPCR on Input Samples']);
%These functions can be called on arrays of gramm objects
g.set_names('x','Time after Stress','y','Normalized RSTQ','Color','Stress','column','');
figure('Position',[100 100 600 300]);
g.set_limit_extra([.05 .05],[0 .05]);
g.draw
for i=1:6
g.results.geom_jitter_handle(i).MarkerEdgeColor=[0 0 0];
g.results.geom_jitter_handle(i).MarkerSize=3;

g.results.stat_boxplot(i).box_handle.FaceAlpha=.25;
end
export_fig('Input 24h_qpcr.png','-m3');

