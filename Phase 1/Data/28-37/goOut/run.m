goOut_matrix=[];

files = dir('*.csv');
for file = files'
    csv = readtable(file.name,'ReadRowNames',false);
    new_var=csv(1:44,1:34);
    %YourNewTable = array2table(new_var.');
    new_matrix=table2array(new_var);
    goOut_matrix=[goOut_matrix;new_matrix'];
end
disp(goOut_matrix)
csvwrite('goOut_all.csv',goOut_matrix,1,1)