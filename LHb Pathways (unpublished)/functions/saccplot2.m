
function saccplot2(a,t,choice,folder)
%% Plot everything from aim 2

switch choice
    case 'licks'
        %% Saccharin & Water Licks
        clear g
        figure('Position',[100 100 700 700]);
        g(1,1) = gramm('x',(t.condition),'y',t.S_licks,'subset',~(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Saccharin')
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).facet_grid(t.region,[],'row_labels',0);
        g(1,1).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g(1,1).set_layout_options('margin_width',[.4,0],'redraw',0,'Position',[0,0,.3,1.1])
        g(1,1).set_names('x',[],'y','Saccharin Licks');
        g(1,1).axe_property('ylim',[0 8000],'LineWidth',1.5,'FontSize',12);
        
        g(1,2) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Saccharin')
        g(1,2).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,2).geom_jitter('width',.1,'dodge',1);
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.32,0,.2,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 8000],'LineWidth',1.5,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,3).facet_grid(t.region,[]);
        g(1,3).set_names('y','Saccharin Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,3).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,3).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.65,0,.3,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,3).axe_property('ylim',[0 1500]);
        g.set_color_options('map','lch','hue_range',[25 385]+180);
        g.axe_property('TickDir','out','LineWidth',1.5,'FontSize',12);
        g.draw
        
        for i=1:2:7
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[0.00,0.74,0.84];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[0.9,1,1];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[0.00,0.74,0.84];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[0.9,1,1];
        end
        for i=2:2:8
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
        end
        
        % Stats Figure 3bfjn Fig5d
        idx=(t.condition=='C'| t.condition=='V') & t.dreadd=='hM4Di';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        idx=t.condition=='C'| t.condition=='V' & t.dreadd=='hM3Dq';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ treatment','DummyVarCoding','effects');
        lmeDRNq=anova(lme2);
        
        statarray = grpstats(t,{'region','condition','treatment','dreadd'},{'mean','sem'},'DataVars',{'H_licks','S_licks'});
        
        if nargin == 4
            name=fullfile(folder,'Fig3_p1');
            export_fig([name '_i.png'],'-m5');
            cd('C:\Users\Kevin\Desktop\LHb Pathways\stats');
            save('Fig3bfjn','lmeDRN','lmeVTA','lmeRMTG','lmeMiss','lmeAll','statarray');
            save('Fig5d','lmeDRNq');
        end
        
        
        % Stats Figure 3cgko and Fig5e
        idx=(t.condition=='ROC'| t.condition=='ROV') & t.dreadd=='hM4Di';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ region*treatment','DummyVarCoding','effects');
        lmeAll_RO=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN_RO = anova(fitlme(DZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA_RO = anova(fitlme(VZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG_RO = anova(fitlme(RZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss_RO = anova(fitlme(MZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        
        idx=(t.condition=='ROC'| t.condition=='ROV') & t.dreadd=='hM3Dq' & t.region=='DRN';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ treatment','DummyVarCoding','effects');
        lmeDQ_RO=anova(lme2);
        
        if nargin == 4
            cd('C:\Users\Kevin\Desktop\LHb Pathways\stats');
            save('Fig3cgko','lmeDRN_RO','lmeVTA_RO','lmeRMTG_RO','lmeMiss_RO','lmeAll_RO','statarray');
            save('Fig5e','lmeDQ_RO');
        end
        
        
        
        %% HM3Dq Saccharin
        clear g
        figure('Position',[100 100 700 350]);
        g(1,1) = gramm('x',(t.condition),'y',t.S_licks,'subset',~(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Saccharin')
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).facet_grid(t.region,[],'row_labels',0);
        g(1,1).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g(1,1).set_layout_options('margin_width',[.4,0],'redraw',0,'Position',[0,0,.3,1.1])
        g(1,1).set_names('x',[],'y','Saccharin Licks');
        g(1,1).axe_property('ylim',[0 8000],'LineWidth',1.5,'FontSize',12);
        
        g(1,2) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Saccharin')
        g(1,2).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,2).geom_jitter('width',.1,'dodge',1);
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.32,0,.2,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 8000],'LineWidth',1.5,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,3).facet_grid(t.region,[]);
        g(1,3).set_names('y','Saccharin Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,3).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,3).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.65,0,.3,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,3).axe_property('ylim',[0 1000]);
        g.set_color_options('map','lch','hue_range',[0 350]);
        g.axe_property('TickDir','out','LineWidth',1.5,'FontSize',12);
        g.draw
        
        for i=1:2:3
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[1,0.335223870874423,0.630060848664357];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[1,.9,.9];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[1,0.335223870874423,0.630060848664357];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[1,.9,.9];
        end
        for i=2:2:4
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[0,0.735174873139987,0.564534786031040];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[.9,1,.9];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[0,0.735174873139987,0.564534786031040];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[.9,1,.9];
        end
        
        if nargin == 4
            name=fullfile(folder,'Sacc');
            export_fig([name '_q.png'],'-m5');
        end
        
        %% Water Licks
        clear g
        figure('Position',[100 100 700 700]);
        g(1,1) = gramm('x',(t.condition),'y',t.H_licks,'subset',~(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Saccharin')
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).facet_grid(t.region,[],'row_labels',0);
        g(1,1).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g(1,1).set_layout_options('margin_width',[.4,0],'redraw',0,'Position',[0,0,.3,1.1])
        g(1,1).set_names('x',[],'y','Water Licks');
        g(1,1).axe_property('ylim',[0 1000],'LineWidth',1.5,'FontSize',12);
        
        g(1,2) = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Saccharin')
        g(1,2).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,2).geom_jitter('width',.1,'dodge',1);
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.32,0,.2,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 1000],'LineWidth',1.5,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,3).facet_grid(t.region,[]);
        g(1,3).set_names('y','Watter Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,3).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,3).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.65,0,.3,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,3).axe_property('ylim',[0 1500]);
        g.set_color_options('map','lch','hue_range',[25 385]+180);
        g.axe_property('TickDir','out','LineWidth',1.5,'FontSize',12);
        
        g.draw
        
        for i=1:2:7
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[0.00,0.74,0.84];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[0.9,1,1];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[0.00,0.74,0.84];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[0.9,1,1];
        end
        for i=2:2:8
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
        end
        
        % Stats Water Licks not in Manuscript
        idx=(t.condition=='C'| t.condition=='V') & t.dreadd=='hM4Di';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'H_licks ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        if nargin == 4
            name=fullfile(folder,'H20');
            export_fig([name '_i.png'],'-m5');
        end
        
        % Stats Figure 3dhlp & Fig5f
        idx=(t.condition=='ROC'| t.condition=='ROV') & t.dreadd=='hM4Di';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'H_licks ~ region*treatment','DummyVarCoding','effects');
        lmeAll_RO=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN_RO = anova(fitlme(DZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA_RO = anova(fitlme(VZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG_RO = anova(fitlme(RZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss_RO = anova(fitlme(MZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        
        idx=(t.condition=='ROC'| t.condition=='ROV') & t.dreadd=='hM3Dq' & t.region=='DRN';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'H_licks ~ treatment','DummyVarCoding','effects');
        lmeDQ_RO=anova(lme2);
        
        if nargin == 4
            save('Fig3dhlp','lmeDRN_RO','lmeVTA_RO','lmeRMTG_RO','lmeMiss_RO','lmeAll_RO','statarray');
            save('Fig5f','lmeDQ_RO');
        end
        
        figure('Position',[100 100 300 200]);
        g = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Reward Omission')
        g.stat_violin('normalization','width','dodge',1,'fill','transparent')
        g.geom_jitter('width',.1,'dodge',1);
        g.stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g.set_names('y','Watter Licks','x','Reward Omission','row',[],'color','Treatment');
        g.set_order_options('x',categories(t.condition),'color',[{'Veh'} {'CNO'}])
        g.axe_property('ylim',[0 1000]);
        g.set_color_options('map','lch','hue_range',[0 350]);
        g.axe_property('TickDir','out','LineWidth',1.5,'FontSize',12);
        g.draw
        
        g.results.geom_jitter_handle(1).MarkerSize=4;
        g.results.geom_jitter_handle(1).MarkerEdgeColor=[1,0.335223870874423,0.630060848664357];
        g.results.geom_jitter_handle(1).MarkerFaceColor=[1,.9,.9];
        g.results.geom_jitter_handle(2).MarkerSize=4;
        g.results.geom_jitter_handle(2).MarkerEdgeColor=[0,0.735174873139987,0.564534786031040];
        g.results.geom_jitter_handle(2).MarkerFaceColor=[.9,1,.9];
        
        if nargin == 4
            name=fullfile(folder,'H20');
            export_fig([name '_q.png'],'-m5');
        end
        
    case 'openfield'
        clear g
        figure('Position',[100 100 500 1200]);
        g(1,1) = gramm('x',a.region,'y',a.distance / 1000,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(1,1).set_names('x',[],'y','Distance (m)','lightness','');
        g(1,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,1).geom_jitter('width',.1,'dodge',1);
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).axe_property('ylim',[0 10]);
        g(2,1) = gramm('x',a.region,'y',a.nose_time_edge,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(2,1).set_names('x',[],'y','Edge time (%)','color','');
        g(2,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(2,1).geom_jitter('width',.1,'dodge',1);
        g(2,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(2,1).axe_property('ylim',[50 100]);
        
        g(3,1) = gramm('x',a.region,'y',a.nose_time_center,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(3,1).set_names('x',[],'y','Center time (%)','color','');
        g(3,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(3,1).geom_jitter('width',.1,'dodge',1);
        g(3,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(3,1).axe_property('ylim',[0 40]);
        
        g(4,1) = gramm('x',a.region,'y',a.center_crosses,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(4,1).set_names('x',[],'y','Center crossings','color','');
        g(4,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(4,1).geom_jitter('width',.1,'dodge',1);
        g(4,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(4,1).axe_property('ylim',[0 50]);
        
        g(5,1) = gramm('x',a.region,'y',a.rears,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(5,1).set_names('x',[],'y','Rears','color','');
        g(5,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(5,1).geom_jitter('width',.1,'dodge',1);
        g(5,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(5,1).axe_property('ylim',[0 80]);
        
        g.set_order_options('x',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g.axe_property('LineWidth',1.5,'FontSize',12,'TickDir','out');
        g.set_color_options('map','lch','hue_range',[25 385]+180);
        g.draw();
        
        for i=1:5
            g(i,1).results.geom_jitter_handle(1).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(1).MarkerEdgeColor=[0.00,0.74,0.84];
            g(i,1).results.geom_jitter_handle(1).MarkerFaceColor=[0.9,1,1];
            g(i,1).results.geom_jitter_handle(2).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(2).MarkerEdgeColor=[1.00,0.37,0.41];
            g(i,1).results.geom_jitter_handle(2).MarkerFaceColor=[1.00,0.9,0.9];
        end
        
        if nargin == 4
            export_fig([folder 'i_' choice],'-m5')
        end
        
        
        % Stats Figure 4
        idx=a.dreadd=='hM4Di';
        z=a(idx,:);
        z.region=removecats(z.region);
        
        % Stats Figure 4
        idx=a.dreadd=='hM3Dq';
        qz=a(idx,:);
        qz.region=removecats(qz.region);
        
        % Distance
        lme2 = fitlme(z,'distance ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'distance ~ treatment','DummyVarCoding','effects'));
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'distance ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'distance ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'distance ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'distance ~ treatment','DummyVarCoding','effects'));
        
        if nargin == 4
            cd('C:\Users\Kevin\Desktop\LHb Pathways\stats');
            save('Fig4a','lmeDRN','lmeVTA','lmeRMTG','lmeMiss','lmeAll');
            save('Fig5g','lmeDRNq');
        end
        
        % Center Time
        lme2 = fitlme(z,'nose_time_center ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        
        if nargin == 4
            save('Fig4b','lmeDRN','lmeVTA','lmeRMTG','lmeMiss','lmeAll');
            save('Fig5h','lmeDRNq');
        end
        
        % Center Crossings
        lme2 = fitlme(z,'center_crosses ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        
        if nargin == 4
            save('Fig4c','lmeDRN','lmeVTA','lmeRMTG','lmeMiss','lmeAll');
            save('Fig5i','lmeDRNq');
        end
        
        % Rears
        lme2 = fitlme(z,'rears ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'rears ~ treatment','DummyVarCoding','effects'));
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'rears ~ treatment','DummyVarCoding','effects'));
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'rears ~ treatment','DummyVarCoding','effects'));
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'rears ~ treatment','DummyVarCoding','effects'));
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'rears ~ treatment','DummyVarCoding','effects'));
        
        if nargin == 4
            save('Fig4d','lmeDRN','lmeVTA','lmeRMTG','lmeMiss','lmeAll');
            save('Fig5j','lmeDRNq');
        end
        
        % HM3Dq Open Field
        
        clear g
        figure('Position',[100 100 230 1200]);
        g(1,1) = gramm('x',a.region,'y',a.distance / 1000,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(1,1).set_names('x',[],'y','Distance travelled (m)','color','');
        g(1,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,1).geom_jitter('width',.1,'dodge',1);
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).axe_property('ylim',[0 10]);
        
        g(2,1) = gramm('x',a.region,'y',a.nose_time_edge,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(2,1).set_names('x',[],'y','Edge time (%)','color','');
        g(2,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(2,1).geom_jitter('width',.1,'dodge',1);
        g(2,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(2,1).axe_property('ylim',[50 100]);
        
        g(3,1) = gramm('x',a.region,'y',a.nose_time_center,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(3,1).set_names('x',[],'y','Center time (%)','color','');
        g(3,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(3,1).geom_jitter('width',.1,'dodge',1);
        g(3,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(3,1).axe_property('ylim',[0 40]);
        
        g(4,1) = gramm('x',a.region,'y',a.center_crosses,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(4,1).set_names('x',[],'y','Center crossings','color','');
        g(4,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(4,1).geom_jitter('width',.1,'dodge',1);
        g(4,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(4,1).axe_property('ylim',[0 50]);
        
        g(5,1) = gramm('x',a.region,'y',a.rears,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(5,1).set_names('x',[],'y','Rears','color','');
        g(5,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(5,1).geom_jitter('width',.1,'dodge',1);
        g(5,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(5,1).axe_property('ylim',[0 80]);
        
        g.set_color_options('map','lch','hue_range',[0 350]);
        g.axe_property('TickDir','out','LineWidth',1.5,'FontSize',12);
        g.set_order_options('x',[{'DRN'} {'VTA'} {'RMTg'}],'color',[{'Veh'} {'CNO'}])
        g.axe_property('TickDir','out');
        
        g.draw();
        
        for i=1:5
            g(i,1).results.geom_jitter_handle(1).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(1).MarkerEdgeColor=[1,0.335223870874423,0.630060848664357];
            g(i,1).results.geom_jitter_handle(1).MarkerFaceColor=[1,.9,.9];
            g(i,1).results.geom_jitter_handle(2).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(2).MarkerEdgeColor=[0,0.735174873139987,0.564534786031040];
            g(i,1).results.geom_jitter_handle(2).MarkerFaceColor=[.9,1,.9];
        end
        
        
        if nargin == 4
            export_fig([folder 'q_' choice],'-m5')
        end
        
end
