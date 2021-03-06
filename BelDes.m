% Start with a folder and get a list of all subfolders.
% Finds and prints names of all PNG, JPG, and TIF images in
% that folder and all of its subfolders.
clc;    % Clear the command window.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;

output = table();

% Define a starting folder.
start_path = fullfile(matlabroot, 'C:\Users\paperspace\Dropbox\Research\Michigan\fNIRS\BelDes');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
	return;
end

[x,topLevelFolderName,z] = fileparts(topLevelFolder);

filePattern = sprintf('%s\\groupResults.mat', topLevelFolder);
load(filePattern)

for k = 1 : length(group.subjs)
     
      physical = find(strcmp(group.conditions.CondNamesAct, 'Physical'));
      desire = find(strcmp(group.conditions.CondNamesAct, 'Desire'));
      belief = find(strcmp(group.conditions.CondNamesAct, 'Belief'));
      baseline = find(strcmp(group.conditions.CondNamesAct, 'Baseline'));

      baseline_start = find(group.subjs(k).procResult.tHRF>=0,1);
      baseline_end = find(group.subjs(k).procResult.tHRF<=15,1,'last');
      
      %Extract concentrations for each channel and condition
      phys_L19 = group.subjs(k).procResult.dcAvg(:, 1, 29, physical);
      phys_J19 = group.subjs(k).procResult.dcAvg(:, 1, 25, physical);
      phys_L19_HbR = group.subjs(k).procResult.dcAvg(:, 2, 29, physical);
      phys_J19_HbR = group.subjs(k).procResult.dcAvg(:, 2, 25, physical);
      des_L19 = group.subjs(k).procResult.dcAvg(:, 1, 29, desire);
      des_J19 = group.subjs(k).procResult.dcAvg(:, 1, 25, desire);
      des_L19_HbR = group.subjs(k).procResult.dcAvg(:, 2, 29, desire);
      des_J19_HbR = group.subjs(k).procResult.dcAvg(:, 2, 25, desire);
      bel_L19 = group.subjs(k).procResult.dcAvg(:, 1, 29, belief);
      bel_J19 = group.subjs(k).procResult.dcAvg(:, 1, 25, belief);
      bel_L19_HbR = group.subjs(k).procResult.dcAvg(:, 2, 29, belief);
      bel_J19_HbR = group.subjs(k).procResult.dcAvg(:, 2, 25, belief);
      base_L19 = group.subjs(k).procResult.dcAvg(baseline_start:baseline_end, 1, 29, baseline);
      base_J19 = group.subjs(k).procResult.dcAvg(baseline_start:baseline_end, 1, 25, baseline);
      
      %Mean HbO calculations
      mean_start = find(group.subjs(k).procResult.tHRF>=0, 1 );
      
      mean_phys_L19 = mean(phys_L19(mean_start:end));
      mean_phys_J19 = mean(phys_J19(mean_start:end));
      mean_des_L19 = mean(des_L19(mean_start:end));
      mean_des_J19 = mean(des_J19(mean_start:end));
      mean_bel_L19 = mean(bel_L19(mean_start:end));
      mean_bel_J19 = mean(bel_J19(mean_start:end));
      mean_base_L19 = mean(base_L19);
      mean_base_J19 = mean(base_J19);
      
      %Area under curve calculations
      area_start = find(group.subjs(k).procResult.tHRF>=5.5, 1 );
      area_end = find(group.subjs(k).procResult.tHRF<=20.5, 1,'last' );

      area_phys_L19 = sum(phys_L19(area_start:area_end));
      area_phys_J19 = sum(phys_J19(area_start:area_end));
      area_des_L19 = sum(des_L19(area_start:area_end));
      area_des_J19 = sum(des_J19(area_start:area_end));
      area_bel_L19 = sum(bel_L19(area_start:area_end));
      area_bel_J19 = sum(bel_J19(area_start:area_end));
      area_base_L19 = sum(base_L19);
      area_base_J19 = sum(base_J19);
      
      %Max HbO calculations
      max_start = find(group.subjs(k).procResult.tHRF>=2, 1 );
      max_end = find(group.subjs(k).procResult.tHRF<=24, 1, 'last');
      
      max_phys_L19 = max(phys_L19(max_start:max_end));
      max_phys_J19 = max(phys_J19(max_start:max_end));
      max_des_L19 = max(des_L19(max_start:max_end));
      max_des_J19 = max(des_J19(max_start:max_end));
      max_bel_L19 = max(bel_L19(max_start:max_end));
      max_bel_J19 = max(bel_J19(max_start:max_end));
      
      %Plot calculations
      plot_phys_L19 = phys_L19 - mean(phys_L19(1:10));
      plot_phys_J19 = phys_J19 - mean(phys_J19(1:10));
      plot_des_L19 = des_L19 - mean(des_L19(1:10));
      plot_des_J19 = des_J19 - mean(des_J19(1:10));
      plot_bel_L19 = bel_L19 - mean(bel_L19(1:10));
      plot_bel_J19 = bel_J19 - mean(bel_J19(1:10));
      plot_phys_L19_HbR = phys_L19_HbR - mean(phys_L19_HbR(1:10));
      plot_phys_J19_HbR = phys_J19_HbR - mean(phys_J19_HbR(1:10));
      plot_des_L19_HbR = des_L19_HbR - mean(des_L19_HbR(1:10));
      plot_des_J19_HbR = des_J19_HbR - mean(des_J19_HbR(1:10));
      plot_bel_L19_HbR = bel_L19_HbR - mean(bel_L19_HbR(1:10));
      plot_bel_J19_HbR = bel_J19_HbR - mean(bel_J19_HbR(1:10));
      
      time = group.subjs(k).procResult.tHRF(:);
            
      subplot(2,3,1); plot(time,plot_bel_J19);
      title(sprintf('Belief HRF in \n Channel J19 for %s',group.subjs(k).name));
      xlabel('Time(s)');
      ylabel('Conc');
      xlim([-5,30]);
      hold on; plot(time,plot_bel_J19_HbR,'--b'); hold off;
      legend('HbO','HbR');

      subplot(2,3,2); plot(time,plot_des_J19,'r');
      title(sprintf('Desire HRF in \n Channel J19 for %s',group.subjs(k).name));
      xlabel('Time(s)');
      ylabel('Conc');
      xlim([-5,30]);
      hold on; plot(time,plot_des_J19_HbR,'--r'); hold off;
      legend('HbO','HbR');
      
      subplot(2,3,3); plot(time,plot_phys_J19,'g');
      title(sprintf('Physical HRF in \n Channel J19 for %s',group.subjs(k).name));
      xlabel('Time(s)');
      ylabel('Conc');
      xlim([-5,30]);
      hold on; plot(time,plot_phys_J19_HbR,'--g'); hold off;
      legend('HbO','HbR');
      
      subplot(2,3,4); plot(time,plot_bel_L19);
      title(sprintf('Belief HRF in \n Channel L19 for %s',group.subjs(k).name));
      xlabel('Time(s)');
      ylabel('Conc');
      xlim([-5,30]);
      hold on; plot(time,plot_bel_L19_HbR,'--b'); hold off;
      legend('HbO','HbR');

      subplot(2,3,5); plot(time,plot_des_L19,'r');
      title(sprintf('Desire HRF in \n Channel L19 for %s',group.subjs(k).name));
      xlabel('Time(s)');
      ylabel('Conc');
      xlim([-5,30]);
      hold on; plot(time,plot_des_L19_HbR,'--r'); hold off;
      legend('HbO','HbR');
      
      subplot(2,3,6); plot(time,plot_phys_L19,'g');
      title(sprintf('Physical HRF in \n Channel J19 for %s',group.subjs(k).name));
      xlabel('Time(s)');
      ylabel('Conc');
      xlim([-5,30]);
      hold on; plot(time,plot_phys_L19_HbR,'--g'); hold off;
      legend('HbO','HbR');
      
      figureFolder = fullfile(sprintf('%s\\Figures\\%s',pwd,topLevelFolderName));
      if ~exist(figureFolder)
        mkdir('Figures', sprintf('%s',topLevelFolderName));
      end
      
      print(sprintf('Figures\\%s\\%s', topLevelFolderName,group.subjs(k).name),'-dpng');
      fprintf('Processing %s\n', group.subjs(k).name)
      
      subID = cellstr(group.subjs(k).name);
      outputSub = table(subID, mean_phys_J19, mean_phys_L19, mean_des_J19, mean_des_L19, mean_bel_J19, mean_bel_L19, mean_base_J19, mean_base_L19, area_phys_J19, area_phys_L19, area_des_J19, area_des_L19, area_bel_J19, area_bel_L19, area_base_J19, area_base_L19, max_phys_J19, max_phys_L19, max_des_J19, max_des_L19, max_bel_J19, max_bel_L19);
      output = [output; outputSub];
end


writetable(output,sprintf('meanResults_%s.txt',topLevelFolderName));
