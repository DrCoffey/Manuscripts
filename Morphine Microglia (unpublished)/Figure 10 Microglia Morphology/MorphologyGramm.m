%% Morphine Naloxone Behavior Figures with Gramm(You must have Gramm installed!)
% Navigate to the folder containing the code!

close all 
clear all

files=dir('.\Morphology Data\');
files=files(3:end);
for i=1:length(files)
t=readtable(fullfile(files(i).folder,files(i).name));
parts=strsplit(files(i).name,'_');
Subject=categorical(repmat(parts(2),[height(t) 1]));
tmp=strtok(parts(4),'.');
A1=categorical(repmat({tmp{1,1}(1)},[height(t) 1]));
A2=categorical(repmat({tmp{1,1}(2)},[height(t) 1]));
Group=categorical(repmat(strtok(parts(4),'.'),[height(t) 1]));
t=[table(Subject,Group,A1,A2) t];
if i==1
    mt=t;
else
    mt=[mt;t];
end
end

mt=mt(mt.CellVolume<95000,:); % Remove Double Cells
mt=mt(mt.numbranchpts>0,:); % Remove Non-Traced Cells

G = groupsummary(mt,{'Subject','Group','A1','A2'},'mean');

g(1,1)=gramm('x',mt.Group,'y',mt.CellVolume,'color',mt.Group);
g(1,2)=gramm('x',mt.Group,'y',mt.numbranchpts,'color',mt.Group);
g(1,3)=gramm('x',mt.Group,'y',mt.MeanTerminalBranchLength,'color',mt.Group);

% Violin
g(1,1).stat_violin('normalization','width','half',0,'dodge',0,'fill','transparent')
g(1,1).geom_jitter('width',.1,'dodge',1,'alpha',.5);
g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g(1,1).axe_property('LineWidth',1.5,'FontSize',12);

g(1,2).stat_violin('normalization','width','half',0,'dodge',0,'fill','transparent')
g(1,2).geom_jitter('width',.1,'dodge',1,'alpha',.5);
g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g(1,2).axe_property('LineWidth',1.5,'FontSize',12);

g(1,3).stat_violin('normalization','width','half',0,'dodge',0,'fill','transparent')
g(1,3).geom_jitter('width',.1,'dodge',1,'alpha',.5);
g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g(1,3).axe_property('LineWidth',1.5,'FontSize',12);

g(1,1).set_names('x','','y','Volume','color','Groups');
g(1,2).set_names('x','','y','Branch Points','color','Groups');
g(1,3).set_names('x','','y','End Points','color','Groups');

g(1,1).set_order_options('x',{'SS','SN','MS','MN'});
g(1,2).set_order_options('x',{'SS','SN','MS','MN'});
g(1,3).set_order_options('x',{'SS','SN','MS','MN'});

figure('Position',[100 100 1200 400]);
g.draw();

export_fig('Naloxone Morphology.png','-m5');

% 2 Way ANOVA
[V_p,V_t2,V_stats] = anovan(mt.CellVolume,{mt.A1 mt.A2},'model','interaction','varnames',{'Drug','Treatment'});
figure;
[Volume_c,~,~,~] = multcompare(V_stats,'Dimension',[1 2],'CType','dunn-sidak');

[B_p,B_t2,B_stats] = anovan(mt.numbranchpts,{mt.A1 mt.A2},'model','interaction','varnames',{'Drug','Treatment'});
figure;
[Branch_c,~,~,~] = multcompare(B_stats,'Dimension',[1 2],'CType','dunn-sidak');

[E_p,E_t2,E_stats] = anovan(mt.numendpts,{mt.A1 mt.A2},'model','interaction','varnames',{'Drug','Treatment'});
figure;
[End_c,~,~,~] = multcompare(E_stats,'Dimension',[1 2],'CType','dunn-sidak');

save('Morphology_Stats','V_p','V_t2','V_stats','Volume_c','B_p','B_t2','B_stats','Branch_c','E_p','E_t2','E_stats','End_c');

%% Individual Subjects

g(1,1)=gramm('x',G.Group,'y',G.mean_CellVolume,'color',G.Group);
g(1,2)=gramm('x',G.Group,'y',G.mean_numbranchpts,'color',G.Group);
g(1,3)=gramm('x',G.Group,'y',G.mean_numendpts,'color',G.Group);

% Violin
g(1,1).stat_violin('normalization','width','half',0,'dodge',0,'fill','transparent')
g(1,1).geom_jitter('width',.1,'dodge',1,'alpha',.5);
g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g(1,1).axe_property('LineWidth',1.5,'FontSize',12);

g(1,2).stat_violin('normalization','width','half',0,'dodge',0,'fill','transparent')
g(1,2).geom_jitter('width',.1,'dodge',1,'alpha',.5);
g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g(1,2).axe_property('LineWidth',1.5,'FontSize',12);

g(1,3).stat_violin('normalization','width','half',0,'dodge',0,'fill','transparent')
g(1,3).geom_jitter('width',.1,'dodge',1,'alpha',.5);
g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g(1,3).axe_property('LineWidth',1.5,'FontSize',12);

g(1,1).set_names('x','','y','Volume','color','Groups');
g(1,2).set_names('x','','y','Branch Points','color','Groups');
g(1,3).set_names('x','','y','End Points','color','Groups');

g(1,1).set_order_options('x',{'SS','SN','MS','MN'});
g(1,2).set_order_options('x',{'SS','SN','MS','MN'});
g(1,3).set_order_options('x',{'SS','SN','MS','MN'});

figure('Position',[100 100 1200 400]);
g.draw();

export_fig('Naloxone Morphology Individuals.png','-m5');

% 2 Way ANOVA
[V_p,V_t2,V_stats] = anovan(G.mean_CellVolume,{G.A1 G.A2},'model','interaction','varnames',{'Drug','Treatment'});
figure;
[Volume_c,~,~,~] = multcompare(V_stats,'Dimension',[1 2],'CType','dunn-sidak');

[B_p,B_t2,B_stats] = anovan(G.mean_numbranchpts,{G.A1 G.A2},'model','interaction','varnames',{'Drug','Treatment'});
figure;
[Branch_c,~,~,~] = multcompare(B_stats,'Dimension',[1 2],'CType','dunn-sidak');

[E_p,E_t2,E_stats] = anovan(G.mean_numendpts,{G.A1 G.A2},'model','interaction','varnames',{'Drug','Treatment'});
figure;
[End_c,~,~,~] = multcompare(E_stats,'Dimension',[1 2],'CType','dunn-sidak');

save('Morphology_Stats_Individuals','V_p','V_t2','V_stats','Volume_c','B_p','B_t2','B_stats','Branch_c','E_p','E_t2','E_stats','End_c');

