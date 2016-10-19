%Attempt to create the concatenated nirs files:
%20151109_1534.nirs (101_JM)
%20151117_1742.nirs (102_NG) - bad?
%20151123_1706.nirs (103_JT)
%20151204_1650.nirs (104_JD) - bad?
%20151207_1750.nirs (106_AE) - bad?
%20151210_1721.nirs (108_RW)
%20151211_1652.nirs (109_LM)

cd 'C:\Users\paperspace\Dropbox\Research\Michigan\fNIRS\BelDes\fNIRS Data'
addpath(genpath('c:\users\paperspace\dropbox\fnirs\homer2'))

%Open Homer2 (fnirs data analysis interface)
Homer2_UI

%Select subject data file from file selector
%%yes to fix all errors
%%Doesn’t matter which unit cm or mm (picked cm)
%%Select process configure file or select cancel if you start from the beginning

%stimGUI>
%Trigger 1: Belief
%Trigger 2: Desire
%Trigger 3: Physical
% - Apply
% -	New condition then name it
% -	Color will change
% -	After naming all conditions save

%Process Stream GUI>
%hmrintensity2OD
%enPruneChannels - sets low signal to 80
%hmrMotionCorrectPCArecurse - correct motion artifacts, recommended for children
%hmrBandpassFilt - goes after motion correction (but not CBSi)
%hmrOD2Conc - Convert optical density to concentration
%hmrBlockAvg

%Options
% - leave everything the same except tRange for Block Avg

%Plot & Options
% - Select Group for analysis
% - Select Conc
% - Select HbO and HbR (or just HbO)
% - Select Show Grp (this shows the block avg I think)
% - Select optodes (19-L, 19-J)

%Concatenating files
%Complete initial analyses of starting files
%Put concatenation script in the same folder as the nirs files you would like to concatenated
%Make sure Homer is Open
%Run concat script in matlab and select files you would like to concatenate
%Select the data files you want to put into the concatenation
%A concatenated file will be automatically generated and saved!
