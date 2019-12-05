%% DeSeq Figure for Morphine & Withdrawal

files=dir('*DESeq2*'); %find FST data files
% Generate cmap
% lightness, chroma, hue range
lightness = [65, 65];
chroma = [75, 75];
hue = [205 385];

% colormap resolution
n = 100;
LHC = [
    linspace(lightness(1),lightness(2),n)
    linspace(chroma(1),chroma(2),n)
    linspace(hue(1),hue(2),n)
    ]';
cmap = pa_LCH2RGB(LHC);

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 900 600]);
ha = tight_subplot(2,3,[.075 .075],[.1 .1],[.075 .075]) ;

for l=1:6
tmp=importdata(files(l).name); % Import seq data
filename=strtok(files(l).name,'.')    
C = strsplit(filename,'_');
tmp.textdata=tmp.textdata(2:end,1);

axes(ha(l));
set(ha,'FontSize',12,'LineWidth',1,'TickDir','out');
hold on;
scatter(log2(tmp.data(:,1)),tmp.data(:,2),6,[.5 .5 .5],'filled','o');
idx=(tmp.data(:,6))<.10;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),8,tmp.data(idx,6),'filled','o');

colormap(flipud(cmap))
caxis([0 .1])
ylim([-4 4]);
xlim([-5 15]);

if l==1
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'})
ylabel('log_2(Fold Change)');
text(-4,4,'Naloxone Alone IP','FontSize',12)
% Create xlabel
%xlabel('log2(Mean TPM)','FontWeight','bold');
end

if l==2
text(-4,4,'Morphine IP','FontSize',12)
end

if l==3
text(-4,4,'Withdrawal IP','FontSize',12)
end

if l==4
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'});
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
ylabel('log_2(Fold Change)');
% Create xlabel
xlabel('log_2(TPM)');
text(-4,4,'Naloxone Alone Input','FontSize',12)

end

if l==5
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
text(-4,4,'Morphine Input','FontSize',12)
end

if l==6
% ylabel('log2(Fold Change)','FontWeight','bold');
% Create xlabel
xticks([-5 0 5 10 15])
xticklabels({'-5','0','5','10','15'});
xlabel('log_2(TPM)');
text(-4,4,'Withdrawal Input','FontSize',12)
end

clear G1_name G2_name
end
export_fig('Morphine Differential Expression.png', '-m5'); % Save the Figure

% Plotting Noise Adjusted Defferntial Expression 
f1=figure('color','w','position',[100 100 900 300]);
ha = tight_subplot(1,3,[.075 .075],[.1 .1],[.075 .075]) ;

for l=7:9
tmp=importdata(files(l).name); % Import seq data
filename=strtok(files(l).name,'.')    
C = strsplit(filename,'_');
tmp.textdata=tmp.textdata(2:end,1);

axes(ha(l-6));
set(ha,'FontSize',12,'LineWidth',1,'TickDir','out');
hold on;
scatter(log2(tmp.data(:,1)),tmp.data(:,2),6,[.5 .5 .5],'filled','o');
idx=(tmp.data(:,6))<.10;
scatter(log2(tmp.data(idx,1)),tmp.data(idx,2),8,tmp.data(idx,6),'filled','o');

colormap(flipud(cmap))
caxis([0 .1])
ylim([-4 4]);
xlim([-5 15]);

if l==7
yticks([-2 0 2 4 6])
yticklabels({'-2','0','2','4','6'})
ylabel('log_2(Fold Change)');
text(-4,4,'Naloxone IP Adjusted','FontSize',12)
xlabel('log_2(TPM)');
end

if l==8
text(-4,4,'Morphine IP Adjusted','FontSize',12)
xlabel('log_2(TPM)');
end

if l==9
text(-4,4,'Withdrawal IP Adjusted','FontSize',12)
xlabel('log_2(TPM)');
end
end
export_fig('Morphine Differential Expression Noise Adjusted.png', '-m5'); % Save the Figure

%% IP Morphine v Withdrawal
tmp1=importdata(files(8).name); % Import seq data
filename1=strtok(files(8).name,'.')    
C1 = strsplit(filename,'_');
tmp1.textdata=tmp1.textdata(2:end,1);
[a i]=sort(tmp1.textdata);

tmp2=importdata(files(9).name); % Import seq data
filename2=strtok(files(9).name,'.')    
C2 = strsplit(filename,'_');
tmp2.textdata=tmp2.textdata(2:end,1);
[b i2]=sort(tmp2.textdata);

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 450 400]);
scatter(tmp1.data(i,2),tmp2.data(i2,2),8,[.5 .5 .5],'filled','o');
set(gca,'FontSize',12,'LineWidth',1.5,'TickDir','out');

x=tmp1.data(i,2);
y=tmp2.data(i2,2);
c=mean([tmp1.data(i,6) tmp2.data(i2,6)]')';
idx=(c<.10 );
hold on;
scatter(x(idx),y(idx),8,c(idx),'filled','o');
ylabel('Withdrawal IP log_2(Fold Change)');
xlabel('Morphine Escalation IP log_2(Fold Change)');
xlim([-4 4])
ylim([-4 4])
l=lsline;
colormap(flipud(cmap))
caxis([0 .1])

plot([-4 4],[0 0],'--k');
plot([0 0],[-4 4],'--k');
r_squared = corr(x(idx),y(idx))^2
text(-3.8,3.8,strcat("Sig. Gene R^2 = ",num2str(r_squared)))

r_squared = corr(tmp1.data(i,2),tmp2.data(i2,2))^2
% text(-3.8,3.4,strcat("All Gene R^2 = ",num2str(r_squared)))
l(2).Visible="off";
export_fig('Morphine v Withdrawal.png', '-m5'); % Save the Figure
colorbar;


%% for Input
tmp1=importdata(files(5).name); % Import seq data
filename1=strtok(files(5).name,'.')    
C1 = strsplit(filename,'_');
tmp1.textdata=tmp1.textdata(2:end,1);
[a i]=sort(tmp1.textdata);

tmp2=importdata(files(6).name); % Import seq data
filename2=strtok(files(6).name,'.')    
C2 = strsplit(filename,'_');
tmp2.textdata=tmp2.textdata(2:end,1);
[b i2]=sort(tmp2.textdata);

% Plotting Defferntial Expression 
f1=figure('color','w','position',[100 100 450 400]);
scatter(tmp1.data(i,2),tmp2.data(i2,2),8,[.5 .5 .5],'filled','o');
set(gca,'FontSize',12,'LineWidth',1.5,'TickDir','out');

x=tmp1.data(i,2);
y=tmp2.data(i2,2);
c=mean([tmp1.data(i,6) tmp2.data(i2,6)]')';
idx=(c<.10 );
hold on;
scatter(x(idx),y(idx),8,c(idx),'filled','o');
ylabel('Withdrawal IN log_2(Fold Change)');
xlabel('Morphine Escalation IN log_2(Fold Change)');
xlim([-4 4])
ylim([-4 4])
l=lsline;
colormap(flipud(cmap))
caxis([0 .1])

plot([-4 4],[0 0],'--k');
plot([0 0],[-4 4],'--k');
r_squared = corr(x(idx),y(idx))^2
text(-3.8,3.8,strcat("Sig. Gene R^2 = ",num2str(r_squared)))
l(2).Visible="off";

export_fig('Morphine v Withdrawal Input.png', '-m5'); % Save the Figure

