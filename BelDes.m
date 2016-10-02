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
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
while true
	[singleSubFolder, remain] = strtok(remain, ';');
	if isempty(singleSubFolder)
		break;
	end
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames);

% Process all groupResults files in those folders.
for k = 1 : numberOfFolders
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	fprintf('Processing folder %s\n', thisFolder);

	% Get groupResults files.
	filePattern = sprintf('%s\\groupResults.mat', thisFolder);
	baseFileNames = dir(filePattern);
	numberOfImageFiles = length(baseFileNames);
	% Now we have a list of all files in this folder.

	if numberOfImageFiles >= 1
		% Go through all those image files.
		for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
			fprintf('     Processing groupResults file %s\n', fullFileName);
      load(filePattern)

      % Define conditions
      [x,folderName,z] = fileparts(thisFolder);
      
      physical = find(strcmp(group.conditions.CondNamesAct, 'Physical'));
      desire = find(strcmp(group.conditions.CondNamesAct, 'Desire'));
      belief = find(strcmp(group.conditions.CondNamesAct, 'Belief'));
      start_time = find(group.procResult.tHRF>=8, 1 );
      time = transpose(group.procResult.tHRF(start_time:end));
      
      phys_L19 = group.procResult.dcAvg(start_time:end, 1, 29, physical);
      phys_J19 = group.procResult.dcAvg(start_time:end, 1, 25, physical);
      des_L19 = group.procResult.dcAvg(start_time:end, 1, 29, desire);
      des_J19 = group.procResult.dcAvg(start_time:end, 1, 25, desire);
      bel_L19 = group.procResult.dcAvg(start_time:end, 1, 29, belief);
      bel_J19 = group.procResult.dcAvg(start_time:end, 1, 25, belief);

      m_phys_L19 = mean(phys_L19);
      m_phys_J19 = mean(phys_J19);
      m_des_L19 = mean(des_L19);
      m_des_J19 = mean(des_J19);
      m_bel_L19 = mean(bel_L19);
      m_bel_J19 = mean(bel_J19);

      a_phys_L19 = sum(phys_L19);
      a_phys_J19 = sum(phys_J19);
      a_des_L19 = sum(des_L19);
      a_des_J19 = sum(des_J19);
      a_bel_L19 = sum(bel_L19);
      a_bel_J19 = sum(bel_J19);
      
      plot(time,bel_J19);
      title(sprintf('Hemodynamic Response in Channel J19 for %s',folderName));
      xlabel('Time(s)');
      ylabel('HbO');
      hold on; plot(time,des_J19,'r'); plot(time,phys_J19,'g'); hold off;
      legend('Belief','Desire','Physical');
      print(sprintf('Figures\\%s_J19', folderName),'-dpng');

      plot(time,bel_L19);
      title(sprintf('Hemodynamic Response in Channel L19 for %s',folderName));
      xlabel('Time(s)');
      ylabel('HbO');
      hold on; plot(time,des_L19,'r'); plot(time,phys_L19,'g'); hold off;
      legend('Belief','Desire','Physical');
      print(sprintf('Figures\\%s_L19', folderName),'-dpng');

      
      outputSub = table(m_phys_J19, m_phys_L19, m_des_J19, m_des_L19, m_bel_J19, m_bel_L19, a_phys_J19, a_phys_L19, a_des_J19, a_des_L19, a_bel_J19, a_bel_L19);
      output = [output; outputSub];
		end
	else
		fprintf('     Folder %s has no groupResult files in it.\n', thisFolder);
	end
end

writetable(output,'meanResults.txt')
