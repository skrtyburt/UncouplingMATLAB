%% Uncoupling Preprocessing Workflow
% Load in your datasets
% FDG Data
load("LOAD2_18mo_FDG.mat")

% PTSM Data
load("LOAD2_18mo_PTSM.mat")

%% Male Data 
% FDG
A = LOAD2_18mo_FDG{2,2};
B = LOAD2_18mo_FDG{3,2};
uncoupling_preprocessing(A,B,27)

load("preprocessed.mat")
M_FDG_exp = z_exp_mean;
M_FDG_ref = z_ref_mean;
M_FDG_exp2ref = z_exp2ref_mean;
M_FDG_exp2ref_SEM = z_exp2ref_SEM;

writetable(t1,"Uncoupling_compdist.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Male_18mo_HFD_FDG")
writetable(t2,"Uncoupling_sharedz.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Male_18mo_HFD_FDG")

% PTSM 
A2 = LOAD2_18mo_PTSM{2,2};
B2 = LOAD2_18mo_PTSM{3,2};
uncoupling_preprocessing(A2,B2,27)
load("preprocessed.mat")
M_PTSM_exp = z_exp_mean;
M_PTSM_ref = z_ref_mean;
M_PTSM_exp2ref = z_exp2ref_mean;
M_PTSM_exp2ref_SEM = z_exp2ref_SEM;

writetable(t1,"Uncoupling_compdist.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Male_18mo_HFD_PTSM")
writetable(t2,"Uncoupling_sharedz.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Male_18mo_HFD_PTSM")

%% Female Data
% FDG
C = LOAD2_18mo_FDG{2,3};
D = LOAD2_18mo_FDG{3,3};
uncoupling_preprocessing(C,D,27)
load("preprocessed.mat")
F_FDG_exp = z_exp_mean;
F_FDG_ref = z_ref_mean;
F_FDG_exp2ref = z_exp2ref_mean;
F_FDG_exp2ref_SEM = z_exp2ref_SEM;

writetable(t1,"Uncoupling_compdist.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Female_18mo_HFD_FDG")
writetable(t2,"Uncoupling_sharedz.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Female_18mo_HFD_FDG")

% PTSM 
C2 = LOAD2_18mo_PTSM{2,3};
D2 = LOAD2_18mo_PTSM{3,3};
uncoupling_preprocessing(C2,D2,27)
load("preprocessed.mat")
F_PTSM_exp = z_exp_mean;
F_PTSM_ref = z_ref_mean;
F_PTSM_exp2ref = z_exp2ref_mean;
F_PTSM_exp2ref_SEM = z_exp2ref_SEM;


writetable(t1,"Uncoupling_compdist.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Female_18mo_HFD_PTSM")
writetable(t2,"Uncoupling_sharedz.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","Female_18mo_HFD_PTSM")

zscores_compdist = [M_FDG_ref; M_FDG_exp; F_FDG_ref; F_FDG_exp; M_PTSM_ref; M_PTSM_exp; F_PTSM_ref; F_PTSM_exp]; zscores_compdist = transpose(zscores_compdist);
zscores_sharedz = [M_FDG_ref; M_FDG_exp2ref; F_FDG_ref; F_FDG_exp2ref; M_PTSM_ref; M_PTSM_exp2ref; F_PTSM_ref;F_PTSM_exp2ref]; zscores_sharedz = transpose(zscores_sharedz);
z1 = array2table(zscores_compdist,"RowNames",{'AI','AuDMV','CPu','Cg','CC','DLO','DLIVEnt','DI','ECT','Fornix','FrA','HIP','LO','MO','PtPR','PtA','PRH','PrL','M1','S1','RSC','M2','S2','TeA','TH','VO','V1V2'}, ...
    "VariableNames",{'M_FDG_REF','M_FDG_EXP','F_FDG_REF','F_FDG_EXP','M_PTSM_REF','M_PTSM_EXP','F_PTSM_REF','F_PTSM_EXP'});
z2 = array2table(zscores_sharedz,"RowNames",{'AI','AuDMV','CPu','Cg','CC','DLO','DLIVEnt','DI','ECT','Fornix','FrA','HIP','LO','MO','PtPR','PtA','PRH','PrL','M1','S1','RSC','M2','S2','TeA','TH','VO','V1V2'}, ...
    "VariableNames",{'M_FDG_REF','M_FDG_EXP2REF','F_FDG_REF','F_FDG_EXP2REF','M_PTSM_REF','M_PTSM_EXP2REF','F_PTSM_REF','F_PTSM_EXP2REF'});

writetable(z1,"Uncoupling_compdist.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","ZScores")
writetable(z2,"Uncoupling_sharedz.xlsx","FileType","spreadsheet","UseExcel",true,"WriteRowNames",true,"WriteVariableNames",true,"Sheet","ZScores")

%%
% f2 = figure('units','inches','position',[1 1 6 2],'paperpositionmode','auto');
% histogram(z_exp(1,:),15,'DisplayStyle','bar','LineStyle','none','FaceColor','b','FaceAlpha',.1);hold on
% histogram(z_ref(1,:),15,'DisplayStyle','bar','LineStyle','none','FaceColor','r','FaceAlpha',.1);
% box off; ylim([0 5])
% title('AI Region Female 18mo HFD to Control FDG',strcat(' p=',num2str(ttest_dir_comp(1,2))),'FontSize',11)
% xlabel('Z-Score','FontSize',11)
% ylabel('Frequency','FontSize',11)
% exportgraphics(f2,[pwd '\female_18mo_test.png'],"BackgroundColor","white","Resolution",300)

%% Visualize Uncoupling Data

% Generate Scatter Plots of Male Uncoupling, Female Uncoupling, and both
% Male
f1 = figure('units','inches','PaperPositionMode','auto','Name',"Male Uncoupling");
d = scatter(M_PTSM_exp2ref,M_FDG_exp2ref,'filled','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[.3 .3 1]);
distfromzero = sqrt(M_PTSM_exp2ref.^2 + M_FDG_exp2ref.^2); d.AlphaData = distfromzero; d.MarkerFaceAlpha = 'flat'; hold on
eb(1) = errorbar(M_PTSM_exp2ref,M_FDG_exp2ref,M_PTSM_exp2ref_SEM, 'horizontal', 'LineStyle', 'none');
eb(2) = errorbar(M_PTSM_exp2ref,M_FDG_exp2ref,M_FDG_exp2ref_SEM, 'vertical', 'LineStyle', 'none');
set(eb, 'color', [.5 .5 .5], 'LineWidth', .5)
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
axis([-4 4 -4 4])
Xlm = xlim;
Ylm = ylim;
Xlb = mean(Xlm);
Ylb = Ylm(1);
xlabel("X-Axis: Cerebral Perfusion Z-Score Relative to Control","Position",[Xlb (Ylm(1)-.5)],"VerticalAlignment","bottom","HorizontalAlignment","center","FontSize",8);
ylabel("Y-Axis: Cerebral Metabolic Uptake Z-Score Relative to Control","Position",[Xlm(1) mean(Ylm)],"VerticalAlignment","bottom","HorizontalAlignment","center","Rotation",90,"FontSize",8)
legend([d],{'Male'},"Location","northwest")
legend('boxoff')

% Female
f2 = figure('units','inches','PaperPositionMode','auto','Name',"Female Uncoupling");
d = scatter(F_PTSM_exp2ref,F_FDG_exp2ref,'filled','MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 .3 .3]);
distfromzero = sqrt(F_PTSM_exp2ref.^2 + F_FDG_exp2ref.^2); d.AlphaData = distfromzero; d.MarkerFaceAlpha = 'flat'; hold on
eb(1) = errorbar(F_PTSM_exp2ref,F_FDG_exp2ref,F_PTSM_exp2ref_SEM, 'horizontal', 'LineStyle', 'none');
eb(2) = errorbar(F_PTSM_exp2ref,F_FDG_exp2ref,F_FDG_exp2ref_SEM, 'vertical', 'LineStyle', 'none');
set(eb, 'color', [.5 .5 .5], 'LineWidth', .5)
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
axis([-4 4 -4 4])
Xlm = xlim;
Ylm = ylim;
Xlb = mean(Xlm);
Ylb = .99*Ylm(1);
xlabel("X-Axis: Cerebral Perfusion Z-Score Relative to Control","Position",[Xlb (Ylm(1)-.5)],"VerticalAlignment","bottom","HorizontalAlignment","center","FontSize",8);
ylabel("Y-Axis: Cerebral Metabolic Uptake Z-Score Relative to Control","Position",[Xlm(1) mean(Ylm)],"VerticalAlignment","bottom","HorizontalAlignment","center","Rotation",90,"FontSize",8)
legend([d],{'Female'},"Location","northwest")
legend('boxoff')


% Both
f3 = figure(Units='inches',PaperPositionMode='auto',Name="Both Sexes Uncoupling");
d = scatter(M_PTSM_exp2ref,M_FDG_exp2ref,'filled','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[.3 .3 1]);
distfromzero = sqrt(M_PTSM_exp2ref.^2 + M_FDG_exp2ref.^2); d.AlphaData = distfromzero; d.MarkerFaceAlpha = 'flat'; hold on
eb(1) = errorbar(M_PTSM_exp2ref,M_FDG_exp2ref,M_PTSM_exp2ref_SEM, 'horizontal', 'LineStyle', 'none');
eb(2) = errorbar(M_PTSM_exp2ref,M_FDG_exp2ref,M_FDG_exp2ref_SEM, 'vertical', 'LineStyle', 'none');
set(eb, 'color', [.5 .5 .5], 'LineWidth', .5); hold on;
e = scatter(F_PTSM_exp2ref,F_FDG_exp2ref,'filled','MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 .3 .3]);
distfromzero = sqrt(F_PTSM_exp2ref.^2 + F_FDG_exp2ref.^2); e.AlphaData = distfromzero; e.MarkerFaceAlpha = 'flat'; hold on
eb2(1) = errorbar(F_PTSM_exp2ref,F_FDG_exp2ref,F_PTSM_exp2ref_SEM, 'horizontal', 'LineStyle', 'none');
eb2(2) = errorbar(F_PTSM_exp2ref,F_FDG_exp2ref,F_FDG_exp2ref_SEM, 'vertical', 'LineStyle', 'none');
set(eb2, 'color', [.5 .5 .5], 'LineWidth', .5)
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
axis([-4 4 -4 4])
Xlm = xlim;
Ylm = ylim;
Xlb = mean(Xlm);
Ylb = .99*Ylm(1);
xlabel("X-Axis: Cerebral Perfusion Z-Score Relative to Control","Position",[Xlb (Ylm(1)-.5)],"VerticalAlignment","bottom","HorizontalAlignment","center","FontSize",8);
ylabel("Y-Axis: Cerebral Metabolic Uptake Z-Score Relative to Control","Position",[Xlm(1) mean(Ylm)],"VerticalAlignment","bottom","HorizontalAlignment","center","Rotation",90,"FontSize",8)
legend([d e],{'Male','Female'},"Location","northwest")
legend('boxoff')

% Save outputs
exportgraphics(f1,[pwd '\Male_Output.png'],"BackgroundColor","white","Resolution",600)
exportgraphics(f2,[pwd '\Female_Output.png'],"BackgroundColor","white","Resolution",600)
exportgraphics(f3,[pwd '\MF_Output.png'],"BackgroundColor","white","Resolution",600)

%% Run connectomics on FDG and PTSM Z-Scored Data (Independent Distributions)
% Create new nested cell array of z-scored FDG and PTSM Data
zdata{1,1} = 'LOAD2 18m HFD Zscores'; zdata{2,1} = 'FDG ref'; zdata{3,1} = 'PTSM ref'; zdata{4,1} = 'FDG exp'; zdata{5,1} = 'PTSM exp'; zdata{1,2} = 'Male'; zdata{1,3} = 'Female';
zdata{2,2} = M_FDG_ref; zdata{2,3} = F_FDG_ref; zdata{3,2} = M_PTSM_ref; zdata{3,3} = F_PTSM_ref; zdata{4,2} = M_FDG_exp; zdata{4,3} = F_FDG_exp; zdata{5,2} = M_PTSM_exp; zdata{5,3} = F_PTSM_exp;

% Prepare the necessary inputs
% Add code package to matlab path. (THIS PATH WILL VARY FOR EACH USER)
addpath(genpath(pwd))
% Load V2 which has groupings of nodes into systems/networks
load('roiLabels_wGroupings.mat')

% This will load colormaps contained in the package
load('colormaps.mat')
pval = 0.05;
covariance_analysis_tier1(zdata,roi_labels,bluered_cmap,pval)

%% Run connectomics on FDG and PTSM (Shared Distribution)
zdata2{1,1} = 'LOAD2 18m HFD Zscores Shared Dist'; zdata2{2,1} = 'FDG ref'; zdata2{3,1} = 'PTSM ref'; zdata2{4,1} = 'FDG exp2ref'; zdata2{5,1} = 'PTSM exp2ref'; zdata2{1,2} = 'Male'; zdata2{1,3} = 'Female';
zdata2{2,2} = M_FDG_ref; zdata2{2,3} = F_FDG_ref; zdata2{3,2} = M_PTSM_ref; zdata2{3,3} = F_PTSM_ref; zdata2{4,2} = M_FDG_exp2ref; zdata2{4,3} = F_FDG_exp2ref; zdata2{5,2} = M_PTSM_exp2ref; zdata2{5,3} = F_PTSM_exp2ref;
covariance_analysis_tier1(zdata2,roi_labels,bluered_cmap,pval)


