%% Morphine Naloxone DREADDs Behavior Figures with Gramm(You must have Gramm installed!)
% Navigate to the folder containing the code!

t=readtable("Statistics-Morphine CX3-HM4Di-Ribotag.xlsx");

%% Normalize to Recording Time
t.Distance=t.Distance./t.RelativeLength;
t.Normal=t.Normal./t.RelativeLength;
t.Contracted=(t.Contracted./t.RelativeLength);
t.Moving=t.Moving./t.RelativeLength;
t.Immobility=t.Immobility./t.RelativeLength;
t.Group=categorical(t.Group);

g=gramm('x',t.Genotype,'y',t.Distance,'color',t.Treatment,'Subset',t.Group=='Morphine Naloxone');
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'point','black_errorbar'},'type','sem','dodge',1);
figure('Position',[100 100 325 300]);
g.set_names('x',[],'y','Distance (cm)');
%g.set_title('Morphine Naloxone');
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.axe_property('ylim',[0 4000],'LineWidth',1.5,'FontSize',12);
g.set_order_options('color',{'Vehicle','CNO'});
g.draw();
g.export('file_name','DistanceMN','file_type','png');

g=gramm('x',t.Genotype,'y',t.Contracted,'color',t.Treatment,'Subset',t.Group=='Morphine Naloxone');
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'point','black_errorbar'},'type','sem','dodge',1);
figure('Position',[100 100 325 300]);
g.set_names('x',[],'y','Contracted (s)');
%g.set_title('Morphine Naloxone');
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.axe_property('ylim',[0 2000],'LineWidth',1.5,'FontSize',12);
g.set_order_options('color',{'Vehicle','CNO'});
g.draw();
g.export('file_name','ContractedMN','file_type','png');

g=gramm('x',t.Genotype,'y',t.Immobility,'color',t.Treatment,'Subset',t.Group=='Morphine Naloxone');
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1,'alpha',.5);
g.stat_summary('geom',{'point','black_errorbar'},'type','sem','dodge',1);
figure('Position',[100 100 325 300]);
g.set_names('x',[],'y','Immobility (s)');
%g.set_title('Naloxone');
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.axe_property('ylim',[0 2000],'LineWidth',1.5,'FontSize',12);
g.set_order_options('color',{'Vehicle','CNO'});
g.draw();
g.export('file_name','ImmobilityMN','file_type','png');