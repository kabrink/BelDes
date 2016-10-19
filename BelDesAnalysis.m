% group.procResult.dcAvg(time,HbType,channel,condition)
% time = :
% HbO: HbType = 1
% HbR: HbType = 2
% HbT: HbType = 3
% L-19: channel = 29
% J-19: channel = 25
% conditions = group.conditions.CondNamesAct

physical = find(strcmp(group.conditions.CondNamesAct, 'Physical'))
desire = find(strcmp(group.conditions.CondNamesAct, 'Desire'))
belief = find(strcmp(group.conditions.CondNamesAct, 'Belief'))

phys_L19 = mean(group.procResult.dcAvg(:, 1, 29, physical))
phys_J19 = mean(group.procResult.dcAvg(:, 1, 25, physical))
des_L19 = mean(group.procResult.dcAvg(:, 1, 29, desire))
des_J19 = mean(group.procResult.dcAvg(:, 1, 25, desire))
bel_L19 = mean(group.procResult.dcAvg(:, 1, 29, belief))
bel_J19 = mean(group.procResult.dcAvg(:, 1, 25, belief))

output = table(phys_J19, phys_L19, des_J19, des_L19, bel_J19, bel_L19)
output = {phys_J19, phys_L19, des_J19, des_L19, bel_J19, bel_L19}
