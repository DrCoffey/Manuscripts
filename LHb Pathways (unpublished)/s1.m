%% LHb cFos Graphing & Stats

clear all;

load("C:\Users\Kevin\Documents\GitHub\Manuscripts\LHb Pathways (unpublished)\Fos\fos1.mat");
load("C:\Users\Kevin\Documents\GitHub\Manuscripts\LHb Pathways (unpublished)\Fos\fos2.mat");


% Non-intersectional
clear g
figure('Position',[100 100 200 250]);
g= gramm('x',fos1.Treatment,'y',fos1.Fos,'color',fos1.Treatment);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g.set_names('y','# of c-Fos cells','x',[],'color','Treatment');
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.set_order_options('x',[{'Vehicle'} {'CNO'}],'color',[{'Vehicle'} {'CNO'}])
g.axe_property('TickDir','out','ylim',[0 80],'LineWidth',1.5,'FontSize',12);
g.set_layout_options('legend',0)
g.draw

% Fos Stats
lmeFos = anova(fitlme(fos1,'Fos ~ Treatment','DummyVarCoding','effects'));

export_fig('C:\Users\Kevin\Documents\GitHub\Manuscripts\LHb Pathways (unpublished)\Fos\Fos.png','-m5');
cd('C:\Users\Kevin\Documents\GitHub\Manuscripts\LHb Pathways (unpublished)\Fos\');
save('lmeFos');

% LHb to VTA intersectional 
clear g
figure('Position',[100 100 400 250]);
g= gramm('x',fos2.Histo,'y',fos2.Fos,'color',fos2.Treatment);
g.stat_violin('normalization','width','dodge',1,'fill','transparent')
g.geom_jitter('width',.1,'dodge',1);
g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
g.set_names('y','# of c-Fos cells','x',[],'color','Treatment');
g.set_color_options('map','lch','hue_range',[25 385]+180);
g.set_order_options('x',[{'Hit'} {'Miss'}],'color',[{'Vehicle'} {'CNO'}])
g.axe_property('TickDir','out','ylim',[0 80],'LineWidth',1.5,'FontSize',12);
g.draw

fos2.Treatment=removecats(fos2.Treatment);
lmeFosVTA=anova(fitlme(fos2,'Fos ~ Treatment','DummyVarCoding','effects'));

export_fig('C:\Users\Kevin\Documents\GitHub\Manuscripts\LHb Pathways (unpublished)\Fos\FosVTA.png','-m5');
cd('C:\Users\Kevin\Documents\GitHub\Manuscripts\LHb Pathways (unpublished)\Fos\');
save('lmeFosVTA');