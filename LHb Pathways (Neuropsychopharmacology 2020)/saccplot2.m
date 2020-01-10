
function saccplot2(a,t,choice,folder)
%% Plot everything from aim 2

switch choice
    case 'licks'
        %% Saccharin & Water Licks
        clear g
        figure('Position',[100 100 1000 700]);
        g(1,1) = gramm('x',(t.condition),'y',t.S_licks,'color',t.treatment,'subset',~(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Saccharin')
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).facet_grid(t.region,[],'row_labels',0);
        g(1,1).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g(1,1).set_layout_options('margin_width',[.4,0],'redraw',0,'Position',[0,0,.2,1.1])
        g(1,1).set_names('x',[],'y','Saccharin Licks');
        g(1,1).axe_property('ylim',[0 9000],'LineWidth',1.5,'FontSize',12);
        
        g(1,2) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Saccharin')
        g(1,2).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,2).geom_jitter('width',.1,'dodge',1,'alpha',.5);
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.22,0,0.1,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 9000],'LineWidth',1.2,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1,'alpha',.5);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,3).facet_grid(t.region,[],'row_labels',0);
        g(1,3).set_names('y','Saccharin Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,3).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,3).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.44,0,.2,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,3).axe_property('ylim',[0 1500]);
        
        g(1,4) = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Reward Omission')
        g(1,4).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,4).geom_jitter('width',.1,'dodge',1,'alpha',.5);
        g(1,4).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,4).facet_grid(t.region,[]);
        g(1,4).set_names('y','Water Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,4).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,4).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.66,0,.2,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,4).axe_property('ylim',[0 1500]);
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
            g(1,4).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,4).results.geom_jitter_handle(i).MarkerEdgeColor=[0.00,0.74,0.84];
            g(1,4).results.geom_jitter_handle(i).MarkerFaceColor=[0.9,1,1];
        end
        for i=2:2:8
            g(1,2).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,2).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,2).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
            g(1,3).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,3).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,3).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
            g(1,4).results.geom_jitter_handle(i).MarkerSize=4;
            g(1,4).results.geom_jitter_handle(i).MarkerEdgeColor=[1.00,0.37,0.41];
            g(1,4).results.geom_jitter_handle(i).MarkerFaceColor=[1.00,0.9,0.9];
        end
        
        % Stats Figure 3bfjn
        idx=(t.condition=='P1'| t.condition=='P2' | t.condition=='P3' | t.condition=='P4') & t.dreadd=='hM4Di';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        z.condition=removecats(z.condition);
        z.ratID=removecats(z.ratID);
        lme2 = fitlme(z,'S_licks ~ region*condition','DummyVarCoding','effects');
        lmePre=anova(lme2);
        
        % Stats Figure 3chko Fig5d
        idx=(t.condition=='C'| t.condition=='V') & t.dreadd=='hM4Di';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dDRN = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',8},z{z.region=='DRN' & z.treatment=='CNO',8}, 'independent');

        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dVTA = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',8},z{z.region=='VTA' & z.treatment=='CNO',8}, 'independent');
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dRMTG = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',8},z{z.region=='RMTg' & z.treatment=='CNO',8}, 'independent');

        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dMiss = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',8},z{z.region=='Miss' & z.treatment=='CNO',8}, 'independent');
        
        idx=t.condition=='C'| t.condition=='V' & t.dreadd=='hM3Dq';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ treatment','DummyVarCoding','effects');
        lmeDRNq=anova(lme2);
        % Effect Size
        dDRNq = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',8},z{z.region=='DRN' & z.treatment=='CNO',8}, 'independent');
    
        statarray = grpstats(t,{'region','condition','treatment','dreadd'},{'mean','sem'},'DataVars',{'H_licks','S_licks'});
        
        if nargin == 4
            cd('.\raw figures');
            export_fig('saccharin_i.png','-m5');
            cd('..\stats');
            save('Fig3bfjn','lmePre');
            save('Fig3cgko','lmeDRN','dDRN','lmeVTA','dVTA','lmeRMTG','dRMTG','lmeMiss','dMiss','lmeAll','statarray');
            save('Fig5d','lmeDRNq','dDRNq');
            cd('..\');
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
        % Effect Size
        dDRN_RO = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',8},z{z.region=='DRN' & z.treatment=='CNO',8}, 'independent');
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA_RO = anova(fitlme(VZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dVTA_RO = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',8},z{z.region=='VTA' & z.treatment=='CNO',8}, 'independent');
   
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG_RO = anova(fitlme(RZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dRMTG_RO = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',8},z{z.region=='RMTg' & z.treatment=='CNO',8}, 'independent');
       
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss_RO = anova(fitlme(MZ,'S_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dMiss_RO = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',8},z{z.region=='Miss' & z.treatment=='CNO',8}, 'independent');
        
        idx=(t.condition=='ROC'| t.condition=='ROV') & t.dreadd=='hM3Dq' & t.region=='DRN';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'S_licks ~ treatment','DummyVarCoding','effects');
        lmeDQ_RO=anova(lme2);
        % Effect Size
        dDRNq_RO = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',8},z{z.region=='DRN' & z.treatment=='CNO',8}, 'independent');

        if nargin == 4
            cd('.\stats');
            save('Fig3dhlp','lmeDRN_RO','dDRN_RO','lmeVTA_RO','dVTA_RO','lmeRMTG_RO','dRMTG_RO','lmeMiss_RO','dMiss_RO','lmeAll_RO','statarray');
            save('Fig5e','lmeDQ_RO','dDRNq_RO');
            cd('..\');
        end
        
        %% Reward Ommision Pre-Test Control HM4Di
        t2=t(t.treatment=='None' & t.dreadd == 'hM4Di',:);
        for h=1:height(t2)
            idx=t.ratID==t2.ratID(h) & (t.condition=='ROC' | t.condition=='ROV');
            t2.treatment(h)=t.treatment(idx);
        end
        
        clear g
        figure('Position',[100 100 300 700]);
        g = gramm('x',t2.condition,'y',t2.S_licks,'color',t2.treatment)
        g.stat_summary('geom',{'line','errorbar'},'type','sem','dodge',0);
        g.facet_grid(t2.region,[]);
        g.set_order_options('x',categories(t2.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g.set_layout_options('margin_width',[.4,0])
        g.set_names('x',[],'y','Saccharin Licks');
        g.axe_property('ylim',[0 5000],'LineWidth',1.5,'FontSize',12);
        g.draw
        
        % Stats Figure 3cgko and Fig5e
        idx=(t2.condition=='P1'| t2.condition=='P2' | t2.condition=='P3'| t2.condition=='P4') & t2.dreadd=='hM4Di';
        t2=t2(idx,:);
        t2.treatment=removecats(t2.treatment);
        lme2 = fitlme(t2,'S_licks ~ region*treatment','DummyVarCoding','effects');
        lmeAll_Pre=anova(lme2);
      
        if nargin == 4
            cd('.\raw figures');
            export_fig('pre-RO-Control_i.png','-m5');
            cd('..\');
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
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.32,0,.2,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 8000],'LineWidth',1.5,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.S_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,3).facet_grid(t.region,[]);
        g(1,3).set_names('y','Saccharin Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,3).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,3).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.65,0,.3,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,3).axe_property('ylim',[0 1500]);
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
            cd('.\raw figures');
            export_fig('saccharin_q.png','-m5');
            cd('..\');
        end
        
        %% Reward Ommision Pre-Test Control HM3Dq
        t2=t(t.treatment=='None' & t.dreadd == 'hM3Dq',:); % Currupt files
        for h=1:height(t2)
            idx=t.ratID==t2.ratID(h) & (t.condition=='ROC' | t.condition=='ROV');
            t2.treatment(h)=t.treatment(idx);
        end
        
        clear g
        figure('Position',[100 100 300 250]);
        g = gramm('x',t2.condition,'y',t2.S_licks,'color',t2.treatment)
        g.stat_summary('geom',{'line','errorbar'},'type','sem','dodge',0);
        g.set_order_options('x',categories(t2.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g.set_layout_options('margin_width',[.4,0])
        g.set_names('x',[],'y','Saccharin Licks');
        g.axe_property('ylim',[0 5000],'LineWidth',1.5,'FontSize',12);
        g.set_color_options('map','lch','hue_range',[0 350]);
        g.draw
        
        % Stats Figure 3cgko and Fig5e
        idx=((t2.condition=='P1'| t2.condition=='P2' | t2.condition=='P3'| t2.condition=='P4') & t2.dreadd=='hM3Dq');
        t2=t2(idx,:);
        idx=(t2.region~='Miss')
        t2=t2(idx,:);
        t2.treatment=removecats(t2.treatment);
        lme2 = fitlme(t2,'S_licks ~ treatment','DummyVarCoding','effects');
        lmeAll_PreQ=anova(lme2);
      
        if nargin == 4
            cd('.\stats');
            save('FigS3','lmeAll_Pre','lmeAll_PreQ');
            cd('..\');
            cd('.\raw figures');
            export_fig('pre-RO-Control_q.png','-m5');
            cd('..\');
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
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.32,0,.2,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 1000],'LineWidth',1.5,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM4Di' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
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
            cd('.\raw figures');
            export_fig('H20_i.png','-m5');
            cd('..\');
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
        % Effect Size
        dDRN_RO = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',7},z{z.region=='DRN' & z.treatment=='CNO',7}, 'independent');
       
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA_RO = anova(fitlme(VZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dVTA_RO = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',7},z{z.region=='VTA' & z.treatment=='CNO',7}, 'independent');

        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG_RO = anova(fitlme(RZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dRMTG_RO = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',7},z{z.region=='RMTg' & z.treatment=='CNO',7}, 'independent');

        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss_RO = anova(fitlme(MZ,'H_licks ~ treatment','DummyVarCoding','effects'));
        % Effect Size
        dMiss_RO = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',7},z{z.region=='Miss' & z.treatment=='CNO',7}, 'independent');
        
        idx=(t.condition=='ROC'| t.condition=='ROV') & t.dreadd=='hM3Dq' & t.region=='DRN';
        z=t(idx,:);
        z.treatment=removecats(z.treatment);
        lme2 = fitlme(z,'H_licks ~ treatment','DummyVarCoding','effects');
        lmeDQ_RO=anova(lme2);
        % Effect Size
        dDRNq_RO = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',7},z{z.region=='DRN' & z.treatment=='CNO',7}, 'independent');

        if nargin == 4
            cd('.\stats');
            save('Fig3eimq','lmeDRN_RO','dDRN_RO','lmeVTA_RO','dVTA_RO','lmeRMTG_RO','dRMTG_RO','lmeMiss_RO','dMiss_RO','lmeAll_RO','statarray');
            save('Fig5f','lmeDQ_RO','dDRNq_RO');
            cd('..\');
        end
        
        %% Water Licks
        clear g
        figure('Position',[100 100 700 350]);
        g(1,1) = gramm('x',(t.condition),'y',t.H_licks,'subset',~(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Saccharin')
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1);
        g(1,1).facet_grid(t.region,[],'row_labels',0);
        g(1,1).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'lightness',[{'Veh'} {'CNO'}])
        g(1,1).set_layout_options('margin_width',[.4,0],'redraw',0,'Position',[0,0,.3,1.1])
        g(1,1).set_names('x',[],'y','Water Licks');
        g(1,1).axe_property('ylim',[0 1000],'LineWidth',1.5,'FontSize',12);
        
        g(1,2) = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Saccharin')
        g(1,2).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,2).geom_jitter('width',.1,'dodge',1);
        g(1,2).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,2).facet_grid(t.region,[],'row_labels',0);
        g(1,2).set_names('y',[],'x','Test Session','row',[],'color','Treatment');
        g(1,2).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,2).set_layout_options('margin_width',[0,0],'redraw',0,'Position',[.32,0,.2,1.1],'legend',0)
        g(1,2).axe_property('YTickLabel',[],'ylim',[0 1000],'LineWidth',1.5,'FontSize',12);
        
        g(1,3) = gramm('x',t.treatment,'y',t.H_licks,'color',t.treatment,'subset',(t.treatment == 'CNO' | t.treatment == 'Veh') &  t.dreadd == 'hM3Dq' & t.RO == 'Reward Omission')
        g(1,3).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,3).geom_jitter('width',.1,'dodge',1);
        g(1,3).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,3).facet_grid(t.region,[]);
        g(1,3).set_names('y','Watter Licks','x','Reward Omission','row',[],'color','Treatment');
        g(1,3).set_order_options('x',categories(t.condition),'row',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'color',[{'Veh'} {'CNO'}])
        g(1,3).set_layout_options('margin_width',[0,.4],'redraw',0,'Position',[.65,0,.3,1.1],'legend_position',[.85,.8,.2,.2])
        g(1,3).axe_property('ylim',[0 1500]);
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
            cd('.\raw figures');
            export_fig('H20_q.png','-m5');
            cd('..\');
        end
        
    case 'openfield'
        clear g
        figure('Position',[100 100 500 800]);
        g(1,1) = gramm('x',a.treatment,'y',a.distance / 1000,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(1,1).facet_grid([],a.region);
        g(1,1).set_order_options('column',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'x',[{'Veh'} {'CNO'}])
        g(1,1).set_names('x',[],'y','Distance (m)','lightness','');
        g(1,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,1).geom_jitter('width',.1,'dodge',1);
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,1).axe_property('ylim',[0 15]);

%         g(2,1) = gramm('x',a.region,'y',a.nose_time_edge,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
%         g(2,1).set_names('x',[],'y','Edge time (%)','color','');
%         g(2,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
%         g(2,1).geom_jitter('width',.1,'dodge',1);
%         g(2,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
%         g(2,1).axe_property('ylim',[50 100]);
        
        g(2,1) = gramm('x',a.treatment,'y',a.nose_time_center,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(2,1).facet_grid([],a.region);
        g(2,1).set_order_options('column',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'x',[{'Veh'} {'CNO'}])
        g(2,1).set_names('x',[],'y','Center time (%)','color','');
        g(2,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(2,1).geom_jitter('width',.1,'dodge',1);
        g(2,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(2,1).axe_property('ylim',[0 50]);
        
        g(3,1) = gramm('x',a.treatment,'y',a.center_crosses,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(3,1).facet_grid([],a.region);
        g(3,1).set_order_options('column',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'x',[{'Veh'} {'CNO'}])
        g(3,1).set_names('x',[],'y','Center crossings','color','');
        g(3,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(3,1).geom_jitter('width',.1,'dodge',1);
        g(3,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(3,1).axe_property('ylim',[0 50]);
        
        g(4,1) = gramm('x',a.treatment,'y',a.rears,'color',a.treatment,'subset',a.dreadd == 'hM4Di')
        g(4,1).facet_grid([],a.region);
        g(4,1).set_order_options('column',[{'DRN'} {'VTA'} {'RMTg'} {'Miss'}],'x',[{'Veh'} {'CNO'}])
        g(4,1).set_names('x',[],'y','Rears','color','');
        g(4,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(4,1).geom_jitter('width',.1,'dodge',1);
        g(4,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(4,1).axe_property('ylim',[0 80]);

        g.axe_property('LineWidth',1.5,'FontSize',12,'TickDir','out');
        %g.set_color_options('map','lch','hue_range',[25 385]+180);
        g.draw();
        
        for i=1:4
            g(i,1).results.geom_jitter_handle(2).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(2).MarkerEdgeColor=[0.00,0.74,0.84];
            g(i,1).results.geom_jitter_handle(2).MarkerFaceColor=[0.9,1,1];
            g(i,1).results.geom_jitter_handle(1).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(1).MarkerEdgeColor=[1.00,0.37,0.41];
            g(i,1).results.geom_jitter_handle(1).MarkerFaceColor=[1.00,0.9,0.9];
            
            g(i,1).results.geom_jitter_handle(4).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(4).MarkerEdgeColor=[0.00,0.74,0.84];
            g(i,1).results.geom_jitter_handle(4).MarkerFaceColor=[0.9,1,1];
            g(i,1).results.geom_jitter_handle(3).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(3).MarkerEdgeColor=[1.00,0.37,0.41];
            g(i,1).results.geom_jitter_handle(3).MarkerFaceColor=[1.00,0.9,0.9];
            
            g(i,1).results.geom_jitter_handle(6).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(6).MarkerEdgeColor=[0.00,0.74,0.84];
            g(i,1).results.geom_jitter_handle(6).MarkerFaceColor=[0.9,1,1];
            g(i,1).results.geom_jitter_handle(5).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(5).MarkerEdgeColor=[1.00,0.37,0.41];
            g(i,1).results.geom_jitter_handle(5).MarkerFaceColor=[1.00,0.9,0.9];
            
            g(i,1).results.geom_jitter_handle(8).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(8).MarkerEdgeColor=[0.00,0.74,0.84];
            g(i,1).results.geom_jitter_handle(8).MarkerFaceColor=[0.9,1,1];
            g(i,1).results.geom_jitter_handle(7).MarkerSize=4;
            g(i,1).results.geom_jitter_handle(7).MarkerEdgeColor=[1.00,0.37,0.41];
            g(i,1).results.geom_jitter_handle(7).MarkerFaceColor=[1.00,0.9,0.9];
        end
        
        if nargin == 4
            cd('.\raw figures');
            export_fig('OpenField_i.png','-m5');
            cd('..\');
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
        dDRN = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',10},z{z.region=='DRN' & z.treatment=='CNO',10}, 'independent');

        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'distance ~ treatment','DummyVarCoding','effects'));
        dDRNq = computeCohen_d(qz{qz.region=='DRN' & qz.treatment=='Veh',10},qz{qz.region=='DRN' & qz.treatment=='CNO',10}, 'independent');

        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'distance ~ treatment','DummyVarCoding','effects'));
        dVTA = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',10},z{z.region=='VTA' & z.treatment=='CNO',10}, 'independent');

        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'distance ~ treatment','DummyVarCoding','effects'));
        dRMTG = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',10},z{z.region=='RMTg' & z.treatment=='CNO',10}, 'independent');
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'distance ~ treatment','DummyVarCoding','effects'));
        dMiss = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',10},z{z.region=='Miss' & z.treatment=='CNO',10}, 'independent');
        
        if nargin == 4
            cd('.\stats');
            save('Fig4abcd','lmeDRN','dDRN','lmeVTA','dVTA','lmeRMTG','dRMTG','lmeMiss','dMiss','lmeAll');
            save('Fig5g','lmeDRNq','dDRNq');
            cd('..\');
        end
        
        % Center Time
        lme2 = fitlme(z,'nose_time_center ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        dDRN = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',6},z{z.region=='DRN' & z.treatment=='CNO',6}, 'independent');
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        dDRNq = computeCohen_d(qz{qz.region=='DRN' & qz.treatment=='Veh',6},qz{qz.region=='DRN' & qz.treatment=='CNO',6}, 'independent');
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        dVTA = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',6},z{z.region=='VTA' & z.treatment=='CNO',6}, 'independent');
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        dRMTG = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',6},z{z.region=='RMTg' & z.treatment=='CNO',6}, 'independent');
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'nose_time_center ~ treatment','DummyVarCoding','effects'));
        dMiss = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',6},z{z.region=='Miss' & z.treatment=='CNO',6}, 'independent');
        
        if nargin == 4
            cd('.\stats');
            save('Fig4efgh','lmeDRN','dDRN','lmeVTA','dVTA','lmeRMTG','dRMTG','lmeMiss','dMiss','lmeAll');
            save('Fig5h','lmeDRNq','dDRNq');
            cd('..\')
        end
        
        % Center Crossings
        lme2 = fitlme(z,'center_crosses ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        dDRN = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',7},z{z.region=='DRN' & z.treatment=='CNO',7}, 'independent');
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        dDRNq = computeCohen_d(qz{qz.region=='DRN' & qz.treatment=='Veh',7},qz{qz.region=='DRN' & qz.treatment=='CNO',7}, 'independent');
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        dVTA = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',7},z{z.region=='VTA' & z.treatment=='CNO',7}, 'independent');
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        dRMTG = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',7},z{z.region=='RMTg' & z.treatment=='CNO',7}, 'independent');
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'center_crosses ~ treatment','DummyVarCoding','effects'));
        dMiss = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',7},z{z.region=='Miss' & z.treatment=='CNO',7}, 'independent');
        
        if nargin == 4
            cd('.\stats');
            save('Fig4ijkl','lmeDRN','dDRN','lmeVTA','dVTA','lmeRMTG','dRMTG','lmeMiss','dMiss','lmeAll');
            save('Fig5i','lmeDRNq','dDRNq');
            cd('..\');
        end
        
        % Rears
        lme2 = fitlme(z,'rears ~ region*treatment','DummyVarCoding','effects');
        lmeAll=anova(lme2);
        
        DZ=z(z.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRN = anova(fitlme(DZ,'rears ~ treatment','DummyVarCoding','effects'));
        dDRN = computeCohen_d(z{z.region=='DRN' & z.treatment=='Veh',8},z{z.region=='DRN' & z.treatment=='CNO',8}, 'independent');
        
        DZ=qz(qz.region=='DRN',:);
        DZ.region=removecats(DZ.region);
        lmeDRNq = anova(fitlme(DZ,'rears ~ treatment','DummyVarCoding','effects'));
        dDRNq = computeCohen_d(qz{qz.region=='DRN' & qz.treatment=='Veh',8},qz{qz.region=='DRN' & qz.treatment=='CNO',8}, 'independent');
        
        VZ=z(z.region=='VTA',:);
        VZ.region=removecats(VZ.region);
        lmeVTA = anova(fitlme(VZ,'rears ~ treatment','DummyVarCoding','effects'));
        dVTA = computeCohen_d(z{z.region=='VTA' & z.treatment=='Veh',8},z{z.region=='VTA' & z.treatment=='CNO',8}, 'independent');
        
        RZ=z(z.region=='RMTg',:);
        RZ.region=removecats(RZ.region);
        lmeRMTG = anova(fitlme(RZ,'rears ~ treatment','DummyVarCoding','effects'));
        dRMTG = computeCohen_d(z{z.region=='RMTg' & z.treatment=='Veh',8},z{z.region=='RMTg' & z.treatment=='CNO',8}, 'independent');
        
        MZ=z(z.region=='Miss',:);
        MZ.region=removecats(MZ.region);
        lmeMiss = anova(fitlme(MZ,'rears ~ treatment','DummyVarCoding','effects'));
        dMiss = computeCohen_d(z{z.region=='Miss' & z.treatment=='Veh',8},z{z.region=='Miss' & z.treatment=='CNO',8}, 'independent');
        
        if nargin == 4
            cd('.\stats');
            save('Fig4mnop','lmeDRN','dDRN','lmeVTA','dVTA','lmeRMTG','dRMTG','lmeMiss','dMiss','lmeAll');
            save('Fig5j','lmeDRNq','dDRNq');
            cd('..\');
        end
        
        % HM3Dq Open Field
        
        clear g
        figure('Position',[100 100 230 1200]);
        g(1,1) = gramm('x',a.region,'y',a.distance / 1000,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(1,1).set_names('x',[],'y','Distance travelled (m)','color','');
        g(1,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(1,1).geom_jitter('width',.1,'dodge',1);
        g(1,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(1,1).axe_property('ylim',[0 10]);
        
        g(2,1) = gramm('x',a.region,'y',a.nose_time_edge,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(2,1).set_names('x',[],'y','Edge time (%)','color','');
        g(2,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(2,1).geom_jitter('width',.1,'dodge',1);
        g(2,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(2,1).axe_property('ylim',[50 100]);
        
        g(3,1) = gramm('x',a.region,'y',a.nose_time_center,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(3,1).set_names('x',[],'y','Center time (%)','color','');
        g(3,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(3,1).geom_jitter('width',.1,'dodge',1);
        g(3,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(3,1).axe_property('ylim',[0 40]);
        
        g(4,1) = gramm('x',a.region,'y',a.center_crosses,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(4,1).set_names('x',[],'y','Center crossings','color','');
        g(4,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(4,1).geom_jitter('width',.1,'dodge',1);
        g(4,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
        g(4,1).axe_property('ylim',[0 50]);
        
        g(5,1) = gramm('x',a.region,'y',a.rears,'color',a.treatment,'subset',a.dreadd == 'hM3Dq' & a.region~='Miss')
        g(5,1).set_names('x',[],'y','Rears','color','');
        g(5,1).stat_violin('normalization','width','dodge',1,'fill','transparent')
        g(5,1).geom_jitter('width',.1,'dodge',1);
        g(5,1).stat_summary('geom',{'black_errorbar'},'type','sem','dodge',1,'width',0);
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
            cd('.\raw figures');
            export_fig('OpenField_q.png','-m5');
            cd('..\');
        end
end
